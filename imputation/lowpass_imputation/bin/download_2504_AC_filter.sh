download_vcf(){
    i=$1
    dir=$2
    md5sumFile=$3
    md5sum_ex=`awk -F'\t' -v filename="chr${i}_raw.vcf.gz" '$2==filename{print$1}' $md5sumFile`
    max_trial=10
    
    # check file exis
    if ! [ -f ${dir}/chr${i}_raw.vcf.gz ]; then
    	echo "download chr${i}_raw.vcf.gz"
    	wget https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased/CCDG_14151_B01_GRM_WGS_2020-08-05_chr${i}.filtered.shapeit2-duohmm-phased.vcf.gz -O ${dir}/chr${i}_raw.vcf.gz
    else
    	echo "chr${i}_raw.vcf.gz exist"
    fi
    
    # check md5sum
    md5sum=`md5sum ${dir}/chr${i}_raw.vcf.gz | awk -F" " '{print $1}'`
    
    trial=1
    while true
    do
    	echo "md5sum_ex: $md5sum_ex, md5sum: $md5sum,"
    	if [ $md5sum_ex == $md5sum ]; then
    		echo "match md5sum ${dir}/chr${i}_raw.vcf.gz in ${trial} trial"
    		break
    	else
            echo "mismatch md5sum ${dir}/chr${i}_raw.vcf.gz in ${trial} trial"
        fi
        echo "download ref for chr${i}"
    	wget https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased/CCDG_14151_B01_GRM_WGS_2020-08-05_chr${i}.filtered.shapeit2-duohmm-phased.vcf.gz -O ${dir}/chr${i}_raw.vcf.gz
    	md5sum=`md5sum ${dir}/chr${i}_raw.vcf.gz | awk -F" " '{print $1}'`
    	trial=$((trial+1))
    	echo "download chr${i} with $trial trials"
    	if [[ $trial == $max_trial ]]; then
    		echo "Max trials with chr${i}"
    		break
    	fi
    	
    	
	done    
	

}

filter_ac(){
	bcftools="singularity run -B /home/ktest:/home/ktest /home/ktest/pipeline_env/software/truongphi/ndatth-ubuntu-22.04.img bcftools"
	
    vcf_in=$1
    sample_list=$2
    vcf_out=$3
    echo running ${vcf_in} ..
    $bcftools view \
        -S $sample_list $vcf_in  \
        -m2 -M2 \
        -v snps |
    $bcftools view \
        --exclude 'AC<=2' \
        -Oz -o $vcf_out
    
    echo indexing ${vcf_out}
    $bcftools index -f $vcf_out
}


for i in {1..22}
do
    filter_ac raw_data/chr${i}_raw.vcf.gz misc/2504_samples.txt ac_filtered/chr${i}.vcf.gz &
done 
wait