#!/usr/bin/env nextflow

process MULTI_QC {
    label 'process_low'
    container 'ghcr.io/bf528/multiqc:latest'
    publishDir params.outdir

    input:
    path('*')

    output:
    path "multiqc_report.html"

    script:
    """
    multiqc . -f
    """
}
