# Polygenic score and imputation accuracy from low-pass sequencing in diverse population

## Introduction

Genome-wide association studies (GWAS) and polygenic score (PGS) analyses typically rely on large-scale genetic data, which has traditionally been collected using SNP arrays and genotype imputation. However, low-pass whole-genome sequencing (lpWGS) is emerging as a promising alternative.

In this study, we compare the imputation accuracy and polygenic score performance of eight leading genotyping arrays and six lpWGS coverage levels (ranging from 0.5x to 2x) across diverse populations. Using data from 2,504 individuals in the 1000 Genomes Project[@byrska2022high], we apply a 10-fold cross-imputation approach to assess both imputation and PGS accuracy for four complex traits.

Our findings show that lpWGS performs on par with population-specific genotyping arrays in terms of both imputation accuracy and polygenic score estimation. Notably, lpWGS outperforms arrays in underrepresented populations and shows greater accuracy for rare and low-frequency variants.

These results highlight the potential of low-pass sequencing as a flexible, powerful alternative to genotyping arrays—particularly in studies involving genetically diverse or underrepresented populations.

## Analytical Pipeline Summary

![Overview](assets/img/Fig1.jpg)
<figcaption style="
    max-width: 100%; 
    margin: 0 auto; 
    font-size: 0.80em;
    text-align: justify;
  ">
    Figure 1: Overview of the analytical pipeline. A) 10-fold cross-imputation approach; (1) 10% of the samples are downsampled (BAM files) or filtered to retain only array variants (VCF files) to generate pseudo LPS and pseudo array data; (2) these data are imputed using the remaining 90% of the samples as the reference panel; (3) the imputed data from all batches are combined and then split by population; (4) performance is evaluated using high-coverage genotyping data as the ground truth. B) Data generation and imputation pipeline for LPS and SNP array data. 
</figcaption>

This study analyzes data from 2,504 unrelated individuals in the 1000 Genomes Project, re-sequenced at high coverage (30x) by the New York Genome Center (1KGPHC). Two main data sources are utilized:

- Mapped sequence data (CRAM format)
- Phased variant data (VCF format)

## Processes

1. Processing data:
      - [Variant Filtering](processing_data/variant_filtering.md): VCF files are filtered to improve imputation accuracy.
      - [Data Simulation](processing_data/data_simulation.md): Low-pass sequencing and eight SNP arrays are simulated with realistic noise and aligned to hg38.
      - [Cross-Validation Framework](processing_data/cross_validation.md): A 10-fold stratified cross-validation ensures balanced population representation for imputation testing.
2. Genotype Imputation: 
      - [lpWGS](imputation/lps_imputation.md): GLIMPSE2 is used for lpWGS imputation.
      - [SNP arrays](imputation/array_imputation.md): undergo phasing with SHAPEIT5 and imputation with Minimac4.
3. Evaluation:
      - [Merge imputed data](evaluation/merge_imputed_data.md): Imputed data is merged by population
      - [lpWGS performance](evaluation/lps_performance.md): compared to 30x WGS to assess accuracy
      - [PRS performance](evaluation/prs_performace.md): calculate PRS and compared to 30x WGS for accessing PRS performance