
## set up tools
export PATH="$PWD/bin:$PATH"


gen_ref_batch_chr(){
    chr=$1
    in_dir=$2
    out_dir=$3
    sample_list=$4
    map_dir=$5
    
    mkdir -p $out_dir

    echo filtering reference of ${chr}
	bcftools="singularity run -B /home/ktest:/home/ktest /home/ktest/pipeline_env/software/container/us-central1-docker.pkg.dev-ktest-kite-ktest-bcftools-b812975.img bcftools"
	
    $bcftools view \
        -S ^$sample_list ${in_dir}/chr${i}.vcf.gz  \
        -Oz -o ${out_dir}/chr${i}.vcf.gz
    
    $bcftools index -f ${out_dir}/chr${i}.vcf.gz

    bin/buid_ref.sh ${out_dir}/chr${i}.vcf.gz ${chr} ${map_dir}/${chr}.b38.gmap.gz ${out_dir}
}


BATCH=9

## 
in_dir=/home/ktest/project/truongphi/PRS/PRS-21/PRS-173/lps_imputation/aDat_ac_filtered
save_folder="/home/ktest/share/PRS/PRS-173"

out_dir=$PWD/batch_${BATCH}_ref
sample_list=$PWD/data/sample_list/batch_${BATCH}.txt
map_dir=$PWD/maps
##

for i in {1..22}
do
    gen_ref_batch_chr chr${i} $in_dir $out_dir $sample_list $map_dir &
done

wait