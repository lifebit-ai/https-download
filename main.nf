#!/usr/bin/env nextflow

// Re-usable componext for adding a helpful help message in our Nextflow script
def helpMessage() {
    log.info"""
    Usage:
    The typical command for running the pipeline is as follows:
    nextflow run main.nf --fastq_list fastq_files_list.csv
    Mandatory arguments:
      --fastq_list                  [file] A comma seperated file with all the https file locations
                                    A header is expected, and 2 columns that define the following:
                                    - name, desired file name based on metadata
                                    - link (ftp, https) to the file
                                    
                                    A file could look like this:
                                    name,https_links
                                    this,https://this.vcf
    """.stripIndent()
}

// Re-usable component to create a channel with the links of the files by reading the design file
Channel
    .fromPath(params.https_list)
    .ifEmpty { error "No file with list of https file links to download from found at the location ${params.https_list}" }
    .splitCsv(sep: ',', skip: 1)
    .map { name, https_link -> [ name, https_link, https_link.toString().tokenize('.').last() ] }
    .set {ch_https_links}

process get_file {
  echo true
  publishDir "results/${suffix}/", mode: 'copy'

  input: 
  set val(name), val(https_link), val(suffix) from ch_https_links
  
  output: 
  file("${name}.${suffix}") into ch_retrieved_files

  script:
  """
  wget -O "${name}.${suffix}" ${https_link} 
  """
}
