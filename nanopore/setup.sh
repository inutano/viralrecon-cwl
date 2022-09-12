#!/bin/sh
mkdir -p data
cd data
aws s3 sync "s3://nf-core-awsmegatests/viralrecon/input_data/minion_test/fastq_pass" .
aws s3 sync "s3://nf-core-awsmegatests/viralrecon/input_data/minion_test/fast5_pass" .
aws s3 cp "s3://nf-core-awsmegatests/viralrecon/input_data/minion_test/sequencing_summary.txt" .
curl -s -o samplesheet_test_nanopore.csv "https://raw.githubusercontent.com/nf-core/test-datasets/viralrecon/samplesheet/samplesheet_test_nanopore.csv"
