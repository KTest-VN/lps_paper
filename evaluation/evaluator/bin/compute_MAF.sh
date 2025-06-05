#!/bin/bash
set -euo pipefail
# Input and output files
input_vcf="$1"   # Replace with your input VCF file
output_file="$2"  # Replace with your desired output file name

# Recompute MAF and extract variant ID and MAF
bcftools +fill-tags ${input_vcf} -- -t AF | bcftools query -f '%ID\t%INFO/AF\n' > ${output_file}

