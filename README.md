# https-download

Minimal pipeline to retrieve files from https links and rename them based on desired name and initial file suffix.

## Usage:

The typical command for running the pipeline is as follows:

```bash
nextflow run main.nf --https_list testdata/input.csv
```

## Parameters

```
Mandatory arguments:

    --https_list                [file] A comma seperated file with all the https file locations
                                A header is expected, and 2 columns that define the following:
                                - name, desired file name based on metadata
                                - link (ftp, https) to the file
                                
                                A file could look like this:
                                name,https_links
                                this,https://this.vcf

```

## For CUBE data

Convert the CUBE manifest.json file to manifest.csv file to be used as input in Nextflow pipeline

```bash
pip install csvkit
bash bin/parse_manifest.sh -m testdata/manifest.json 
```