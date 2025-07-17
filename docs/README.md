# Polygenic score and imputation accuracy from low-pass sequencing in diverse populations

This documentation provides comprehensive information on the code, data, and methods used in the article.

Traditional GWAS and PGS studies utilize SNP arrays with genotype imputation; however, **low-pass whole-genome sequencing (lpWGS)** has emerged as a strong alternative.

## Article Summary

**General purpose**: To compare the performance of genotyping arrays and low-pass WGS.

### Study Design
- **Compared**: 8 genotyping arrays vs. 6 lpWGS coverage levels (0.5× to 2×)
- **Population**: 2,504 individuals from five superpopulations in the 1000 Genomes Project.
- **Methods**: Applied 10-fold cross-validation to perform genotype imputation and evaluate polygenic scores (PGS) across 4 traits. Results were summarized and assessed for performance.

### Key Findings
- lpWGS matched population-optimized arrays in imputation and PGS accuracy
- lpWGS outperformed arrays in underrepresented populations
- lpWGS was superior for rare and low-frequency variants

### Conclusion
Low-pass WGS is a **flexible and powerful alternative** to genotyping arrays, especially valuable for studies involving **diverse or underrepresented populations**.

### Analytical Pipeline

![Overview](assets/img/Fig1.jpg)
<figcaption style="
    max-width: 100%; 
    margin: 0 auto; 
    font-size: 0.80em;
    text-align: justify;
  ">
    Overview of the analytical pipeline. A) 10-fold cross-imputation approach; (1) 10% of the samples were downsampled (BAM files) or filtered to retain only array variants (VCF files) to generated pseudo LPS and pseudo array data; (2) these data were imputed using the remaining 90% of the samples as the reference panel; (3) the imputed data from all batches were combined and then were split by population; (4) performance was evaluated using high-coverage genotyping data as the ground truth. B) Data generation and imputation pipeline for LPS and SNP array data. 
</figcaption>
</br>

This study analyzes data from 2,504 unrelated individuals in the 1000 Genomes Project[@byrska2022high], which was sequenced at high coverage (30x) by the New York Genome Center (1KGPHC). Two main datasets were utilized:

- Mapped sequence data (CRAM format)
- Phased variant data (VCF format)

## Processes

1. Processing data:
      - [Cross-Validation Framework](processing_data/cross_validation.md): A 10-fold stratified cross-validation ensures balanced population representation for imputation testing.
      - [Variant Filtering](processing_data/variant_filtering.md): VCF files were filtered to improve imputation accuracy.
      - [Data Simulation](processing_data/data_simulation.md): Low-pass sequencing and eight SNP arrays data were simulated from high-coverage data.
2. Genotype Imputation: 
      - [lpWGS](imputation/lps_imputation.md): GLIMPSE2 was used for lpWGS imputation.
      - [SNP arrays](imputation/array_imputation.md): undergo phasing with SHAPEIT5 and imputation with Minimac4.
3. Evaluation:
      - [Restructure imputed data](evaluation/restructure_imputed_data.md): Imputed data was merged by population
      - [lpWGS performance](evaluation/lps_performance.md): compared to 30x WGS to assess accuracy and coverage performance, followed by visualization.
      - [PRS performance](evaluation/prs_performace.md): We calculated PRS and compared it to 30× WGS to assess PRS performance and visualize the results.
  
## Appendix
- [Available data](available_data.md): Information on the datasets used in this study.
- [About](about.md): Acknowledging contributions and support.
