## License

This dataset is released under the [CC0 1.0 Universal (Public Domain Dedication)](https://creativecommons.org/publicdomain/zero/1.0/).

You are free to copy, modify, distribute, and use the data for any purpose, even commercially, without asking permission.

> No attribution is required, but citation is appreciated if you find this dataset useful.

## Disclosing data


::spantable::

| Process                   | Step                       | Input                                                                                                              | Output      |
|---------------------------|----------------------------|--------------------------------------------------------------------------------------------------------------------|-------------|
| Processing data  @span    | Variant Filtering          |                                                                                                                    |             |
|                           | Data Simulation            | - [SNP-array pos data][3][@nguyen2022comprehensive]<br>- [Batch_sample_list][2]<br>- Imputation panel                                                                                                                    | - Pseudo array VCFs <br>- Downsampling VCFs|
|                           | Cross-Validation Framework |                                                                                                                    |             |
| Genotype Imputation @span | lpWGS  imputation          | - [GRCh38/hg38][4]<br>- [Phasing reference][1]<br>- Imputation panel<br>- Downsampling VCFs                                               |             |
|                           | SNP arrays imputation      | - [Batch_sample_list][2]<br>- [Phasing reference][1]<br>- Imputation panel<br>- Pseudo array VCFs |             |
| Evaluation @span          | Merge imputed data         |                                                                                                                    |             |
|                           | lpWGS performance          |                                                                                                                    |             |
|                           | PRS performance            |                                                                                                                    |             |

::end-spantable::


[1]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/maps 
[2]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/sample_list
[3]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/input_array
[4]: https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/
