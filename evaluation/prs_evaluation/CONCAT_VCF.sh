set -ue

PREFIX=$1     #PREFIX="AMR-Axiom_JAPONICA"
VCF_FOLDER=$2    #VCF_FOLDER="/path/to/vcf_files"

# List VCF_FILES
VCF_FILES=$(ls ${VCF_FOLDER}/${PREFIX}_chr*.vcf.gz)

bcftools concat -Oz -o ${PREFIX}_concat.vcf.gz ${VCF_FILES}
bcftools index ${PREFIX}_concat.vcf.gz