
# Get correct name
bcftools query -l Axiom_JAPONICA_AMR_chr21_split.vcf.gz > sample_name.txt
sed -E 's/^(([^_]+)_.*)/\1\t\2/g' sample_name.txt > new_name.txt

# Check whether origin has correct name
col_num=`awk -F'\t' '{print NF}' new_name.txt | head -n 1`
checker=`if (( $col_num==1 )); then echo 1; else echo 0; fi`

if (( $checker )); then
    echo "Create symlink"
    ln -s Axiom_JAPONICA_AMR_chr21_split.vcf.gz AMR-Axiom_JAPONICA_chr21_correct_name.vcf.gz
else
    # Replace old name by new one
    echo "Preplace by new name"
    bcftools reheader -s new_name.txt -o AMR-Axiom_JAPONICA_chr21_correct_name.vcf.gz Axiom_JAPONICA_AMR_chr21_split.vcf.gz
fi

bcftools index AMR-Axiom_JAPONICA_chr21_correct_name.vcf.gz
