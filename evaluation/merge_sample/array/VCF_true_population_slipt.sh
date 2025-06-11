set -ue

## Input
SAMPLE_BY_POP_LIST=$1
POP_NAME=$2
TRUE_VCF=$3
CHR=$4

## VCF_true_population_slipt
bcftools view -S ${SAMPLE_BY_POP_LIST} ${TRUE_VCF} | bgzip > chr${CHR}_${POP_NAME}_true.vcf.gz