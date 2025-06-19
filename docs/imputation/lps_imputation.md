!!! abstract "Requirements"
    - Ubuntu 22.04 (8 CPUs, 32 GB)
    - bcftools (version==1.13)
    - GLIMPSE2 v2.0.0, commit: 8ce534f, release: 2023-06-29

!!! input "Input data"
    - [Samples list of batch][4]
    - [Phasing reference][5]
    - Imputation panel
    - Downsampling VCFs

## Low-pass imputation process

### Prepare imputation reference

!!! code
    Make GLIMPSE2 imputation reference data
    ```bash linenums="1"
    --8<-- "imputation/lowpass_imputation/bin/gen_ref_batch.sh"
    ```
    [build_ref.sh][3] splices raw reference panels (VCF files) to prepare the imputation panel for the GLIMPSE2 imputation process (bin files). 

### Imputation process 

!!! code
    ```bash linenums="1"
    --8<--
    imputation/lowpass_imputation/Bam2Vcf.sh
    --8<--
    ```
    Imputation processing on autosomes and ligating using `GLIMPSE2` ([run_imputation_bam_list.sh][1])

!!! output "Output data"
    - lpWGS VCF files


[1]: https://github.com/KTest-VN/lps_paper/blob/main/imputation/lowpass_imputation/bin/run_imputation_bam_list.sh
[2]: https://github.com/KTest-VN/lps_paper/blob/main/imputation/lowpass_imputation/bin/gen_ref_batch.sh
[3]: https://github.com/KTest-VN/lps_paper/blob/main/imputation/lowpass_imputation/bin/buid_ref.sh
[4]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/maps 
[5]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/sample_list