PREFIX=$1  # e.g. AMR-Axiom_UKB_WCSG

plink     --bfile ${PREFIX}     \
          --maf 0.0001     \
          --hwe 1e-6     \
          --geno 0.01     \
          --mind 0.01     \
          --write-snplist     \
          --make-just-fam     \
          --memory 128000     \
          --out ${PREFIX}.QC
