#!/usr/bin/env nextflow

process VERSE {
    container 'ghcr.io/bf528/verse:latest'
    publishDir params.outdir

    input:
    tuple val(sample), path(bam), path(gtf)

    output:
    tuple val(sample), path("${sample}.*")

    script:
    """
    verse -a $gtf -o $sample $bam -S
    """
}
