!!! abstract "Requirements"
    - Ubuntu 22.04 (8 CPUs, 32 GB)
    - bcftools (version==1.13)

=== "Low-pass sequencing data"
    ## Low-pass sequencing data
    ### Input data 

    ### Merge imputed data

    Merge samples from imputed batches
    ```bash
    --8<--
    evaluation/merge_sample/lps/MERGE_batches.sh
    --8<--
    ```
    ### Prepare true resident VCFs
    ```bash
    --8<--
    evaluation/merge_sample/lps/VCF_true_population_slipt.sh
    --8<--
    ```

    ### Prepare imputed resident VCFS
    Prepare imputed VCFs being reranged by supperpopulation
    ```bash
    --8<--
    evaluation/merge_sample/lps/VCF_imputed_population_slipt.sh
    --8<--
    ```


    ### Output data

=== "Pseudo SNP Arrays data"
    ## Pseudo SNP Arrays data
    ### Input data

    ### Merge imputed data
    ```bash
    --8<--
    evaluation/merge_sample/array/MERGE_batches.sh
    --8<--
    ```
    ### Prepare true resident VCFs
    ```bash
    --8<--
    evaluation/merge_sample/lps/VCF_true_population_slipt.sh
    --8<--
    ```

    ### Prepare imputed resident VCFS
    ```bash
    --8<--
    evaluation/merge_sample/array/VCF_imputed_population_slipt.sh
    --8<--
    ```

    ### Output data