#!/usr/bin/env nextflow
/*
========================================================================================
                                LPS-evaluator
========================================================================================
 Author: Dat T Nguyen
 Contact: ndat<at>utexas.edu
----------------------------------------------------------------------------------------
*/



/*
 Define the default parameters
*/ 
params.mini1          = "$baseDir/data/mini1"
params.mini2          = "$baseDir/data/mini2"
params.mini3          = "$baseDir/data/mini3"
params.mini4          = "$baseDir/data/mini4"

params.trace_dir       = "trace_dir"
params.outdir          = "results"
params.group_lps       = ['0.5_lps', '0.75_lps', '1.0_lps', '1.25_lps', '1.5_lps', '2.0_lps']
params.chrom           = 1..22

nextflow.enable.dsl=2

workflow {


    Chrom_list_ch = channel.from(params.chrom)
    Group_lps_ch = channel.from(params.group_lps)

    ALL_tasks = Chrom_list_ch.combine(Group_lps_ch)
    // ALL_tasks.view()
    MERGE_mini_batches(params.mini1, params.mini2, params.mini3, params.mini4,  ALL_tasks)

}




process MERGE_mini_batches {

    publishDir "${params.outdir}", mode: 'copy', overwrite: true

    input:
    path mini1
    path mini2
    path mini3
    path mini4
    tuple val(i), val(lps_cov)

    cpus 1
    memory '8GB'
    maxForks 30

    output:
    path "*merged.vcf.gz"

    script:
    """
        bcftools index -f ${mini1}/chr${i}_${lps_cov}_imputed.vcf.gz
        bcftools index -f ${mini2}/chr${i}_${lps_cov}_imputed.vcf.gz
        bcftools index -f ${mini3}/chr${i}_${lps_cov}_imputed.vcf.gz
        bcftools index -f ${mini4}/chr${i}_${lps_cov}_imputed.vcf.gz
        
        
        bcftools merge --force-samples \
            ${mini1}/chr${i}_${lps_cov}_imputed.vcf.gz \
            ${mini2}/chr${i}_${lps_cov}_imputed.vcf.gz \
            ${mini3}/chr${i}_${lps_cov}_imputed.vcf.gz \
            ${mini4}/chr${i}_${lps_cov}_imputed.vcf.gz \
            | bgzip > chr${i}_${lps_cov}_merged.vcf.gz
        
    """
}