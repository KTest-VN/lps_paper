#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
  stop("Usage: script.R <in_file> <out_file>")
}

in_file = args[1]
out_file = args[2]


options(stringsAsFactors = FALSE)
require(data.table)
snp = fread(in_file, header = F)
pick = snp$V1 == "."
snp = snp[!pick,]
pick = duplicated(snp$V1)
snp_filter = snp[!pick,]
fwrite(snp_filter, file = out_file, sep = "	")
cat("DONE merging files")