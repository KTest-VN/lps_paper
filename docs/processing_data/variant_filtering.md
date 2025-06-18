!!! info "Requirements"
    - Ubuntu 22.04 (8 CPUs, 32 GB)
    - bcftools (version==1.13)

!!! input
    - [3202 samples 1KGP][2][@byrska2022high]
    - [2504 samples list][5]


## Download high-coverage VCF files

From 1000 Genome Project, we download high-coverage (30X) VCF files containing 3202 samples ([folder link][2]).

!!! warning
    Be sure to {==verify the MD5 checksums of the VCF files==}. Due to their large size, file transfers may be prone to interruption or corruption during transmission.

??? code
    Code was used to download VCF files containing 3202 samples.
    ```bash linenums="1"
    --8<-- "processing_data/download_total_vcf.sh"
    ```
    [md5sum_meta][3] contains information to verified md5sum of downloaded VCF files ([source][4])


## Filtering variants

VCF files were filtered to retain only bi-allelic SNPs with an allele count ≥ 2 to reduce noise in imputation and evaluation.

??? code
    ```bash linenums="1"
    --8<-- "processing_data/filter_variants.sh"
    ```

    [Sample list][5] of 2504 selected samples.


!!! output
    - Raw imputation panel





[1]: https://github.com/KTest-VN/lps_paper/blob/main/imputation/lowpass_imputation/bin/download_2504_AC_filter.sh
[2]: https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased
[3]: https://github.com/KTest-VN/lps_paper/blob/main/processing_data/phased-manifest_July2021.tsv
[4]: https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased/phased-manifest_July2021.tsv
[5]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/2504_samples.txt