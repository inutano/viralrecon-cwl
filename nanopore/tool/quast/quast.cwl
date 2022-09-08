#!/usr/bin/env cwl-runner
# Generated from: quast.py --output-dir quast -r nCoV-2019.reference.fasta --features GCA_009858895.3_ASM985889v3_genomic.200409.gff --threads 2 SAMPLE_08.consensus.fasta SAMPLE_01.consensus.fasta SAMPLE_03.consensus.fasta SAMPLE_02.consensus.fasta SAMPLE_05.consensus.fasta SAMPLE_04.consensus.fasta SAMPLE_06.consensus.fasta SAMPLE_07.consensus.fasta SAMPLE_09.consensus.fasta && ln -s quast/report.tsv
class: CommandLineTool
cwlVersion: v1.0
baseCommand: quast.py
arguments:
  - --output-dir
  - $(inputs.output_dir_name)
  - -r
  - $(inputs.reference_genome_fasta)
  - --features
  - $(inputs.reference_feature_gff)
  - --threads
  - $(inputs.threads)
  - $(inputs.input_files)
inputs:
  - id: output_dir_name
    type: string
    default: quast
  - id: reference_genome_fasta
    type: File
  - id: reference_feature_gff
    type: File
  - id: threads
    type: int
    default: 2
  - id: input_files
    type: File[]
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
#  - id: output_dir
#    type: File
#    outputBinding:
#      glob: "$(inputs.output_dir_name)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quast:5.2.0--py39pl5321h2add14b_1
