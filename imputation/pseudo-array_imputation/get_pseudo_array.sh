set -ue

ARRAY=infinium-omni2.5
CHR=1

get_pseudo_array.sh $ARRAY:chr${CHR}.txt target_chr${CHR}.vcf.gz ${ARRAY}_chr${CHR}.vcf.gz