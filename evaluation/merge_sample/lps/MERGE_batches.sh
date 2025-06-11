set -ue

## Input
CHR=$1
IMPUTED_FOLDER=$2
LPS_COV=$3
TOTAL_SAMPLE=$4

## Merge batches
merge_batches.sh ${IMPUTED_FOLDER} "chr${CHR}_${LPS_COV}" "tem.vcf.gz"
rename_samples.sh tem.vcf.gz "_${LPS_COV}" chr${CHR}_${LPS_COV}_merged_all.vcf.gz ${TOTAL_SAMPLE}
rm tem.vcf.gz