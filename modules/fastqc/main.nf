#!/usr/bin/env nextflow

process FASTQC {
  container 'ghcr.io/bf528/fastqc:latest'
  label 'process_single'
  publishDir params.outdir

  input:
  tuple val(name), path(fastq)

  output:
  path("*html")

  shell:
  """
  fastqc $fastq
  """

}
