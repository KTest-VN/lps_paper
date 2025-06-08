set -ue

## Input
CRAM_URL=$1
SAMPLE_ID=$2
MD5SUM=$3

## Try 5 times to download cram file
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

## Convert CRAM to BAM
samtools view -b -T hg38.fa -@ 1 -o ${SAMPLE_ID}.bam ${SAMPLE_ID}.cram

## Release space
rm -f ${SAMPLE_ID}.cram

## Downsampling
bam_sampling.py --bam ${SAMPLE_ID}.bam         \
                --depth 0.5 0.75 1.0 1.25 1.5 2.0         \
                --out ${SAMPLE_ID}_0.5_lps.bam ${SAMPLE_ID}_0.75_lps.bam ${SAMPLE_ID}_1.0_lps.bam ${SAMPLE_ID}_1.25_lps.bam ${SAMPLE_ID}_1.5_lps.bam ${SAMPLE_ID}_2.0_lps.bam   \
                --bam_size 853210772

## Release space
rm ${SAMPLE_ID}.bam

## Index bam file
samtools index ${SAMPLE_ID}_0.5_lps.bam ${SAMPLE_ID}_0.75_lps.bam ${SAMPLE_ID}_1.0_lps.bam ${SAMPLE_ID}_1.25_lps.bam ${SAMPLE_ID}_1.5_lps.bam ${SAMPLE_ID}_2.0_lps.bam

