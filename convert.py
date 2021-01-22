
import argparse
import os
import re

parser = argparse.ArgumentParser(description='Parse KPP File with (WARNING) limited understanding of kpp format.')
parser.add_argument('filename', metavar='filename', type=str, nargs=None,
                    help='kpp file to be digested')
parser.add_argument('--outfile', type=str, nargs='?', default='parsed_file',
                    help='filename containing json of parsed data')
args = parser.parse_args()


## Function to split based on a token and .trim
def clean_split(string, token):
  split_string = string.split(token)
  clean_split_string = [var for var in split_string if var]
  trimmed_clean_split_string = [var.strip() for var in clean_split_string]
  return trimmed_clean_split_string

def coefficient_and_molecule( product_string ):
  coeff_search=re.match(r"\d*\.?\d*",product_string)
  if(coeff_search):
    coefficient = coeff_search.group()
  else:
    coefficient = ''
  product_search = re.search(r"[A-z]\S*" ,product_string)
  if(product_search):
    product = product_search.group()
  else:
    product = 'error'
  return([coefficient,product])

## Load kpp file
with open(args.filename,'r') as file:
  for line in file:
    if line.startswith('#'):            ## skip over comments
      continue
    if line.startswith('//'):           ## skip over section heads
      continue
    line=line.strip()                   ## remove starting and ending whitespace
    line=re.sub(r"{.*?}", "", line)     ## remove {}-delimited KPP comments
    line=re.sub(r";", "", line)         ## remove anything following ;
    line=line.strip()                   ## remove starting and ending whitespace
    [reaction, rate_constant] = clean_split(line, ":")   
    [reactant_string, product_string] = clean_split(reaction, "=")   
    reactants=clean_split(reactant_string, "+")
    product_and_yield_strings_array=clean_split(product_string, "+")
    product_yield_array = []
    for product_and_yield in product_and_yield_strings_array:
      product_yield_array.append(coefficient_and_molecule(product_and_yield))
    print(reactants)
    print(" -> ")
    print(product_yield_array)
    print(" : ")
    print(rate_constant)
    print("   ")


#kpp_file_string = open(args.filename,'r').read()
#print(kpp_file_string)
#kpp_lines = kpp_file_string.split("\n")
#print(kpp_lines)



## Remove lines starting with # or //

## Split file based on ";"

## Remove all Data between {}

## Remove any blank lines and .trim


