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
params.batch_dir      = "$baseDir/data/batch_merged"
params.true_vcfs      = "$baseDir/data/true_vcfs/*.vcf.gz"
params.pop_files      = "$baseDir/data/pops/*.txt"
params.order_samples  = "$baseDir/data/2504_samples.txt"

params.trace_dir       = "eval_trace_dir2"
params.outdir          = "eval_results2"
params.group_lps       = ['Axiom_JAPONICA', 'Axiom_PMDA', 'Axiom_PMRA', 'Axiom_UKB_WCSG', 'cytosnp-850k-v1.2', 'global-screening-array-v.3', 'infinium-omni2.5.v1.5', 'infinium-omni5-v1.2']
params.chrom           = 1..22

nextflow.enable.dsl=2

workflow {
    
    Chrom_list_ch = channel.from(params.chrom)
    Group_lps_ch = channel.from(params.group_lps)
    Pop_ch = channel.fromPath(params.pop_files).map { file -> tuple(file.baseName, file) }
    True_vcf_ch = channel.fromPath(params.true_vcfs)

    // merging imputed vcfs
    ALL_tasks = Chrom_list_ch.combine(Group_lps_ch)
    MERGE_batches(params.batch_dir, params.order_samples, ALL_tasks)

    // process reference vcfs
    //RecomputeMAF(True_vcf_ch)
    POP_true_tasks = Chrom_list_ch.combine(Pop_ch)
    VCF_true_population_slipt(POP_true_tasks, True_vcf_ch.collect())
    
    // process imputed data
    POP_imputed_tasks = MERGE_batches.out.combine(Pop_ch)
    VCF_imputed_population_slipt(POP_imputed_tasks)

    // run evaluation
    EVALUATE_imputation(VCF_imputed_population_slipt.out, VCF_true_population_slipt.out.collect())

    COMPUTE_accuracy_perbin(EVALUATE_imputation.out)
}



process COMPUTE_accuracy_perbin {

    publishDir "${params.outdir}/acc_cov_perbin", mode: 'copy', overwrite: true
    
    cpus 1
    maxForks 40
    memory '8GB'

    input:
    path res_snp_wise

    output:
    path "perbin_*"

    script:
    """
    get_coverage.py --input ${res_snp_wise} \
                    --cov perbin_${res_snp_wise}_cov.txt \
                    --acc perbin_${res_snp_wise}_mean_r2.txt \
    """

}


process EVALUATE_imputation {

    publishDir "${params.outdir}/res_accuracy_metrics", mode: 'copy', overwrite: true
    
    cpus 1
    maxForks 20
    
    errorStrategy 'retry'
    maxRetries 3

    memory { 
        task.attempt == 1 ? '48GB' : task.attempt == 2 ? '64GB' : '128GB'
    }

    input:
    tuple val(i), val(lps_cov), val(pop), path(imputed_vcf)
    path all_splited_true_vcfs

    output:
    path "*.acc"

    script:
    """

    compute_MAF.sh chr${i}_${pop}_true.vcf.gz maf.txt

    run_evaluate.py --true_vcf chr${i}_${pop}_true.vcf.gz \
                 --imputed_vcf ${imputed_vcf} \
                 --af maf.txt \
                 --out_snp_wise chr${i}_${lps_cov}_${pop}_snp_wise.acc \

    """

}



process RecomputeMAF {

    publishDir "${params.outdir}/maf", mode: 'symlink', overwrite: true
    cpus 1
    memory '8GB'
    maxForks 10


    input:
    path vcf_file

    output:
    path "${vcf_file.baseName}.txt"

    script:
    """
    compute_MAF.sh $vcf_file ${vcf_file.baseName}.txt
    """
}


process VCF_true_population_slipt {

    publishDir "${params.outdir}/true_vcf_slipts", mode: 'symlink', overwrite: true

    input:
    tuple val(i), val(pop), path(pop_samples)
    path vcf

    cpus 1
    memory '8GB'
    maxForks 10

    output:
    path "chr${i}_${pop}_true.vcf.gz"

    script:
    """
    bcftools index -f chr${i}.vcf.gz

    bcftools view -S ${pop_samples} chr${i}.vcf.gz | bgzip > chr${i}_${pop}_true.vcf.gz

    """
}



process VCF_imputed_population_slipt {

    publishDir "${params.outdir}/imputed_vcf_slipts", mode: 'symlink', overwrite: true

    input:
    tuple val(i), val(lps_cov), path(vcf), val(pop), path(pop_samples)

    cpus 1
    memory '8GB'
    maxForks 10

    output:
    tuple val(i), val(lps_cov), val(pop), path("chr${i}_${lps_cov}_${pop}_imputed.vcf.gz")

    script:
    """
    bcftools index -f ${vcf}

    bcftools view -S ${pop_samples} ${vcf} | bgzip > chr${i}_${lps_cov}_${pop}_imputed.vcf.gz

    """
}


process MERGE_batches {

    publishDir "${params.outdir}/merged_all", mode: 'symlink', overwrite: true

    input:
    path batch_dir
    path order_samples
    tuple val(i), val(lps_cov)

    cpus 1
    memory '8GB'
    maxForks 20

    output:
    tuple val(i), val(lps_cov), path("chr${i}_${lps_cov}_merged_all.vcf.gz")

    script:
    """
    merge_array_batches.sh ${batch_dir} "${lps_cov}_chr${i}" "chr${i}_${lps_cov}_merged_all.vcf.gz"

    """
}
