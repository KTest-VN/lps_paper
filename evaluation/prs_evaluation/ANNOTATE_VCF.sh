set -eu

VCF_FILES=$1  # VCF_FILES="AMR-Axiom_UKB_WCSG_concat.vcf.gz"
REF_VCF=$2   # REF_VCF="00-All.vcf.gz"

file_name=$(basename $VCF_FILES .vcf.gz)

## Make sure the format chromosome names is numeric
bcftools view ${VCF_FILES} |                 sed 's/chr//g' |                 bgzip > tem.vcf.gz
bcftools index tem.vcf.gz

## Annotate the VCF with reference VCF
bcftools annotate -a ${REF_VCF} -c ID -o ${file_name}_anno.vcf.gz tem.vcf.gz
bcftools index ${file_name}_anno.vcf.gz

## Remove temporary files
rm tem.vcf.gz tem.vcf.gz.csi