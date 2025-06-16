set -ue

VCF_FILES=$1

# Get correct name
bcftools query -l $VCF_FILES > sample_name.txt
sed -E 's/^(([^_]+)_.*)/\1\t\2/g' sample_name.txt > new_name.txt

# Check whether origin has correct name
col_num=`awk -F'\t' '{print NF}' new_name.txt | head -n 1`
checker=`if (( $col_num==1 )); then echo 1; else echo 0; fi`

file_name=$(basename $VCF_FILES .vcf.gz)

if (( $checker )); then
    echo "Create symlink"
    ln -s $VCF_FILES ${file_name}.vcf.gz
else
    # Replace old name by new one
    echo "Replace by new name"
    bcftools reheader -s new_name.txt -o ${file_name}_correct_name.vcf.gz $VCF_FILES
fi

bcftools index ${file_name}_correct_name.vcf.gz
