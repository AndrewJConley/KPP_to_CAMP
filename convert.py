
import argparse
import os
import re
import json

parser = argparse.ArgumentParser(description='Parse KPP File with (WARNING) limited understanding of kpp format.')
parser.add_argument('filename', metavar='filename', type=str, nargs=None,
                    help='kpp file to be digested')
parser.add_argument('--outfile', type=str, nargs='?', default='parsed_file',
                    help='filename containing json of parsed data')
args = parser.parse_args()

#def wrf_chem_to_CAMP(rate_constant):
  

def is_convertable_to_float(value):
  try:
    float(value)
    return True
  except:
    return False

## Function to split based on a token and .trim
def clean_split(string, token):
  split_string = string.split(token)
  clean_split_string = [var for var in split_string if var]
  trimmed_clean_split_string = [var.strip() for var in clean_split_string]
  return trimmed_clean_split_string

def coefficient_and_molecule( product_string ):
  product_search = re.search(r"[A-z]\S*" ,product_string)
  if(product_search):
    molecule = product_search.group()
  else:
    molecule = "***error***" 

  coeff_search=re.match(r"\d*\.?\d*",product_string)
  if(coeff_search):
    stoic_coeff = coeff_search.group()
    if stoic_coeff:
      if is_convertable_to_float(stoic_coeff):
        num = float(stoic_coeff)
      else:
        num = "***error***"
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

    [reactant_string, product_string] = clean_split(reaction, "=")   

    line_data["reactants"]={}
    reactant_array=clean_split(reactant_string, "+")
    for reactant in reactant_array:
      line_data["reactants"][reactant]={}

    product_and_yield_strings_array=clean_split(product_string, "+")
    line_data["products"] = {}
    for product_and_yield in product_and_yield_strings_array:
      [molecule,num]=coefficient_and_molecule(product_and_yield)
      if num:
        line_data["products"][molecule]={"yield":num}
      else:
        line_data["products"][molecule]={}

    file_conversion["reaction"].append(line_data)

    converted_file = json.dumps(file_conversion, indent=4)

  print(converted_file)


