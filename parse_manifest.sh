#!/bin/bash

# A json to csv parser, with focus on extracting perticular columns
# Usgae: 

print_usage() {
  printf "Usgae: parse_manifest.json -m manifest.json \n\n"
  printf "-m    A input manifest.json file \n"
}

while getopts u:a:f: flag
do
    case "${flag}" in
        m) manifest_json=${OPTARG};;
        *) print_usage exit 1;;
    esac
done

in2csv "$manifest_json" > tmp_manifest.csv
awk ' { print $0 $1 "-" $NF } ' tmp_manifest.csv > manifest.csv # WIP - need to merger to build the URL