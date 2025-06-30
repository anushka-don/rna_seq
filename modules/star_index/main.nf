#!/usr/bin/env nextflow

process STAR_INDEX {
    container 'ghcr.io/bf528/star:latest'
    label 'process_high'
    publishDir params.outdir

    input:
    path genome
    path gtf

    output:
    path "star", emit: star


    shell:
    """
    mkdir star
    STAR --runThreadN $task.cpus --runMode genomeGenerate --genomeDir star --genomeFastaFiles $genome --sjdbGTFfile $gtf
    """
}
