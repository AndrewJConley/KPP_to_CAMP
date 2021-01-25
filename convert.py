import argparse
import os
import re
import json

error_string = "***error***"

parser = argparse.ArgumentParser(description='Parse KPP File with many unstated assumptions on format.')
parser.add_argument('filename', metavar='filename', type=str, nargs=None,
                    help='kpp file to be digested')
#parser.add_argument('--outfile', type=str, nargs='?', default='parsed_file',
#                    help='filename containing json of parsed data')
args = parser.parse_args()

## Function to split based on a token and .trim
def clean_split(string, token):
  split_string = string.split(token)
  clean_split_string = [var for var in split_string if var]
  trimmed_clean_split_string = [var.strip() for var in clean_split_string]
  return trimmed_clean_split_string

def convert_float(A):
  if "_dp"==A[-3:]:
    A = A[:-3]
  elif "_real"==A[-5:]:
    A = A[:-5]
  if (A.find("D")): # 1.5D-3
    A = A.replace("D","e")
  if (A.find("d")): # 1.5D-3
    A = A.replace("d","e")
  try:
    A_arg = float(A)
  except:
    A_arg = error_string+":"+A
  return A_arg


def unknown(line_data):
  rate_constant = line_data["rate constant"].strip()
  line_data["type"]=error_string
  line_data["error"]=error_string
  return 
def constant(line_data):
  rate_constant = line_data["rate constant"].strip()
  value = convert_float(rate_constant)
  line_data["type"]="ARRHENIUS"
  line_data["A"]=value
  return 
def arrhenius(line_data):
  rate_constant = line_data["rate constant"].strip()
  arguments=re.search('\(([^)]+)', rate_constant).group(1)
  arg_array=clean_split(arguments,",")
  A = convert_float(arg_array[0])
  C = convert_float(arg_array[1])
  line_data["type"]="ARRHENIUS"
  line_data["A"]=A
  line_data["C"]=C
  return

def wrf_chem_to_CAMP(line_data):
  # guess the type of reaction from the text of the rate constant
  rate_constant = line_data["rate constant"].strip()
  if "*" in rate_constant:
    unknown(line_data)
  elif 0==rate_constant.find("ARR2"):
    arrhenius(line_data)
  elif 0==rate_constant.find("TROE"):
    line_data["type"]="TROE"
    line_data["error"]=error_string
  elif 0==rate_constant.find("TROEE"):
    line_data["type"]="TROEE"
    line_data["error"]=error_string
  elif 0==rate_constant.find("j"):
    line_data["type"]="PHOTOLYSIS"
    line_data["link"]=line_data["rate constant"]
    line_data["error"]=error_string
    #line_data["reactants"].pop("hv")   # assume this reactant is listed
  elif rate_constant.endswith("_dp"):
    constant(line_data)
  elif ("D" in rate_constant or "d" in rate_constant or "E" in rate_constant or "e" in rate_constant) and not "(" in rate_constant:
    constant(line_data)
  else:
    unknown(line_data)
  line_data.pop("rate constant")  # remove entry
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
  file_conversion = {
    "filename":args.filename,
    "ignored_lines":[],
    "reaction":[]
  }
  for line in file:
    if line.startswith('#'):            ## skip over comments
      file_conversion["ignored_lines"].append(line)
      continue
    if line.startswith('//'):           ## skip over section heads
      file_conversion["ignored_lines"].append(line)
      continue

    line_data = {
      "wrf-kpp specification":line,
    }
    line=line.strip()                   ## remove starting and ending whitespace
    line=re.sub(r"{.*?}", "", line)     ## remove {}-delimited KPP comments
    line=re.sub(r";", "", line)         ## remove anything following ;
    line=line.strip()                   ## remove starting and ending whitespace
    [reaction, line_data["rate constant"]] = clean_split(line, ":")   

    #element = json.loads(wrf_chem_to_CAMP(line_data["rate constant"]))
    #print(element)
    wrf_chem_to_CAMP(line_data)

    [reactant_string, product_string] = clean_split(reaction, "=")   

    line_data["reactants"]={}
    reactant_array=clean_split(reactant_string, "+")
    for reactant in reactant_array:
      line_data["reactants"][reactant]={}
    if line_data["type"] == "PHOTOLYSIS":  # "hv" is listed as a reactant in wrf file for photodecomposition
      line_data["reactants"].pop("hv")

    product_and_yield_strings_array=clean_split(product_string, "+")
    line_data["products"] = {}
    for product_and_yield in product_and_yield_strings_array:
      [molecule,num]=coefficient_and_molecule(product_and_yield)
      if num:
        line_data["products"][molecule]={"yield":num}
      else:
        line_data["products"][molecule]={}

    file_conversion["reaction"].append(line_data)

    camp_version_json = json.dumps(file_conversion, indent=4)

  print(camp_version_json)


