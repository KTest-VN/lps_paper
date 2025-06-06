set -ue

BATCH_NUM=9
CHR=1

bcftools view         -S batch_${BATCH_NUM}.txt chr${CHR}.vcf.gz         \
| bcftools annotate   --rename-chrs rename_chr.txt       \
                      -Oz -o target_chr${CHR}.vcf.gz

bcftools index -f target_chr${CHR}.vcf.gz