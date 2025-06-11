## License

This dataset is released under the [CC0 1.0 Universal (Public Domain Dedication)](https://creativecommons.org/publicdomain/zero/1.0/).

You are free to copy, modify, distribute, and use the data for any purpose, even commercially, without asking permission.

> No attribution is required, but citation is appreciated if you find this dataset useful.

## Disclosing data


::spantable::

| Process                   | Step                       | Input                                                                                                              | Output      |
|---------------------------|----------------------------|--------------------------------------------------------------------------------------------------------------------|-------------|
| Processing data  @span    | Cross-Validation Framework |                                                                                                                    | - [Samples list of batch][2]<br> - [2504 samples list][8]             |
|    | Variant Filtering          | - [3202 samples 1KGP][7][@byrska2022high]<br> - [2504 samples list][8]                                                                                                                    | - Imputation panel            |
|                           | Data Simulation            | - [SNP-array pos data][3][@nguyen2022comprehensive]<br>- [Samples list of batch][2]<br>- Imputation panel<br>- [GRCh38/hg38][4]<br>- [URL metadata][6]                                                                                                                    | - Pseudo array VCFs <br>- Downsampling VCFs|
| Genotype Imputation @span | lpWGS  imputation          | - [Samples list of batch][2]<br>- [Phasing reference][1]<br>- Imputation panel<br>- Downsampling VCFs                                               | - lpWGS VCF files        |
|                           | SNP arrays imputation      | - [Samples list of batch][2]<br>- [Phasing reference][1]<br>- Imputation panel<br>- Pseudo array VCFs | - SNP-array VCF files            |
| Evaluation @span          | Merge imputed data         | - lpWGS VCF files<br>- SNP-array VCF files<br>- Population meta                                                                                                                    | - resample lpWGS VCFs<br>- resample SNP-array VCFs            |
|                           | lpWGS performance          | - resample lpWGS VCFs<br>- resample SNP-array VCFs                                                                                                                    |             |
|                           | PRS performance            | - resample lpWGS VCFs<br>- resample SNP-array VCFs                                                                                                                    |             |

::end-spantable::


[1]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/maps 
[2]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/sample_list
[3]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/input_array
[4]: https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/
[6]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/meta_10_folds
[7]: https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased
[8]: https://github.com/KTest-VN/lps_paper/blob/main/imputation/lowpass_imputation/bin/download_2504_AC_filter.sh
