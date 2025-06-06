set -ue

plink --vcf AMR-1.5_anno.vcf.gz       --make-bed  --const-fid --out AMR-1.5       --threads 2       --memory 128000