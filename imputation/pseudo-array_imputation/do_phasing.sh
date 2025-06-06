set -ue

ARRAY=cytosnp-850k-v1.2
CHR=4

bcftools index -f ${ARRAY}_chr${CHR}.vcf.gz

shapeit5_phase_common_static --input ${ARRAY}_chr${CHR}.vcf.gz         \
                             --reference ref_chr${CHR}.vcf.gz         \
                             --region 4 --map chr${CHR}.b38.gmap.gz         \
                             --thread 8         \
                             --output phased_${ARRAY}_chr${CHR}.bcf