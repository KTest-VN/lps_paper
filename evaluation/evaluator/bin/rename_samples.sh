#!/usr/bin/env bash

set -euo pipefail

# Ensure the required arguments are provided
if [[ $# -ne 4 ]]; then
    echo "Usage: $0 <input_vcf> <remove_string> <output_vcf> <order_samples>"
    exit 1
fi

# Assign input arguments to variables
input_vcf="$1"
remove_string="$2"
output_vcf="$3"
order_samples="$4"

# Step 1: Extract sample names from the VCF
bcftools query -l "$input_vcf" > original_samples.txt

# Step 2: Remove the specified string from sample names
sed "s/${remove_string}//g" original_samples.txt > modified_samples.txt

# Step 3: Create a mapping file for renaming
paste original_samples.txt modified_samples.txt > sample_map.txt

# Step 4: Reheader the VCF with new sample names
bcftools reheader -s sample_map.txt "$input_vcf" | bcftools view -S $order_samples | bgzip > "$output_vcf"

# Clean up temporary files
rm original_samples.txt modified_samples.txt sample_map.txt

echo "Reheadered VCF written to $output_vcf"
