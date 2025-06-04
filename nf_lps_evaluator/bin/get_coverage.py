#!/usr/bin/env python

import pandas as pd
import argparse

def compute_metrics(input_file, acc_file, cov_file):
    # Read data
    df = pd.read_csv(input_file, delim_whitespace=True)
    
    # Define MAF bins
    bins = [(0, 0.01), (0.01, 0.05), (0.05, 0.5), (0.01, 0.5)]
    bin_labels = ["(0–0.01]", "(0.01–0.05]", "(0.05–0.5]", "(0.01–0.5]"]
    
    results_acc = []
    results_cov = []
    
    for (low, high), label in zip(bins, bin_labels):
        subset = df[(df['MAF'] > low) & (df['MAF'] <= high)]
        valid_r2 = subset['r2'].dropna()
        
        # Compute mean r2
        mean_r2 = valid_r2.mean() if not valid_r2.empty else 'NaN'
        
        # Compute coverage (normalize by total rows of subset, including NaNs)
        coverage = (subset['r2'] >= 0.8).sum() / len(subset) if len(subset) > 0 else 'NaN'
        
        results_acc.append([label, mean_r2])
        results_cov.append([label, coverage])
    
    # Save results
    with open(acc_file, 'w') as f: f.write('\t'.join(map(str, [x[1] for x in results_acc])) + '\n')
    with open(cov_file, 'w') as f: f.write('\t'.join(map(str, [x[1] for x in results_cov])) + '\n')


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True, help="Input file path")
    parser.add_argument("--acc", required=True, help="Output file for mean r2")
    parser.add_argument("--cov", required=True, help="Output file for coverage")
    args = parser.parse_args()
    
    compute_metrics(args.input, args.acc, args.cov)
