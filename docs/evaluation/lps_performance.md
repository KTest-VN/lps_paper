## Evaluation methods
![evaluate methods](../assets/img/evaluate_methods.png)

To assess imputation performance, two key metrics are used: {==Imputation Accuracy==} and {==Imputation Coverage==}. These metrics quantify the quality and completeness of imputed genetic variants, and are calculated per chromosome across all autosomes.

| Metric                  | Description                                     | Purpose                                                |
|-------------------------|-------------------------------------------------|--------------------------------------------------------|
| **Imputation Accuracy** | Mean $r^2$ of sites within a bin                 | Measures how well imputed values match true genotypes  |
| **Imputation Coverage** | Proportion of variants with $r^2 \geq 0.8$ in a bin | Assesses the proportion of high-confidence imputations |

## Evaluation process

!!! input "Input data"
    - restructed lpWGS VCFs
    - restructed SNP-array VCFs
    - True VCFs

=== "Evaluate imputation by SNPs"
    !!! code
        ```bash  linenums="1"
            --8<-- "evaluation/lps_evaluation/EVALUATE_imputation.sh"
        ``` 

        - [compute_MAF.sh][1]: Retrive MAF values from true VCF files
        - [run_evaluate.py][2]: Evaluation using SNP-wise matrix 

=== "Evaluate imputation accuracy by bin" 
    !!! code
        ```bash linenums="1"
          --8<-- "evaluation/lps_evaluation/COMPUTE_accuracy_perbin.sh"
        ```
        
        - [get_coverage.py][3]: Evaluation using Imputation coverage matrix  

!!! output
    Evaluation process output:
    
    |                     | LPS                  | Pseudo array           |
    |:--------------------|:---------------------|:-----------------------|
    | SNP-wise accuracy   | [lps_all_acc.txt][6] | [array_all_acc.txt][4] |
    | Imputation accuracy | [lps_all_cov.txt][7] | [array_all_cov.txt][5] |

[1]: https://github.com/KTest-VN/lps_paper/blob/main/evaluation/lps_evaluation/bin/compute_MAF.sh
[2]: https://github.com/KTest-VN/lps_paper/blob/main/evaluation/lps_evaluation/bin/run_evaluate.py
[3]: https://github.com/KTest-VN/lps_paper/blob/main/evaluation/lps_evaluation/bin/get_coverage.py
[4]: https://github.com/KTest-VN/lps_paper/blob/main/evaluation/downstream/data/raw_snpwise_accuracy/array_all_acc.txt
[5]: https://github.com/KTest-VN/lps_paper/blob/main/evaluation/downstream/data/raw_snpwise_accuracy/array_all_cov.txt
[6]: https://github.com/KTest-VN/lps_paper/blob/main/evaluation/downstream/data/raw_snpwise_accuracy/lps_all_acc.txt
[7]: https://github.com/KTest-VN/lps_paper/blob/main/evaluation/downstream/data/raw_snpwise_accuracy/lps_all_cov.txt