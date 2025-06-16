set -ue

PREFIX=$1  # e.g. AMR-Axiom_UKB_WCSG

## List duplicated records
Rscript LIST_NO_DUPLICATE.R ${PREFIX}.QC.snplist ${PREFIX}.nodup

## Deduplicate
plink         --bfile ${PREFIX}         \
              --threads 2         \
              --make-bed         \
              --keep ${PREFIX}.QC.fam         \
              --out ${PREFIX}.dedup         \
              --extract ${PREFIX}.nodup         \
              --memory 128000
