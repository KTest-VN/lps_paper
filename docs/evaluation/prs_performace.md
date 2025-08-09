PGS performance was evaluated using two main metrics:

1. {==PGS Correlation==}  
   Pearson’s correlation between PGS derived from imputed SNP array or low-pass WGS data and those obtained from high-coverage (30×) WGS.

2. {==ADPR (Absolute Difference in Percentile Ranking)==}  
   The absolute difference in percentile ranking between PGS obtained from array-imputed or low-pass WGS data and those derived from the high-coverage WGS gold standard.

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

    Pearson’s correlation {==quantifies the degree of linear agreement==} between PGS derived from imputed SNP array or low-pass sequencing (LPS) data and those from high-coverage (30X) whole-genome sequencing (WGS), providing a direct measure of score concordance.

    PGS correlation was quantified using Pearson's correlation coefficient between the array/LPS-based PGS ($X$) and the 30X WGS-based PGS ($Y$):

    $$
    r = \frac{\sum_{i=1}^N (X_i - \bar{X}) (Y_i - \bar{Y})}{\sqrt{\sum_{i=1}^N (X_i - \bar{X})^2} \, \sqrt{\sum_{i=1}^N (Y_i - \bar{Y})^2}},
    $$

    with $r^2$ used for reporting. Correlations were calculated separately for each population, phenotype, and feature type (array or LPS), and visualized in bar chart.



=== "ADPR"
    ## Absolute Difference in Percentile Ranking (ADPR)

    Absolute Difference in Percentile Ranking (ADPR) complements this by {==assessing the stability of individuals’ relative positions==} between platforms, which is critical for downstream applications such as risk stratification and clinical decision-making.

    To quantify concordance in relative standing between platforms, raw PGS values were transformed to within-platform percentiles using the empirical cumulative distribution function (ECDF):
    
    $$
    p^{(m)}_i = \frac{\mathrm{rank}_m(i)}{N},
    $$

    where $p^{(m)}_i$ denotes the percentile of individual $i$ in method $m$ (array/LPS or WGS), $\mathrm{rank}_m(i)$ is the individual’s rank, and $N$ is the sample size.

    The Absolute Difference in Percentile Ranking for individual $i$ was defined as:
    
    $$
    ADPR_i = \left| p^{(\mathrm{array/LPS})}_i - p^{(\mathrm{WGS})}_i \right| \times 100,
    $$
    
    expressed in percentage points. An ADPR of $0\%$ indicates identical rankings, whereas higher values denote greater rank displacement between platforms. ADPR values were summarised across populations, phenotypes, and feature types, and visualised to assess platform-specific deviations in ranking concordance.


