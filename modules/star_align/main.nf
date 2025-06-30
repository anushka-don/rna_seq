#!/usr/bin/env nextflow

process STAR_ALIGN {
    label 'process_high'
    container 'ghcr.io/bf528/star:latest'
    publishDir params.outdir

    input:
    tuple val(prefix), path(read1), path(read2)
    path genomeDir

    output:
    path "${prefix}Aligned.out.bam", emit: bam
    path "${prefix}Log.final.out", emit: log

    script:
    """
    STAR --runThreadN $task.cpus --genomeDir $genomeDir --readFilesIn $read1 $read2 --readFilesCommand zcat --outFileNamePrefix $prefix --outSAMtype BAM Unsorted
    """
}
