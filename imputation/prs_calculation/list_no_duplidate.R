#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
options(stringsAsFactors = FALSE)
require(data.table)
in_file = "AMR-1.25.QC.snplist"
out_file = "AMR-1.25.nodup"
snp = fread(in_file, header = F)
pick = snp$V1 == "."
snp = snp[!pick,]
pick = duplicated(snp$V1)
snp_filter = snp[!pick,]
fwrite(snp_filter, file = out_file, sep = "	")
cat("DONE merging files")