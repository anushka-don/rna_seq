# RNA-seq Analysis Pipeline

This repository contains a Nextflow pipeline for processing RNA-seq data, including quality control, alignment, and quantification using multiple tools.

Original Publication - https://www.nature.com/articles/s41467-022-34069-z

## Data Overview

- **Biological context**
  - Study: Chandra et al., “The type 1 diabetes gene TYK2 regulates β‑cell development and its responses to interferon‑α” (Nat. Commun. 2022; s41467‑022‑34069‑z).  
  - System: Human induced pluripotent stem cells (hiPSCs) differentiated into pancreatic lineages.  
  - Focus stage: **Stage 5 – endocrine precursors (EP)** in the directed differentiation protocol.  

- **Experimental groups**
  - **Genotypes**:
    - Wild‑type (WT) hiPSC‑derived Stage 5 endocrine precursor cells.  
    - TYK2 knockout (KO) hiPSC‑derived Stage 5 endocrine precursor cells.  
  - Hypothesis (paper): TYK2, via type I interferon signaling, modulates β‑cell development and immune responsiveness, making TYK2 inhibition a potential therapeutic strategy for type 1 diabetes.  
  - Hypothesis (this project): Transcriptional profiles differ between WT and TYK2 KO Stage 5 cells.

- **Data type**
  - Bulk RNA‑seq on Stage 5 EP cells.  
  - Paired‑end sequencing reads (standard naming, e.g. `sample_1.fastq.gz`, `sample_2.fastq.gz`).  

- **Project objective**
  - Identify transcriptional differences between WT and KO Stage 5 endocrine precursors.  
  - Characterize pathways and genes associated with:
    - Endocrine differentiation (e.g., NEUROG3, NKX2‑2, β‑cell developmental programs).  
    - Cell‑cycle regulation and signaling (e.g., KRAS, RTK/MAPK pathways).  

- **High‑level analysis plan**
  - Process raw reads through the RNA‑seq pipeline (QC, alignment, quantification).  
  - Perform differential expression analysis between WT and KO Stage 5 samples.  
  - Conduct pathway/gene set enrichment to interpret functional differences in endocrine precursor biology.
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
