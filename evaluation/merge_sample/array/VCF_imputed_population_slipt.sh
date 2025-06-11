set -ue

SAMPLE_BY_POP_LIST=$1
POP_NAME=$2
MERGED_VCF=$3
CHR=$4
LPS_COV=$5

bcftools view -S ${SAMPLE_BY_POP_LIST} ${MERGED_VCF} | bgzip > chr${CHR}_${LPS_COV}_${POP_NAME}_imputed.vcf.gz