set -ue

ARRAY=global-screening-array-v.3
CHR=22

bcftools view -Oz -o tem_${ARRAY}_chr${CHR}.vcf.gz phased_${ARRAY}_chr${CHR}.bcf
bcftools index -f tem_${ARRAY}_chr${CHR}.vcf.gz


minimac4 --refHaps m3vcf_ref_chr${CHR}.m3vcf.gz         \
         --ChunkLengthMb 50         \
         --ChunkOverlapMb 5         \
         --haps tem_${ARRAY}_chr${CHR}.vcf.gz         \
         --format GT,DS,GP        \
         --prefix imputed_${ARRAY}_chr${CHR}        \
         --ignoreDuplicates         \
         --cpus 8         \
         --vcfBuffer 1100

rm tem_${ARRAY}_chr${CHR}.vcf.*