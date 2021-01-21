


## Load kpp file

## Function to split based on a token and .trim
def clean_split(string, token):
  print(string)
  print("token"+":"+token+":")
  split_string = string.split(token)
  clean_split_string = [var for var in split_string if var]
  trimmed_clean_split_string = [var.strip() for var in clean_split_string]
  return trimmed_clean_split_string

split_string = clean_split("hello and more  2   3"," ")
print(split_string)

  


## Remove lines starting with # or //

## Split file based on ";"

## Remove all Data between {}

## Remove any blank lines and .trim


