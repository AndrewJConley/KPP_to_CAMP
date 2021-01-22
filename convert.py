
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
    print(reaction + " : \t" + rate_constant)


#kpp_file_string = open(args.filename,'r').read()
#print(kpp_file_string)
#kpp_lines = kpp_file_string.split("\n")
#print(kpp_lines)



## Remove lines starting with # or //

## Split file based on ";"

## Remove all Data between {}

## Remove any blank lines and .trim


