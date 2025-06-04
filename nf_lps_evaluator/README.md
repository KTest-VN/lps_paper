# nf\_lps\_evaluator

`nf_lps_evaluator` is a Nextflow pipeline designed to evaluate the performance of genotype imputation protocols by computing the correlation between imputed genotype dosages and ground truth genotypes derived from high-coverage sequencing data.

---

## How to Use

### 1. Merge Mini-Batches (LPS Outputs Only)

In our project, we process low-pass sequencing (LPS) data in four mini-batches, each containing approximately 63 samples. These mini-batch outputs must be merged before evaluation.
Use the script `run_merge_b1-10.sh`, which executes the Nextflow workflow `merge_mini_batches.nf`.

Run this script 10 times for 10 batches. Each execution merges the four mini-batch outputs into a single dataset, which ensures LPS data is processed through the same (or as similar as possible) evaluation pipeline used for array-based data.

### 2. Compute Imputation Performance

Two main Nextflow scripts are provided:

* `main_array.nf`: for evaluating array-based imputation
* `main_lps.nf`: for evaluating low-pass sequencing imputation

These pipelines are mostly similar but differ slightly in sample ID handling. You may need to adjust them to match your project-specific naming or data structure.

#### Requirements:

* Ground truth genotypes (QCed), preferably the same dataset used to simulate array genotypes.
* Sample ID list for filtering.
* Population metadata (sample-to-population mapping).
* Imputed genotype dosages (array or merged LPS output).

Run the appropriate pipeline based on your data source. Evaluation results will include imputation performance metrics such as correlation to the ground truth.

