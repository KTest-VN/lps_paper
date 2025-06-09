
bcftools view Axiom_JAPONICA_chr21_merged.vcf.gz             -S AMR_pop.txt |            sed 's/chr//g' |            bgzip > Axiom_JAPONICA_AMR_chr21_split.vcf.gz

bcftools index -t Axiom_JAPONICA_AMR_chr21_split.vcf.gz