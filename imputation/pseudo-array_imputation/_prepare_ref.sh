set -ue

BATCH_NUM=$1
CHR=$2
ARRAY_NAME=$3

## Input
BATCH_SAMPLE_LIST=batch_${BATCH_NUM}.txt
REFERENCE_VCF=chr${CHR}.vcf.gz
PSEUDO_ARRAY_VCF=${ARRAY_NAME}_chr${CHR}.vcf.gz
PHASING_REFERENCCE=ref_chr${CHR}.vcf.gz

## Extract reference
bcftools view        -S ^${BATCH_SAMPLE_LIST} ${REFERENCE_VCF} |\
bcftools annotate    --rename-chrs rename_chr.txt \
                     -Oz -o ref_chr${CHR}.vcf.gz

bcftools index -f ref_chr${CHR}.vcf.gz

## Phasing
shapeit5_phase_common_static --input ${PSEUDO_ARRAY_VCF}   \
                             --reference ref_chr${CHR}.vcf.gz         \
                             --region 4 --map ${PHASING_REFERENCCE}   \
                             --thread 8                               \
                             --output phased_${ARRAY_NAME}_chr${CHR}.bcf

## Indexing by Minimac3
Minimac3 --refHaps ref_chr${CHR}.vcf.gz   \
         --processReference               \
         --prefix m3vcf_ref_chr${CHR}     \
         --cpus 8 