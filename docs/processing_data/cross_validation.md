- Ten-fold cross-validation was performed on the selected 2,504 non-trio samples.
- Samples were divided into 10 batches and stratified by superpopulation (EAS, EUR, SAS, AFR, AMR) to ensure balanced representation. In this study, superpopulations are treated as populations.
    - 4 batches of 251 samples
    - 6 batches of 250 samples
- In each fold:
    - 90% of data serves as the reference panel.
    - 10% of data serves as the target set for imputation (using to prepare true VCFs and downsampled/psudo-array inputs).

!!! output
    - [Samples list of batch][2]
    - [2504 samples list][8]
    - [Population meta][10]

[2]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/sample_list
[8]: https://github.com/KTest-VN/lps_paper/blob/main/support_data/2504_samples.txt
[10]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/2504_infos.tsv