#!/bin/bash

ARRAY=$1
OUTDIR=$2

mkdir -p $OUTDIR

# Loop through each text file in the subdirectories of input_array
for file in array_hg38/${ARRAY}/*.txt; do
  fn=$(basename $file)
  # Use awk to prepend 'chr' to each line and save the changes in place
  #awk '{print "chr" $0}' "$file" > temp && mv temp ${OUTDIR}/${ARRAY}:${fn}
  cat $file > ${OUTDIR}/${ARRAY}:${fn}
done


## bash add_chr.sh infinium-omni2.5.v1.5 input_array

## bash add_chr.sh infinium-omni5-v1.2 input_array

## bash add_chr.sh global-screening-array-v.3 input_array

## bash add_chr.sh cytosnp-850k-v1.2 input_array

## bash add_chr.sh Axiom_JAPONICA input_array

## bash add_chr.sh Axiom_PMRA input_array

## bash add_chr.sh Axiom_PMDA input_array

## bash add_chr.sh Axiom_UKB_WCSG input_array
