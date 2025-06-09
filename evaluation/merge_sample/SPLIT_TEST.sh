
## extract uncorelated samples
bcftools view CCDG_14151_B01_GRM_WGS_2020-08-05_chr1.filtered.shapeit2-duohmm-phased.vcf.gz                 -S AMR_pop.txt |                sed 's/chr//g' |                bcftools annotate --remove INFO |                bcftools +fill-tags |                bgzip > AMR_chr1_temp.vcf.gz

## annotate dbSNP ID
bcftools index -t AMR_chr1_temp.vcf.gz
bcftools annotate --annotations 00-All.vcf.gz                       --columns ID AMR_chr1_temp.vcf.gz | bgzip                       > AMR_chr1_extract.vcf.gz

## clean tem vcf
rm -f AMR_chr1_temp.vcf.gz
rm -f AMR_chr1_temp.vcf.gz.tbi

## Index vcf file
bcftools index -t AMR_chr1_extract.vcf.gz
