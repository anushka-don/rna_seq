#!/usr/bin/env nextflow

process CONCAT_VERSE_OUTPUT {
    container 'ghcr.io/bf528/pandas:latest'
    publishDir params.outdir

    input:
    path(verse_files)

    output:
    path "combined_counts_matrix.txt"

    script:
    """
    concat_verse_output.py -i ${verse_files} -o combined_counts_matrix.txt
    """
}