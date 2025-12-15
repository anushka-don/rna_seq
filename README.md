# RNA-seq Analysis Pipeline

This repository contains a Nextflow pipeline for processing RNA-seq data, including quality control, alignment, and quantification using multiple tools.

Original Publication - https://www.nature.com/articles/s41467-022-34069-z

## Pipeline Overview
The pipeline performs the following steps:

FASTQC – Quality control on raw sequencing reads.

STAR Index – Generates STAR genome index using the provided genome FASTA and GTF.

STAR Align – Aligns reads to the reference genome.

Parse GTF – Parses GTF annotation file for downstream steps.

VERSE – Performs quantification of aligned reads.

Concat VERSE Output – Merges individual quantification results.

MultiQC – Aggregates QC results into a single report.

## Input
Paired-end reads: specified via --reads

Reference genome FASTA: specified via --genome

GTF annotation file: specified via --gtf

## Modules and tools:

FASTQC

STAR

VERSE

MultiQC

Reference files (FASTA, GTF)

# Output
FASTQC reports for raw reads

STAR alignment BAM files

Quantification results from VERSE

Combined quantification summary

MultiQC report

## Notes
The pipeline expects paired-end reads in standard naming format (e.g., sample_1.fastq.gz, sample_2.fastq.gz).

Modules should be available in the specified ./modules/ directory.

Number of samples: The default input glob `/projectnb/bf528/materials/project-1-rnaseq/full_files/*_R{1,2}.fastq.gz` matches 12 FASTQ files. That corresponds to six paired-end samples (one R1 and one R2 file per sample).
