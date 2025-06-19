!!! abstract "Requirements"
    - Ubuntu 22.04 (8 CPUs, 32 GB)
    - bcftools (version==1.13)
    - shapeit5 (version==5.1.1)
    - Minimac3 (version==2.0.1)
    - Minimac4 (version==1.0.3)

!!! input "Input data"
    - [Samples list of batch][2]
    - [Phasing reference][1]
    - Imputation panel
    - Pseudo array VCFs

### Prepare imputation reference

!!! code
    This script extracts a reference panel, phases pseudo SNP array data using Shapeit5, and prepares the reference for imputation by indexing it in Minimac3 format

    ```bash linenums="1"
    --8<--
    imputation/pseudo-array_imputation/_prepare_ref.sh
    --8<--
    ```
    [rename_chr.txt][5] was used to convert to chromosome numeric format. 

### Imputation process 

!!! code
    Genotype imputation is performed using Minimac4. The phased BCF file is converted and indexed, imputed against a reference panel, and temporary files are removed upon completion.
    ```bash linenums="1"
    --8<--
    imputation/pseudo-array_imputation/impute_minimac4.sh
    --8<--
    ```

!!! output "Output data"
    - SNP-array VCF files




[1]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/maps 
[2]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/sample_list
[4]: https://github.com/KTest-VN/lps_paper/tree/main/imputation/pseudo-array_imputation/bin
[5]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/rename_chr.txt