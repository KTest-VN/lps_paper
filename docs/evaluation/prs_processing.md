# PRS processing

!!! abstract "Requirements"
    - Ubuntu 22.04 (8 CPUs, 32 GB)
    - bcftools (version==1.13)
    - plink v1.90
    - PRSice-2 v2.3.3

!!! input "Input data"
    - restructed lpWGS VCFs
    - restructed SNP-array VCFs
    - True VCFs

## Correct sample name

Ensure that sample names do not contain underscores, as these may be introduced during the merging of imputed VCF files. In such cases, the filename used during merging may be incorporated into the sample name to maintain uniqueness across datasets.

!!! code
    ```bash linenums="1"
    ---8<--- "evaluation/prs_evaluation/CORRECT_SAMPLE_NAME.sh"
    ```

## Concate VCF files

Concat autosome VCF files have same prefix (Array name/ lowpass coverage).

!!! code
    ```bash linenums="1"
    ---8<--- "evaluation/prs_evaluation/CONCAT_VCF.sh"
    ```

## Annotate VCF files

!!! code
    ```bash linenums="1"
    ---8<--- "evaluation/prs_evaluation/ANNOTATE_VCF.sh"
    ```

## Convert VCF files to BED files

!!! code
    ```bash linenums="1"
    ---8<--- "evaluation/prs_evaluation/VCF_TO_BED.sh"
    ```

## QC VCF files

!!! code
    ```bash linenums="1"
    ---8<--- "evaluation/prs_evaluation/QC.sh"
    ```

## Deduplicate

!!! code
    ```bash linenums="1"
    ---8<--- "evaluation/prs_evaluation/DEDUPLICATE.sh"
    ```

    - [LIST_NO_DUPLICATE.R][1]

## Get PRS score

!!! code
    ```bash linenums="1"
    ---8<--- "evaluation/prs_evaluation/GET_PRS.sh"
    ```

!!! output "Output data"
    - [Raw PRS scores][2]

[1]: https://github.com/KTest-VN/lps_paper/blob/main/evaluation/prs_evaluation/LIST_NO_DUPLICATE.R
[2]: https://github.com/KTest-VN/lps_paper/tree/main/evaluation/downstream/data/raw_prs_scores