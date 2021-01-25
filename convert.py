import argparse
import os
import re
import json


error_string = "***error***"


parser = argparse.ArgumentParser(description='Parse KPP File with many unstated assumptions on format.')
parser.add_argument('filename', metavar='filename', type=str, nargs=None,
                    help='kpp file to be digested')
args = parser.parse_args()


def clean_split(string, token):
  split_string = string.split(token)
  clean_split_string = [var for var in split_string if var]
  trimmed_clean_split_string = [var.strip() for var in clean_split_string]
  return trimmed_clean_split_string

def convert_string_to_float(string_number):
  if "_dp"==string_number[-3:]:
    string_number = string_number[:-3]
  elif "_real"==string_number[-5:]:
    string_number = string_number[:-5]
  if (string_number.find("D")): # 1.5D-3
    string_number = string_number.replace("D","e")
  if (string_number.find("d")): # 1.5D-3
    string_number = string_number.replace("d","e")
  try:
    converted_number = float(string_number)
  except:
    converted_number = error_string+":"+string_number
  return converted_number


def unknown(camp_reaction):
  rate_constant = camp_reaction["rate constant"].strip()
  camp_reaction["type"]=error_string
  camp_reaction["error"]=error_string
  return 
def constant(camp_reaction):
  rate_constant = camp_reaction["rate constant"].strip()
  value = convert_string_to_float(rate_constant)
  camp_reaction["type"]="ARRHENIUS"
  camp_reaction["A"]=value
  return 
def arrhenius(camp_reaction):
  rate_constant = camp_reaction["rate constant"].strip()
  arguments=re.search('\(([^)]+)', rate_constant).group(1)
  arg_array=clean_split(arguments,",")
  A = convert_string_to_float(arg_array[0])
  C = convert_string_to_float(arg_array[1])
  camp_reaction["type"]="ARRHENIUS"
  camp_reaction["A"]=A
  camp_reaction["C"]=C
  return

def wrf_chem_to_CAMP(camp_reaction):
  # guess the type of reaction from the text of the rate constant
  rate_constant = camp_reaction["rate constant"].strip()
  if "*" in rate_constant:
    unknown(camp_reaction)
  elif 0==rate_constant.find("ARR2"):
    arrhenius(camp_reaction)
  elif 0==rate_constant.find("TROE"):
    camp_reaction["type"]="TROE"
    camp_reaction["error"]=error_string
  elif 0==rate_constant.find("TROEE"):
    camp_reaction["type"]="TROEE"
    camp_reaction["error"]=error_string
  elif 0==rate_constant.find("j"):
    camp_reaction["type"]="PHOTOLYSIS"
    camp_reaction["link"]=camp_reaction["rate constant"]
    camp_reaction["error"]=error_string
    #camp_reaction["reactants"].pop("hv")   # assume this reactant is listed
  elif rate_constant.endswith("_dp"):
    constant(camp_reaction)
  elif ("D" in rate_constant or "d" in rate_constant or "E" in rate_constant or "e" in rate_constant) and not "(" in rate_constant:
    constant(camp_reaction)
  else:
    unknown(camp_reaction)
  camp_reaction.pop("rate constant")  # remove entry
  return
  

def is_convertable_to_float(value):
  try:
    float(value)
    return True
  except:
    return False

def coefficient_and_molecule( product_string ):
  product_search = re.search(r"[A-z]\S*" ,product_string)
  if(product_search):
    molecule = product_search.group()
  else:
    molecule = error_string

  coeff_search=re.match(r"\d*\.?\d*",product_string)
  if(coeff_search):
    stoic_coeff = coeff_search.group()
    if stoic_coeff:
      if is_convertable_to_float(stoic_coeff):
        num = float(stoic_coeff)
      else:
        num = error_string
    else:
      num = ""

  return([molecule,num])

## Load kpp file
with open(args.filename,'r') as file:
  camp_file = {
    "source filename":args.filename,
    "ignored_lines":[],
    "reaction":[]
  }
  for line in file:
    if line.startswith('#'):            ## skip over comments
      camp_file["ignored_lines"].append(line)
      continue
    if line.startswith('//'):           ## skip over section heads
      camp_file["ignored_lines"].append(line)
      continue

    camp_reaction = {
      "wrf-kpp specification":line,
    }
    line=line.strip()                   ## remove starting and ending whitespace
    line=re.sub(r"{.*?}", "", line)     ## remove {}-delimited KPP comments
    line=re.sub(r";", "", line)         ## remove anything following ;
    line=line.strip()                   ## remove starting and ending whitespace
    [reaction, camp_reaction["rate constant"]] = clean_split(line, ":")   

    wrf_chem_to_CAMP(camp_reaction)

    [reactant_string, product_string] = clean_split(reaction, "=")   

    camp_reaction["reactants"]={}
    reactant_array=clean_split(reactant_string, "+")
    for reactant in reactant_array:
      camp_reaction["reactants"][reactant]={}
    if camp_reaction["type"] == "PHOTOLYSIS":  # "hv" is listed as a reactant in wrf file for photodecomposition
      camp_reaction["reactants"].pop("hv")

    product_and_yield_strings_array=clean_split(product_string, "+")
    camp_reaction["products"] = {}
    for product_and_yield in product_and_yield_strings_array:
      [molecule,num]=coefficient_and_molecule(product_and_yield)
      if num:
        camp_reaction["products"][molecule]={"yield":num}
      else:
        camp_reaction["products"][molecule]={}

    camp_file["reaction"].append(camp_reaction)

    camp_version_json = json.dumps(camp_file, indent=4)

  print(camp_version_json)


