set -ue

## Input
POPULATION_META=$1
POP_NAME=$2
TRUE_VCF=$3
CHR=$4

## Get sample list for the specified population
awk -F'\t' -v pop_name=${POP_NAME} 'NR!=1 && $6==pop_name {print $1}' ${POPULATION_META} > ${POP_NAME}_sample_list.txt

## VCF_true_population_slipt
bcftools view -S ${POP_NAME}_sample_list.txt ${TRUE_VCF} | bgzip > chr${CHR}_${POP_NAME}_true.vcf.gz