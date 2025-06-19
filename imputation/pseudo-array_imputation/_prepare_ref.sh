set -ue


CHR=$1                             # Chromosome number (e.g., 1, 2, ..., 22)
ARRAY_NAME=$2                      # Name of the pseudo-array (e.g., array1, array2, ...)    
BATCH_SAMPLE_LIST=$3               # /path/to/batch_sample_list_file
PSEUDO_ARRAY_VCF=$4                # /path/to/pseudo_array_vcf_file
REFERENCE_VCF_FILE=$5              # /path/to/reference_vcf_file.vcf.gz
PHASING_REFERENCE=$6               # /path/to/phasing_reference_file.vcf.gz

## Extract reference
bcftools view        -S ^${BATCH_SAMPLE_LIST} ${REFERENCE_VCF_FILE} |\
bcftools annotate    --rename-chrs rename_chr.txt \
                     -Oz -o ref_chr${CHR}.vcf.gz

bcftools index -f ref_chr${CHR}.vcf.gz

## Phasing
shapeit5_phase_common_static --input ${PSEUDO_ARRAY_VCF}   \
                             --reference ref_chr${CHR}.vcf.gz         \
                             --region 4 --map ${PHASING_REFERENCE}   \
                             --thread 8                               \
                             --output phased_${ARRAY_NAME}_chr${CHR}.bcf

## Indexing by Minimac3
Minimac3 --refHaps ref_chr${CHR}.vcf.gz   \
         --processReference               \
         --prefix m3vcf_ref_chr${CHR}     \
         --cpus 8 