#!/usr/bin/env python

import argparse
import pandas as pd

def parse_gtf(gtf_file, output_file):
    """
    Reads a GTF file, extracts gene IDs and names, and saves them to a CSV file.
    """
    gene_info = []
    
    with open(gtf_file, "r") as file:
        for line in file:
            # Skip comment lines
            if line.startswith("#"):
                continue
            
            fields = line.strip().split("\t")
            
            if fields[2] != "gene":
                continue
            
            # Parse attributes field into a dictionary
            attributes = {}
            for attr in fields[8].split("; "):
                if attr:
                    key, value = attr.split(" ")
                    attributes[key] = value.replace('"', '')
            
            # Extract relevant gene information
            gene_id = attributes.get("gene_id", "NA")
            gene_name = attributes.get("gene_name", "NA")
            
            gene_info.append([gene_id, gene_name])
    
    # Create a DataFrame and save it to a CSV file
    df = pd.DataFrame(gene_info, columns=["gene", "symbol"]).drop_duplicates()
    df.to_csv(output_file, sep=',', index=False)

def main():
    """
    Parses command-line arguments and runs the GTF parsing function.
    """
    parser = argparse.ArgumentParser(description="Extract gene IDs and names from a GTF file.")
    parser.add_argument("gtf_file", type=str, help="Path to the input GTF file")
    parser.add_argument("output_file", type=str, help="Path to the output CSV file")
    args = parser.parse_args()
    
    parse_gtf(args.gtf_file, args.output_file)

if __name__ == "__main__":
    main()
