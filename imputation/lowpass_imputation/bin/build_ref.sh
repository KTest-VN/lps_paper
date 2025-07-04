#!/bin/bash

# Help message function
function display_help {
    echo "Usage: $0 VCF CHR MAP OUT_DIR [CORES] [REF_PREFIX]"
    echo "  VCF: Input VCF file"
    echo "  CHR: Chromosome or region (e.g., chr1, chr2)"
    echo "  MAP: genetic map file, for example: chr1.b38.gmap.gz"
    echo "  OUT_DIR: Output directory"
    echo "  CORES (optional): Number of CPU cores to use"
    echo "  REF_PREFIX (optional): Prefix for reference files"
    echo "Example: $0 input.vcf chr1.b38.gmap.gz output_dir 4 binary_ref"
}

# Check for the correct number of arguments
if [ "$#" -lt 4 ]; then
    echo "Error: Insufficient arguments!"
    display_help
    exit 1
fi

# Assign input arguments to variables
VCF="$1"
CHR="$2"
MAP="$3"
OUT_DIR="$4"
CORES="${5:-1}"  # Default to 1 if CORES is not provided
REF_PREFIX="${6:-binary_ref}"  # Default to 'binary_ref' if REF_PREFIX is not provided

mkdir -p ${OUT_DIR}

## extract sites
bcftools view -G -Oz -o ${OUT_DIR}/${CHR}.sites.vcf.gz ${VCF}
bcftools index -f ${OUT_DIR}/${CHR}.sites.vcf.gz

## slipt chunks
GLIMPSE2_chunk --input ${OUT_DIR}/${CHR}.sites.vcf.gz \
    --region ${CHR} \
    --window-cm 8 \
    --window-mb 10 \
    --window-count 40000 \
    --buffer-cm 0.5 \
    --buffer-mb 0.400000006 \
    --buffer-count 2000 \
    --output ${OUT_DIR}/chunks.${CHR}.txt \
    --map ${MAP} \
    --sequential


## build binary ref
while IFS="" read -r LINE || [ -n "$LINE" ];
do
    printf -v ID "%02d" $(echo $LINE | cut -d" " -f1)
    IRG=$(echo $LINE | cut -d" " -f3)
    ORG=$(echo $LINE | cut -d" " -f4)

    GLIMPSE2_split_reference --threads $CORES \
        --reference ${VCF} \
        --map ${MAP} \
        --input-region ${IRG} \
        --output-region ${ORG} \
        --output ${OUT_DIR}/${REF_PREFIX} \
        --keep-monomorphic-ref-sites


done < ${OUT_DIR}/chunks.${CHR}.txt
