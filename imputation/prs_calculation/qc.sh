set -ue

plink     --bfile AMR-0.75     --maf 0.0001     --hwe 1e-6     --geno 0.01     --mind 0.01     --write-snplist     --make-just-fam     --memory 128000     --out AMR-0.75.QC