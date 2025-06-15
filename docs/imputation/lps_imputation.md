!!! abstract "Requirements"
    - Ubuntu 22.04 (8 CPUs, 32 GB)
    - bcftools (version==1.13)
    - GLIMPSE2 v2.0.0, commit: 8ce534f, release: 2023-06-29

!!! tip "Inputs"
    - [Samples list of batch][4]
    - [Phasing reference][5]
    - Imputation panel
    - Downsampling VCFs

## Low-pass imputation process

### Prepare imputation reference
Make GLIMPSE2 imputation reference data ([gen_ref_batch.sh][2], [buid_ref.sh][3])

### Imputation process 
Joint phasing and imputation: `GLIMPSE2` ([run_imputation_bam_list.sh][1])

```bash linenums="1"
--8<--
imputation/lowpass_imputation/Bam2Vcf.sh
--8<--
```

## Output data


[1]: https://github.com/KTest-VN/lps_paper/blob/main/imputation/lowpass_imputation/bin/run_imputation_bam_list.sh
[2]: https://github.com/KTest-VN/lps_paper/blob/main/imputation/lowpass_imputation/bin/gen_ref_batch.sh
[3]: https://github.com/KTest-VN/lps_paper/blob/main/imputation/lowpass_imputation/bin/buid_ref.sh
[4]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/maps 
[5]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/sample_list