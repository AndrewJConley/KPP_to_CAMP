# KPP_to_CAMP

The purpose of this code is to support people who want to "convert" wrf-chem / wrk-kpp files to CAMP format.

The resulting file requires hand validation of the conversions.

Many assumptions are made on the source format, due to lack of a clear syntax for KPP files.

This conversion targets a number of WRF-chem files and one potential CAMP data format.


Usage
```
python3 convert.py --help
```

Example
```
python3 convert.py ./Examples/redhc_made_soa_vbs/redhc_made_soa_vbs.eqn > my_translated_mechanism.json
```
