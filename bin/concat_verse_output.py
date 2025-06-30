#!/usr/bin/env python

import pandas as pd
import argparse
import os

def concat_verse_out(verse_files, output_file):
    merged_df = None
    for f in verse_files:
        sample_name = os.path.basename(f).replace('.exon.txt', '')
        df = pd.read_csv(f, sep='\t')
        
        df.columns = ['gene', sample_name]
        print(sample_name, '\n', df.columns)
        
        # Merge dataframes on 'gene'
        if merged_df is None:
            merged_df = df
        else:
            merged_df = pd.merge(merged_df, df, on='gene', how='outer')

    print(merged_df)
    merged_df.to_csv(output_file, sep='\t', index=False)


def main():
    parser = argparse.ArgumentParser(description="Concatenate VERSE output files into a single counts matrix.")
    parser.add_argument('-i', '--input', nargs='+', required=True, help="Input VERSE exon count files.")
    parser.add_argument('-o', '--output', required=True, help="Output file for combined counts matrix.")
    
    args = parser.parse_args()
    
    concat_verse_out(args.input, args.output)


if __name__ == "__main__":
    main()

