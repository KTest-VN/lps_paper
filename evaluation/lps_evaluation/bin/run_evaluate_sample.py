#!/usr/bin/env python
import gzip
import pandas as pd
import numpy as np
from scipy.stats import pearsonr
from scipy.spatial import distance
import argparse
#import matplotlib.pyplot as plt




def encode_gt(x, ds = None):
    try:
        if ds:
            return float(x.split(':')[1])
        else:
            return float(int(x[0]) + int(x[2]))
    except:
        ## for unexpected errors
        return 0.0

def read_vcf(path, ds = None):
    if path.endswith('.gz'):
        fi = gzip.open(path, 'rt', encoding='utf-8')
    else:
        fi = open(path, 'rt', encoding='utf-8')

    ids = []
    data = []
    for line in fi:
        if line[:2] == '##': 
            continue
        elif line[:2] == '#C':
            line = line.replace('#', '')
            headers = line.strip().split()[9:]
        else:
            tokens = line.strip().split()
            id = tokens[0].replace('chr', '') + ':' + tokens[1] + ':' + tokens[3] + ':' + tokens[4]
            tem = np.array(tokens[9:])
            ids.append(id)
            tem = np.vectorize(encode_gt)(tem, ds)
            tem = tem.astype(np.float16)
            data.append(tem)
    fi.close()
    df = pd.DataFrame(np.stack(data), columns=headers)
    df.index = ids
    return df



def get_maf(gt_vcf):
    import subprocess
    command = f"bcftools query -f '%CHROM:%POS:%REF:%ALT\t%AF\n' {gt_vcf} > {gt_vcf}.maf.txt"
    subprocess.run(command, shell=True)


def read_maf(path):
    df = pd.read_csv(path, sep='\t', header = None)
    df.columns = ['ID', 'MAF']
    df['ID'] = df['ID'].str.replace('chr', '')
    df['MAF'] = [i if i <= 0.5 else 1-i for i in df['MAF']]
    df = df.set_index('ID')
    return df



def refine_df(vcf1, vcf2, maf):
    ## exclude rows all zero in ref
    #pick = vcf1.sum(axis=1) > 0
    #vcf1 = vcf1[pick]
    unique_id = set(maf.index) & set(vcf1.index) & set(vcf1.index)
    unique_id = list(unique_id)
    unique_sample = set(vcf1.columns).intersection(vcf2.columns)
    unique_sample = list(unique_sample)
    vcf1 = vcf1.loc[unique_id, unique_sample]
    ## reordering both rows and columns for matching bw gt and imp
    vcf2 = vcf2.loc[unique_id, unique_sample]
    maf = maf.loc[unique_id]
    return vcf1, vcf2, maf
    


def compute_snp_r2(gt, imp):
    ## for faster and easier computation
    np_gt = np.array(gt, dtype = np.float16)
    np_imp = np.array(imp, dtype = np.float16)
    assert np_gt.shape == np_imp.shape, "the shape must to similar"   
    res = []
    for x, y in zip(np_gt, np_imp):
        res.append(pearsonr(x, y)[0])
    return np.array(res)**2
    
def compute_aggreated_pearson(self, min_maf, max_maf):
    pick = (self.maf['MAF'] > min_maf) & (self.maf['MAF'] <= max_maf)
    a = self.gt.loc[pick]
    b = self.imp.loc[pick]
    res = pearsonr(np.array(a).reshape(-1),np.array(b).reshape(-1))
    return res.statistic**2

def compute_NRC(self, min_maf, max_maf):
    pick = (self.maf['MAF'] > min_maf) & (self.maf['MAF'] <= max_maf)
    a = self.gt.loc[pick]
    b = self.imp.loc[pick]
    a = np.array(a).reshape(-1)
    b = np.array(b).reshape(-1)
    pick = a != 0
    a = a[pick]
    b = b[pick]
    return (np.round(a) == np.round(b)).mean()


class Imputation_Eval:
    def __init__(self, gt, imp, maf):
        gt, imp, maf = refine_df(gt, imp, maf)
        self.gt = gt
        self.imp = imp
        self.maf = maf.copy()


    def compute_snp_wise_metrics(self, out_fn = 'snp_r2.txt'):
        self.maf['r2'] = compute_snp_r2(self.gt, self.imp)
        self.maf.to_csv(out_fn, sep = '\t', na_rep='NaN')
        #return self.maf


    def compute_NRC_aggregated(self, out_fn = 'NRC_metrics.txt', maf_bins = None):
        if maf_bins is None:
            maf_bins = np.linspace(0, 0.5, 21)[:-1]
            
        pearson_r = [compute_aggreated_pearson(self, b, b + maf_bins[1]) for b in maf_bins]
        nrc = [compute_NRC(self, b, b + maf_bins[1]) for b in maf_bins]
        res = pd.DataFrame({'maf_bins' : maf_bins, 'pearson_r' : pearson_r, 'nrc' : nrc})
        res.to_csv(out_fn, sep = '\t', na_rep='NaN', index=False)





if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Evaluate imputation performances')
    # Define command line arguments
    parser.add_argument('--true_vcf', type=str, help='Path to the true VCF file')
    parser.add_argument('--imputed_vcf', type=str, help='Path to the imputed VCF file')
    parser.add_argument('--af', type=str, help='Path to the AF file')
    parser.add_argument('--out_snp_wise', type=str, help='out snp-wise imputation r2')
    parser.add_argument('--out_nrc', type=str, help='out NRC and aggregated imputation r2')

    # Parse the command line arguments
    args = parser.parse_args()
    gt = read_vcf(args.true_vcf)
    imp = read_vcf(args.imputed_vcf, ds = True)
    #get_maf(args.true_vcf)
    maf = read_maf(args.af)
    eval = Imputation_Eval(gt, imp, maf)
    eval.compute_snp_wise_metrics(args.out_snp_wise)
    eval.compute_NRC_aggregated(args.out_nrc)



# /Users/datn/github/nf_lps_evaluator/bin/run_evaluate.py \
#     --true_vcf chr22_AMR_true.vcf.gz \
#     --imputed_vcf chr22_1.5_lps_AMR_imputed.vcf.gz \
#     --af chr22.vcf.txt \
#     --out_snp_wise chr22_1.5_lps_AMR_snp_wise.acc \
#     --out_nrc chr22_1.5_lps_AMR_nrc.acc