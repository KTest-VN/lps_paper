#!/usr/bin/env bash

set -euo pipefail

# Ensure the required arguments are passed
if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <batch_dir> <order_samples> <output_prefix>"
    exit 1
fi

# Assign input arguments to variables
batch_dir="$1"
list_partern="$2"
out_fn="$3"

# List all files matching the pattern within the batch directory
files=$(ls "${batch_dir}"/batch_*/imputed_"${list_partern}".dose.vcf.gz)
#imputed_Axiom_JAPONICA_chr5.dose.vcf.gz
# Index each file using bcftools
for fi in $files; do
    bcftools index -f "$fi"
done

# Merge and process the files
bcftools merge --force-samples -0 $files | \
    sed 's/0\/0:.:./0|0:0:1/g' | \
    bgzip > ${out_fn}
