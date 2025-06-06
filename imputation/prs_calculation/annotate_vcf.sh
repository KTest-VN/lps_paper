set -ue

bcftools view AMR-1.25_concat.vcf.gz |                 sed 's/chr//g' |                 bgzip > tem.vcf.gz
bcftools index tem.vcf.gz

bcftools annotate -a 00-All.vcf.gz -c ID -o AMR-1.25_anno.vcf.gz tem.vcf.gz
bcftools index AMR-1.25_anno.vcf.gz

rm tem.vcf.gz tem.vcf.gz.csi