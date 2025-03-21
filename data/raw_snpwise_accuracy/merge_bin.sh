#!/bin/bash
input_dir=$1
suffix=$2
output=$3
> "$output"  # Clear the output file

for file in "${input_dir}"/*"${suffix}"; do
  filename=$(basename "$file")
  while read -r line; do
    echo -e "${filename}\t${line}" >> "$output"
  done < "$file"
done