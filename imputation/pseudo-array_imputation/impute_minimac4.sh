set -ue

ARRAY=$1
CHR=$2

## Input
PHASED_BCF=phased_${ARRAY}_chr${CHR}.bcf
MINIMAC3_INDEX_VCF=m3vcf_ref_chr${CHR}.m3vcf.gz

## Imputation
bcftools view -Oz -o tem_${ARRAY}_chr${CHR}.vcf.gz ${PHASED_BCF}
bcftools index -f tem_${ARRAY}_chr${CHR}.vcf.gz


minimac4 --refHaps ${MINIMAC3_INDEX_VCF}         \
         --ChunkLengthMb 50                      \
         --ChunkOverlapMb 5                      \
         --haps tem_${ARRAY}_chr${CHR}.vcf.gz    \
         --format GT,DS,GP                       \
         --prefix imputed_${ARRAY}_chr${CHR}     \
         --ignoreDuplicates                      \
         --cpus 8                                \
         --vcfBuffer 1100

rm tem_${ARRAY}_chr${CHR}.vcf.*