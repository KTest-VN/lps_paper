
echo 1.vcf.gz 2.vcf.gz 3.vcf.gz 4.vcf.gz 5.vcf.gz 6.vcf.gz 7.vcf.gz 8.vcf.gz 9.vcf.gz 10.vcf.gz | xargs -n 1 -P 10 bcftools index
bcftools merge -0 1.vcf.gz 2.vcf.gz 3.vcf.gz 4.vcf.gz 5.vcf.gz 6.vcf.gz 7.vcf.gz 8.vcf.gz 9.vcf.gz 10.vcf.gz | sed 's/0\/0:.:./0|0:0:1/g'  | bgzip  > Axiom_JAPONICA_chr10_merged.vcf.gz
tabix -p vcf Axiom_JAPONICA_chr10_merged.vcf.gz

## Re-header (HA000_.* -> HA000)
bcftools query -l Axiom_JAPONICA_chr10_merged.vcf.gz | grep -oE "^[^_]+" > rename_ids.txt
bcftools reheader -s rename_ids.txt -o temp_Axiom_JAPONICA_chr10_merged.vcf.gz Axiom_JAPONICA_chr10_merged.vcf.gz
mv temp_Axiom_JAPONICA_chr10_merged.vcf.gz Axiom_JAPONICA_chr10_merged.vcf.gz
rm -f Axiom_JAPONICA_chr10_merged.vcf.gz.tbi && bcftools index -t Axiom_JAPONICA_chr10_merged.vcf.gz
