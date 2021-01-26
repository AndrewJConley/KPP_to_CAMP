import argparse
import os
import re
import json


error_string = "***error***"


parser = argparse.ArgumentParser(description='Parse KPP File with many unstated assumptions on format.')
parser.add_argument('filename', metavar='filename', type=str, nargs=None,
                    help='kpp file to be digested')
args = parser.parse_args()


#
# split string around token, remove empties, remove whitespace
#
def clean_split(string, token):
  split_string_array = string.split(token)
  clean_split_string_array = [element for element in split_string_array if element]
  trimmed_clean_split_string_array = [var.strip() for var in clean_split_string_array]
  return trimmed_clean_split_string_array


#
# convert a string into a float
#
def convert_string_to_float(string_number):

  # remove "precision" declarations
  if "_dp"==string_number[-3:]:
    string_number = string_number[:-3]
  elif "_real"==string_number[-5:]:
    string_number = string_number[:-5]

  # convert "D" notation to "e" notation. 
  if (string_number.find("D")): # 1.5D-3
    string_number = string_number.replace("D","e")
  if (string_number.find("d")): # 1.5D-3
    string_number = string_number.replace("d","e")
  
  # if the conversion fails, return an error string rather than an number
  try:
    converted_number = float(string_number)
  except:
    converted_number = error_string+":"+string_number
  return converted_number


#
# if the rate constant string is undecipherable, put some errors in the json
#
def unknown(camp_reaction):
  rate_constant = camp_reaction["rate constant"].strip()
  camp_reaction["type"]=error_string
  camp_reaction["error"]=error_string

#
# raw numbers are simple cases of ARRHENIUS reactions
#
def constant(camp_reaction):
  rate_constant = camp_reaction["rate constant"].strip()
  value = convert_string_to_float(rate_constant)
  camp_reaction["type"]="ARRHENIUS"
  camp_reaction["A"]=value

#
# ARR2 is some wrf-chem function with 2 arguments A*exp(-C/T)
#
def ARR2(camp_reaction, parsed_data):
  A = convert_string_to_float(parsed_data["arguments"][0])
  C = convert_string_to_float(parsed_data["arguments"][1])
  camp_reaction["type"]="ARRHENIUS"
  camp_reaction["A"]=A
  camp_reaction["C"]=C


#
# Look for something like function_name(arg1, arg2, arg3)
# returns parsed_value= { "name":"somename", "arguments":["arg1","arg2","arg3"] }
# return function name and arguments in parsed_values
# true if identifies pattern, false if doesn't 
#
def function_signature(rate_constant, parsed_values):
  try:
    [raw_name,rest_of_string] = rate_constant.split("(")  # more than one "(" is a problem
  except:
    return False
  name = raw_name.strip()
  parsed_values["name"]=name

  try:
    [arguments, tail] = rest_of_string.split(")")
  except:
    return False
  if(len(tail.strip()) > 0):  # something after parenthesis is a problem
    parsed_values = {}
    return False
  try:
    arg_list = clean_split(arguments,",")  
  except:
    return False
  parsed_values["arguments"]=arg_list

  return True  # probably a function


#
# convert the rate constant to CAMP form, assuming wrf-chem functions
#
def wrf_chem_to_CAMP(camp_reaction):
  # guess the type of reaction from the text of the rate constant
  rate_constant = camp_reaction["rate constant"].strip()
  parsed_data = {}
  if(function_signature(rate_constant, parsed_data)):  # if it looks like a function
    if parsed_data["name"]=="ARR2":
      ARR2(camp_reaction, parsed_data)
    elif  parsed_data["name"]=="TROE":
      camp_reaction["type"]="TROE"
      camp_reaction["error"]=error_string
    elif  parsed_data["name"]=="TROEE":
      camp_reaction["type"]="TROEE"
      camp_reaction["error"]=error_string
    elif  parsed_data["name"]=="TROEMS":
      camp_reaction["type"]="TROEMS"
      camp_reaction["error"]=error_string
    elif  parsed_data["name"]=="j":
      camp_reaction["type"]="PHOTOLYSIS"
      camp_reaction["error"]=error_string
    else:
      camp_reaction["type"]="unknown function"
      camp_reaction["error"]=error_string
      
  # otherwise, it might be some raw reference to a string or number?
  elif "*" in rate_constant:
    unknown(camp_reaction)
  elif rate_constant.endswith("_dp"):
    constant(camp_reaction)
  elif ("D" in rate_constant or "d" in rate_constant or "E" in rate_constant or "e" in rate_constant) and not "(" in rate_constant:
    constant(camp_reaction)
  else:
    unknown(camp_reaction)
  camp_reaction.pop("rate constant")  # remove entry
  return
  

#
#  extract 1.2 O2 as ['O2', 1.2]
#
def coefficient_and_molecule( product_string ):
  product_search = re.search(r"[A-z]\S*" ,product_string)
  if(product_search):
    molecule = product_search.group()
  else:
    molecule = error_string

  coeff_search=re.match(r"\d*\.?\d*",product_string)
  if(coeff_search):
    stoic_coeff = coeff_search.group().strip()
    if(stoic_coeff):
      num = convert_string_to_float(stoic_coeff.strip())
    else:
      num = ""

  return([molecule,num])

#
# Main program
#
with open(args.filename,'r') as file:
  # open file, and store name for reference
  camp_file = {
    "name":error_string + ": needs a name",
    "type":"MECHANISM",
    "source filename":args.filename,
    "ignored_lines":[],
    "reactions":[]
  }

  # for every line:
  for line in file:

    # store comment lines and skip to next line
    if line.startswith('#'):            ## skip over comments
      camp_file["ignored_lines"].append(line)
      continue
    if line.startswith('//'):           ## skip over section heads
      camp_file["ignored_lines"].append(line)
      continue

    # store original line from which reaction is derived
    # and get a "line" with no garbage in it
    camp_reaction = {
      "wrf-kpp specification":line,
    }
    line=line.strip()                   ## remove starting and ending whitespace
    line=re.sub(r"{.*?}", "", line)     ## remove {}-delimited KPP comments
    line=re.sub(r";", "", line)         ## remove anything following ;
    line=line.strip()                   ## remove starting and ending whitespace

    # split out the reactions from the rate constant
    [reaction, camp_reaction["rate constant"]] = clean_split(line, ":")   

    # convert the rate constant to CAMP syntax
    camp_reaction["type"]=""
    wrf_chem_to_CAMP(camp_reaction)

    # split reactants from products
    [reactant_string, product_string] = clean_split(reaction, "=")   

    # collect reactants
    # !!! ASSUME no coefficients
    camp_reaction["reactants"]={}
    reactant_array=clean_split(reactant_string, "+")
    for reactant in reactant_array:
      camp_reaction["reactants"][reactant]={}

    # for "PHOTOLYSIS" reactions, there is often a "hv" listed as a reactant.  Remove it.
    if camp_reaction["type"] == "PHOTOLYSIS":  
      if("hv" in camp_reaction["reactants"]):
        camp_reaction["reactants"].pop("hv")
      else:
        camp_reaction["arguments"]=error_string+"missing hv in original file"

    # store products with their stoichiometric coefficients
    product_and_yield_strings_array=clean_split(product_string, "+")
    camp_reaction["products"] = {}
    for product_and_yield in product_and_yield_strings_array:
      [molecule,num]=coefficient_and_molecule(product_and_yield)
      if num:
        camp_reaction["products"][molecule]={"yield":num}
      else:
        camp_reaction["products"][molecule]={}

    # put the reaction in the list of reactions
    camp_file["reactions"].append(camp_reaction)

    camp_version_json = json.dumps(camp_file, indent=4)

  print(camp_version_json)


