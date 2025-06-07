set -ue

## Input
BATCH_NUM=$1
CHR=$2
ARRAY_NAME=$3

## Extract reference
bcftools view        -S ^batch_${BATCH_NUM}.txt chr${CHR}.vcf.gz |\
bcftools annotate    --rename-chrs rename_chr.txt \
                     -Oz -o ref_chr${CHR}.vcf.gz

bcftools index -f ref_chr${CHR}.vcf.gz

## Do phasing
bcftools index -f ${ARRAY_NAME}_chr${CHR}.vcf.gz

shapeit5_phase_common_static --input ${ARRAY_NAME}_chr${CHR}.vcf.gz   \
                             --reference ref_chr${CHR}.vcf.gz         \
                             --region 4 --map chr${CHR}.b38.gmap.gz   \
                             --thread 8                               \
                             --output phased_${ARRAY_NAME}_chr${CHR}.bcf