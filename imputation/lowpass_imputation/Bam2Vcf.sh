set -ue

## INPUT
CHR=1
COV=0.5

ls *${COV}_lps.bam > run_bam_list.txt

run_imputation_bam_list.sh     run_bam_list.txt         \
                               chr${CHR}         \
                               chr${CHR}_${COV}_lps_imputed.vcf.gz   \
                                6