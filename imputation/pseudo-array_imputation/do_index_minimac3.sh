set -ue

CHR=1

Minimac3 --refHaps ref_chr${CHR}.vcf.gz     \
         --processReference         \
         --prefix m3vcf_ref_chr${CHR}         \
         --cpus 8