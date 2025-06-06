set -ue

BATCH_NUM=9
CHR=1

bcftools view        -S ^batch_${BATCH_NUM}.txt chr${CHR}.vcf.gz  \
| bcftools annotate  --rename-chrs rename_chr.txt \
                     -Oz -o ref_chr${CHR}.vcf.gz

bcftools index -f ref_chr${CHR}.vcf.gz