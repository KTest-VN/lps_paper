set -ue

## Input
CRAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/1000genomes/ftp/1000G_2504_high_coverage/data/ERR3239424/NA19099.final.cram
SAMPLE_ID=NA19099
MD5SUM=531e4fdb967d528d5cb86366dc88c0df

## try 5 times

for ((i=1; i<=5; i++)); do
    wget $CRAM_URL -O ${SAMPLE_ID}.cram

    actual_md5="$(md5sum ${SAMPLE_ID}.cram | awk '{print $1}')"

    if [ "$actual_md5" == "$MD5SUM" ]; then
        echo "MD5 sum matches! File downloaded successfully."
        break
    else
        echo "MD5 sum does not match. Retrying..."
        rm -f ${SAMPLE_ID}.cram
        wget $CRAM_URL -O ${SAMPLE_ID}.cram
    fi
done

samtools view -b -T hg38.fa -@ 1 -o ${SAMPLE_ID}.bam ${SAMPLE_ID}.cram

## release space
rm -f ${SAMPLE_ID}.cram

bam_sampling.py --bam ${SAMPLE_ID}.bam         \
                --depth 0.5 0.75 1.0 1.25 1.5 2.0         \
                --out ${SAMPLE_ID}_0.5_lps.bam ${SAMPLE_ID}_0.75_lps.bam ${SAMPLE_ID}_1.0_lps.bam ${SAMPLE_ID}_1.25_lps.bam ${SAMPLE_ID}_1.5_lps.bam ${SAMPLE_ID}_2.0_lps.bam   \
                --bam_size 853210772

## release space
rm ${SAMPLE_ID}.bam


samtools index ${SAMPLE_ID}_0.5_lps.bam

