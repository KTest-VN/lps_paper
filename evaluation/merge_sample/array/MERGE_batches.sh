set -ue

## Input
CHR=$1
IMPUTED_FOLDER=$2
LPS_COV=$3

merge_array_batches.sh ${IMPUTED_FOLDER} "${LPS_COV}_chr${CHR}" "chr${CHR}_${LPS_COV}_merged_all.vcf.gz"