#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <variant_list> <target_vcf> <output_vcf>"
    exit 1
fi

# Assign arguments to variables
VARIANT_LIST=$1
TARGET_VCF=$2
OUTPUT_VCF=$3

# Execute the command

##bcftools index -f $TARGET_VCF

bcftools view -R "$VARIANT_LIST" "$TARGET_VCF" \
    | sed 's/0|0/0\/0/g' \
    | sed 's/0|1/1\/0/g' \
    | sed 's/1|0/1\/0/g' \
    | sed 's/1|1/1\/1/g' \
    | bgzip > "$OUTPUT_VCF"
