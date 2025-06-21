set -ue

POPULATION_META=$1
POP_NAME=$2
MERGED_VCF=$3
CHR=$4
LPS_COV=$5

## Get sample list for the specified population
awk -F'\t' -v pop_name=${POP_NAME} 'NR!=1 && $6==pop_name {print $1}' ${POPULATION_META} > ${POP_NAME}_sample_list.txt

# Filter the merged VCF for the specified population
bcftools view -S ${POP_NAME}_sample_list.txt ${MERGED_VCF} | bgzip > chr${CHR}_${LPS_COV}_${POP_NAME}_imputed.vcf.gz