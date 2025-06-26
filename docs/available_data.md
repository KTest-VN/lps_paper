## License

This dataset is released under the [CC0 1.0 Universal (Public Domain Dedication)](https://creativecommons.org/publicdomain/zero/1.0/).

You are free to copy, modify, distribute, and use the data for any purpose, even commercially, without asking permission.

> No attribution is required, but citation is appreciated if you find this dataset useful.

## Disclosing data


::spantable::

| Process                   | Step                       | Input                                                                                                              | Output      |
|---------------------------|----------------------------|--------------------------------------------------------------------------------------------------------------------|-------------|
| Processing data  @span    | [Cross-Validation Framework](processing_data/cross_validation.md) |                                                                                                                    | - [Samples list of batch][2]<br> - [2504 samples list][8]<br> - [Population meta][10]             |
|    | [Variant Filtering](processing_data/variant_filtering.md)          | - [3202 samples 1KGP][7][@byrska2022high]<br> - [2504 samples list][8]                                                                                                                    | - Raw imputation panel            |
|                           | [Data Simulation](processing_data/data_simulation.md)            | - [SNP-array pos data][3][@nguyen2022comprehensive]<br>- [Samples list of batch][2]<br>- Raw imputation panel<br>- [GRCh38/hg38][4]<br>- [URL metadata][6]                                                                                                                    | - Pseudo array VCFs <br>- Downsampling VCFs|
| Genotype Imputation @span | [lpWGS  imputation](imputation/lps_imputation.md)          | - [Samples list of batch][2]<br>- [Phasing reference][1]<br>- Raw imputation panel<br>- Downsampling VCFs                                               | - lpWGS VCF files        |
|                           | [SNP arrays imputation](imputation/array_imputation.md)      | - [Samples list of batch][2]<br>- [Phasing reference][1]<br>- Raw imputation panel<br>- Pseudo array VCFs | - SNP-array VCF files            |
| Evaluation @span          | [Restructure imputed data](evaluation/restructure_imputed_data.md)         | - lpWGS VCF files<br>- SNP-array VCF files<br>- [Population meta][10]<br> - Raw imputation panel                                                                                                                    | - restructed lpWGS VCFs<br>- restructed SNP-array VCFs<br>- True VCFs            |
|                           | [lpWGS performance](evaluation/lps_performance.md)          | - restructed lpWGS VCFs<br>- restructed SNP-array VCFs<br>- True VCFs                                                                                                                    | - [LPS-arrays evaluation output][11]            |
|                           | [PRS performance](evaluation/prs_performace.md)            | - restructed lpWGS VCFs<br>- restructed SNP-array VCFs<br>- True VCFs                                                                                                                    | - [Raw PRS scores][9]<br>- [Percentile PRS scores][12]<br>- [Visualized figures][13]<br>- [Visualized tables][14]           |

::end-spantable::


[1]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/maps 
[2]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/sample_list
[3]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/input_array
[4]: https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/
[6]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/meta_10_folds
[7]: https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased
[8]: https://github.com/KTest-VN/lps_paper/blob/main/support_data/2504_samples.txt
[9]: https://github.com/KTest-VN/lps_paper/tree/main/evaluation/downstream/data/raw_prs_scores
[10]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/2504_infos.tsv
[11]: https://github.com/KTest-VN/lps_paper/tree/main/evaluation/downstream/data/raw_snpwise_accuracy
[12]: https://github.com/KTest-VN/lps_paper/tree/main/evaluation/downstream/data/process_prs_scores
[13]: https://github.com/KTest-VN/lps_paper/tree/main/evaluation/downstream/out_figs 
[14]: https://github.com/KTest-VN/lps_paper/tree/main/evaluation/downstream/out_tables 