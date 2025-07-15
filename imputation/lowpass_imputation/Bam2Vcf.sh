set -ue

## INPUT
CHR=$1              # e.g. 1, 2, ..., 22
COV=$2              # coverage prefix of the downsampled bam files
OUT=$3              # e.g. chr1_10x_lps_imputed.vcf.gz
CORES="${4:-1}"     # number of cores to use, default is 1
REF_FOLDER=${5}     # e.g. /path/to/reference_panel_folder

ls *${COV}_lps.bam > run_bam_list.txt

run_imputation_bam_list.sh     run_bam_list.txt         \
                               chr${CHR}                \
                               ${OUT}                   \
                               ${CORES}                 \
                               ${REF_FOLDER}            \
