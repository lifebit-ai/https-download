#!/bin/bash

# A simple json to csv parser, with focus on extracting perticular columns in CUBE data
# depends upon: csvkit
# pip install csvkit 

print_usage() {
  printf "\n"
  printf "Usgae: parse_manifest.json -m manifest.json \n\n"
  printf "   -m:    A input manifest file (ex - manifest.json) [required] \n"
  printf "   -o:    A output file name (ex - manifest.csv) [optional] \n"
  printf "          If no output given it will be same as input \n"
  printf "   -h:    This help menu \n\n"
}

while getopts 'm:o:h' flag
do
    case "${flag}" in
      m) manifest_json="${OPTARG}" ;;
      o) output_csv="${OPTARG}" ;;
      h)
        print_usage
        exit 1
        ;;
      *)
        print_usage
        exit 1
        ;;
    esac
done

# check if output file name is given or else based on input file
if [ -z "$manifest_json" ]; then
  echo "A input is required in json format, Check help -h"
  exit 1 ; 
fi

# check if output file name is given or else based on input file
if [ -z "$output_csv" ]; then
  output_csv=$(basename "$manifest_json" | sed s/.json/.csv/)
fi

# convert from json to desired csv
in2csv "$manifest_json" > tmp_manifest.csv
awk -F, '{ print $1","$4$3 }' tmp_manifest.csv > "$output_csv"
rm tmp_manifest.csv