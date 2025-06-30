#!/usr/bin/env nextflow

include { FASTQC } from './modules/fastqc'
include { STAR_INDEX } from './modules/star_index'
include { PARSE_GTF } from './modules/parse_gtf'
include { STAR_ALIGN } from './modules/star_align'
include { MULTI_QC } from './modules/multiqc'
include { VERSE } from './modules/verse'
include { CONCAT_VERSE_OUTPUT } from './modules/verse_concat'

workflow {
        
    // Reading the data
    Channel.fromFilePairs(params.reads) |
    map { sample, reads -> [sample, reads[0], reads[1]] } |
    set { align_ch }
    
    // file pairs
    Channel.fromFilePairs(params.reads).transpose() |
    set { fastqc_ch }
    
    // Run FASTQC
    fastqc_out = FASTQC(fastqc_ch)

    // Run STAR index alignment
    star_index_ch = STAR_INDEX(params.genome, params.gtf)

    // Parse GTF files
    gtf_out = PARSE_GTF(params.gtf)

    // aligning star indexed files
    star_align_out = STAR_ALIGN(align_ch, star_index_ch)

    // MultiQC report
    multiqc_ch = fastqc_out.mix(star_align_out).flatten().collect()
    MULTI_QC(multiqc_ch)

    // Summarizing with Verse 
    star_align_out.bam |
    map { bam -> 
        def sample_name = bam.baseName.replaceAll(/Aligned\.out$/, '')
        tuple(sample_name, bam)
    } |
    set { bam_ch }

    gtf_out |
    set { gtf_file }

    bam_ch.combine(gtf_file) |
    map { sample_name, bam, gtf -> 
        tuple(sample_name, bam, gtf)
    } |
    set { verse_ch }

    verse_out = VERSE(verse_ch)

    // Verse concat the outputs
    verse_out.collect() |
    set { verse_outputs }

    CONCAT_VERSE_OUTPUT(verse_outputs)
}
