## Requirement
- Docker (version &ge; 26.1.1)
- Images: [ndatth/ubuntu:22.04](https://hub.docker.com/r/ndatth/ubuntu/tags) 
- Ubuntu (8 CPUs, 32 GB)

## Input data

- [SNP-array data][3][@nguyen2022comprehensive]
- [Batch_sample_list][2]
- Pseudo VCFs

## Array imputation process

### Prepare imputation reference

```bash linenums="1"
--8<--
imputation/pseudo-array_imputation/_prepare_ref.sh
--8<--
```
### Prepare 

1. GET_target_vcf
2. GET_pseudo_array

3. DO_index_minimac3
4. IMPUTE_minimac4

## Output data





[2]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/sample_list
[3]: https://github.com/KTest-VN/lps_paper/tree/main/support_data/array_hg38