TARGET_FILE=$1      # e.g. AMR-Axiom_UKB_WCSG.dedup
BASE_FILE=$2        # e.g. GIANT_BMI.QCed.gz
OUT_PREFIX=$3       # e.g. AMR-Axiom_UKB_WCSG_bmi
LD_TRUE=$4          # e.g. AMR-null.dedup

PRSice     --prsice /src/PRSice-2_v2.3.3/PRSice_linux     \
           --base ${BASE_FILE}     \
           --target ${TARGET_FILE}     \
           --ld ${LD_TRUE}     \
           --out ${OUT_PREFIX}     \
           --binary-target F     \
           --bar-levels 0.00000005,0.0000001,0.000001,0.00001,0.0001,0.001,0.01,0.1,0.2,0.3,0.5,1 \
           --fastscore     \
           --a1 A1     \
           --a2 A2     \
           --beta      \
           --bp BP     \
           --chr CHR     \
           --pvalue P     \
           --snp SNP     \
           --stat BETA     \
           --clump-kb 250kb     \
           --clump-p 1     \
           --clump-r2 0.1     \
           --ultra     \
           --no-regress     \
           --score sum     \
           --thread 1
