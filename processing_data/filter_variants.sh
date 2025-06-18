set -ue

RAW_VCF=$1
SAMPLE_LIST=$2
FILTERED_VCF=$3

# Get samples in each batch and filtering to get biallelic variants
bcftools view \
    -S $SAMPLE_LIST $RAW_VCF  \
    -m2 -M2 \
    -v snps |
bcftools view \
    --exclude 'AC<=2' \
    -Oz -o $FILTERED_VCF

# Indexing the filtered VCF
bcftools index -f $FILTERED_VCF