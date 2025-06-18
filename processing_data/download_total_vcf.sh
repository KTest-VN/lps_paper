set -ue

chr_num=$1
out_dir=$2
md5sum_meta=$3
max_trial=10


URL_SRC="https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased"

# check file exis
if ! [ -f ${out_dir}/chr${chr_num}_raw.vcf.gz ]; then
    echo "download chr${chr_num}_raw.vcf.gz"
    wget ${URL_SRC}/CCDG_14151_B01_GRM_WGS_2020-08-05_chr${chr_num}.filtered.shapeit2-duohmm-phased.vcf.gz -O ${out_dir}/chr${chr_num}_raw.vcf.gz
else
    echo "chr${chr_num}_raw.vcf.gz existed in ${out_dir}"
fi

# check md5sum
md5sum_ex=`md5sum ${out_dir}/chr${chr_num}_raw.vcf.gz | awk -F" " '{print $1}'`
md5sum_vcf=`awk -v chr="$chr_num" '$1 ~ ("chr" chr ".*\\.vcf\\.gz$") { print $3 }' $md5sum_meta`

trial=1
while true
do
    echo "md5sum_ex: $md5sum_ex, md5sum: $md5sum_vcf,"
    if [ $md5sum_ex == $md5sum_vcf ]; then
        echo "match md5sum ${out_dir}/chr${chr_num}_raw.vcf.gz in ${trial} trial"
        break
    else
        echo "mismatch md5sum ${out_dir}/chr${chr_num}_raw.vcf.gz in ${trial} trial"
    fi
    echo "download ref for chr${chr_num}"
    wget ${URL_SRC}/CCDG_14151_B01_GRM_WGS_2020-08-05_chr${chr_num}.filtered.shapeit2-duohmm-phased.vcf.gz -O ${out_dir}/chr${chr_num}_raw.vcf.gz
    md5sum_vcf=`md5sum ${out_dir}/chr${chr_num}_raw.vcf.gz | awk -F" " '{print $1}'`
    trial=$((trial+1))
    echo "download chr${chr_num} with $trial trials"
    if [[ $trial == $max_trial ]]; then
        echo "Max trials with chr${chr_num}"
        break
    fi

done

# Indexing
bcftools index ${out_dir}/chr${chr_num}_raw.vcf.gz