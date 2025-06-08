set -ue

BATCH_NUM=$1
CHR=$2
ARRAY=$3

## Inputs
BATCH_SAMPLE_LIST=batch_${BATCH_NUM}.txt
REFERENCE_VCF=chr${CHR}.vcf.gz
POS_FILES=$ARRAY:chr${CHR}.txt

## Extract samples
bcftools view  -S ${BATCH_SAMPLE_LIST} ${REFERENCE_VCF} |\
bcftools annotate   --rename-chrs rename_chr.txt  \
                    -Oz -o target_chr${CHR}.vcf.gz

bcftools index -f target_chr${CHR}.vcf.gz

## Create pseudo array data
get_pseudo_array.sh ${POS_FILES} target_chr${CHR}.vcf.gz ${ARRAY}_chr${CHR}.vcf.gz