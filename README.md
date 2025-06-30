# RNA-seq Analysis Pipeline

This repository contains a Nextflow pipeline for processing RNA-seq data, including quality control, alignment, and quantification using multiple tools.

Pipeline Overview
The pipeline performs the following steps:

FASTQC – Quality control on raw sequencing reads.

STAR Index – Generates STAR genome index using the provided genome FASTA and GTF.

STAR Align – Aligns reads to the reference genome.

Parse GTF – Parses GTF annotation file for downstream steps.

VERSE – Performs quantification of aligned reads.

Concat VERSE Output – Merges individual quantification results.

MultiQC – Aggregates QC results into a single report.

Input
Paired-end reads: specified via --reads

Reference genome FASTA: specified via --genome

GTF annotation file: specified via --gtf

Example:

bash
Copy
Edit
nextflow run main.nf --reads "data/*_{1,2}.fastq.gz" --genome "ref/genome.fa" --gtf "ref/annotation.gtf"
Requirements
Nextflow

Modules and tools:

FASTQC

STAR

VERSE

MultiQC

Reference files (FASTA, GTF)

Output
FASTQC reports for raw reads

STAR alignment BAM files

Quantification results from VERSE

Combined quantification summary

MultiQC report

Notes
The pipeline expects paired-end reads in standard naming format (e.g., sample_1.fastq.gz, sample_2.fastq.gz).

Modules should be available in the specified ./modules/ directory.
