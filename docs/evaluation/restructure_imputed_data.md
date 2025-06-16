!!! abstract "Requirements"
    - Ubuntu 22.04 (8 CPUs, 32 GB)
    - bcftools (version==1.13)

=== "Low-pass sequencing data"
    ## Low-pass sequencing data
    !!! input "Input data"
        - lpWGS VCF files
        - Population meta

    ### Merge imputed data

    Merge samples from imputed batches
    ```bash linenums="1"
    --8<--
    evaluation/merge_sample/lps/MERGE_batches.sh
    --8<--
    ```
    
    - [merge_batches.sh][1]
    - [rename_samples.sh][2]

    ### Restruct imputed LPS VCFs
    Imputed VCFs is restructured by supperpopulation
    ```bash linenums="1"
    --8<--
    evaluation/merge_sample/lps/VCF_imputed_population_slipt.sh
    --8<--
    ```

    !!! output "Output data"
        - restructed lpWGS VCFs

=== "Pseudo SNP Arrays data"
    ## Pseudo SNP Arrays data
    !!! input "Input data"
        - SNP-array VCF files
        - Population meta

    ### Merge imputed data
    ```bash linenums="1"
    --8<--
    evaluation/merge_sample/array/MERGE_batches.sh
    --8<--
    ```

    - [merge_array_batches.sh][3]

    ### Restruct imputed Pseudo-array VCFs
    ```bash linenums="1"
    --8<--
    evaluation/merge_sample/array/VCF_imputed_population_slipt.sh
    --8<--
    ```

    !!! output "Output data"
        - restructed SNP-array VCFs

=== "True VCFs"
  
    ## Prepare true VCFs according supperpopulation

    !!! input "Input data"
        - Imputation panel
        - Population meta

    ### Processing

    ```bash linenums="1"
    --8<--
    evaluation/merge_sample/lps/VCF_true_population_slipt.sh
    --8<--
    ```

    !!! output "Output data"
        - True VCFs being collected by supperpopulation


[1]: https://github.com/KTest-VN/lps_paper/blob/main/evaluation/merge_sample/bin/merge_batches.sh
[2]: https://github.com/KTest-VN/lps_paper/blob/main/evaluation/merge_sample/bin/rename_samples.sh
[3]: https://github.com/KTest-VN/lps_paper/blob/main/evaluation/merge_sample/bin/merge_array_batches.sh