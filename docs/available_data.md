## License

This dataset is released under the [CC0 1.0 Universal (Public Domain Dedication)](https://creativecommons.org/publicdomain/zero/1.0/).

You are free to copy, modify, distribute, and use the data for any purpose, even commercially, without asking permission.

> No attribution is required, but citation is appreciated if you find this dataset useful.

## Summary all regarding data 

::spantable::

| Process               | Step                         | Input                                              | Output                                    |
|-----------------------|------------------------------|----------------------------------------------------|-------------------------------------------|
| Prepare data  @span   | Reference panel              |                                                    |                                           |
|                       | Prepare mapping reference    |                                                    | mapping reference                         |
|                       | Prepare phasing reference    |                                                    | [b38.gmap][1]                    |
|                       | Prepare SNP data of 8 arrays | [Nguyen et al., 2022][2][@nguyen2022comprehensive] | [SNP-array data][3]                       |
|                       | Prepare meta data            |                                                    | - batch_samples_list<br>- samplesheet.csv |
| LPS performance @span | Processing data              |                                                    |                                           |
|                       | LPS imputation               |                                                    |                                           |
|                       | Array imputation             |                                                    |                                           |
|                       | LPS performance              |                                                    |                                           |
| PRS performance @span | PRS processing               |                                                    |                                           |
|                       | PRS performance              |                                                    |                                           |

::end-spantable::


[1]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/maps 
[2]: https://github.com/datngu/SNP_array_comparison/tree/main/data/Array_manifests_bed_hg38
[3]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/array_hg38
