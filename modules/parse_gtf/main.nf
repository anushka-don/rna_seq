#!/usr/bin/env nextflow

process PARSE_GTF {
    container 'ghcr.io/bf528/pandas:latest'
    label 'process_single'
    publishDir params.outdir
    input:
    path(gtf_file)

    output:
    path("ensemble_genes.csv")

    script:
    """
    gtf_parser.py $gtf_file ensemble_genes.csv
    """
}
