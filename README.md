# KPP_to_CAMP

This code is fragile and requires hand validation of the conversions.

Parses WRF-KPP files under a significant number of assumptions, due to lack of a clear syntax.

This targets a number of WRF-chem files and one potential CAMP data format


Usage
```
python3 convert.py --help
```

Example
```
python3 convert.py ./Examples/redhc_made_soa_vbs/redhc_made_soa_vbs.eqn > my_translated_mechanism.json
```
