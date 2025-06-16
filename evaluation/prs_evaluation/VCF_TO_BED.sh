set -eu

VCF_FILES=$1  # VCF_FILES="AMR-Axiom_UKB_WCSG_anno.vcf.gz"

prefix=$(basename $VCF_FILES _anno.vcf.gz)

plink   --vcf ${VCF_FILES} \
        --make-bed  \
        --const-fid \
        --out ${prefix}       \
        --threads 2       \
        --memory 128000