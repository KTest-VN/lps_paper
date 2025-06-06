set -ue


# Get correct name
bcftools query -l 1.25_EAS_chr12_split.vcf.gz > sample_name.txt
sed -E 's/^(([^_]+)_.*)/\1\t\2/g' sample_name.txt > new_name.txt

# Check whether origin has correct name
col_num=`awk -F'\t' '{print NF}' new_name.txt | head -n 1`
checker=`if (( $col_num==1 )); then echo 1; else echo 0; fi`

if (( $checker )); then
    echo "Create symlink"
    ln -s 1.25_EAS_chr12_split.vcf.gz EAS-1.25_chr12_correct_name.vcf.gz
else
    # Replace old name by new one
    echo "Preplace by new name"
    bcftools reheader -s new_name.txt -o EAS-1.25_chr12_correct_name.vcf.gz 1.25_EAS_chr12_split.vcf.gz
fi

bcftools index EAS-1.25_chr12_correct_name.vcf.gz
