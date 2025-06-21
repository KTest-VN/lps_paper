PGS performance was evaluated using two main metrics:

1. {==PGS Correlation==}  
   Pearson’s correlation between PGS derived from imputed SNP array data and PGS from whole-genome sequencing (WGS).

2. {==ADPR (Absolute Difference in Percentile Ranking)==}  
   The absolute difference in percentile ranking between PGS from array-imputed data and the WGS-derived gold standard.

These evaluations were conducted across multiple **p-value thresholds** to ensure unbiased comparison, based on the method from Nguyen et al., 2022[@nguyen2022comprehensive].



!!! note "PRS formula"
    For an individual $i$, the polygenic score at p-value threshold $P_{T}$ is calculated as:

    \[
    PGS_i(P_T) = \sum_{j=1}^{M} {1}_{\{P_j < P_T\}} \, x_{ij} \, \hat{\beta}_j
    \]

    - $P_T$ : p-value threshold
    - $M$ : number of SNPs after clumping
    - $x_{ij}$ : allele count for SNP $j$ in individual $i$
    - $\hat{\beta}_j$ : marginal effect size from GWAS for SNP $j$
    - $1_{\{P_j < P_T\}}$ : indicator function for p-value filtering

=== "PGS correlation"
    ## PGS correlation

=== "ADPR"
    ## Absolute Difference in Percentile Ranking (ADPR)
