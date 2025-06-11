compute_MAF.sh chr${i}_${pop}_true.vcf.gz maf.txt

run_evaluate.py --true_vcf chr${i}_${pop}_true.vcf.gz \
                --imputed_vcf ${imputed_vcf} \
                --af maf.txt \
                --out_snp_wise chr${i}_${lps_cov}_${pop}_snp_wise.acc