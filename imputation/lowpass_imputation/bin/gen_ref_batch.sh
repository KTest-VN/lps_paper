set -ue

## INPUT
BATCH=$1                # e.g. 1, 2, ..., 10
REF_FOLDER=$2           # e.g. /path/to/reference_panel_folder
OUT_DIR=$3              # e.g. /path/to/output_directory
SAMPLE_LIST=$4          # e.g. /path/to/sample_list.txt
MAP_DIR=$5              # e.g. /path/to/map_directory


gen_ref_batch_chr(){
    chr=$1
    in_dir=$2
    out_dir=$3
    sample_list=$4
    map_dir=$5
    
    mkdir -p $out_dir

    echo filtering reference of ${chr}
	
    bcftools view \
        -S ^$sample_list ${in_dir}/chr${i}.vcf.gz  \
        -Oz -o ${out_dir}/chr${i}.vcf.gz
    
    bcftools index -f ${out_dir}/chr${i}.vcf.gz

    bash buid_ref.sh ${out_dir}/chr${i}.vcf.gz ${chr} ${map_dir}/${chr}.b38.gmap.gz ${out_dir}
}

for i in {1..22}
do
    gen_ref_batch_chr chr${i} $REF_FOLDER $OUT_DIR $SAMPLE_LIST $MAP_DIR &
done

wait