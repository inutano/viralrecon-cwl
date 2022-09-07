#!/usr/bin/env cwl-runner
# Generated from: "zcat SAMPLE_01.pass.unique.vcf.gz | grep -v '#' | awk -v FS=OFS='\t' '{print $1, ($2-1), ($2)}' > variants.bed && bedtools slop -i variants.bed -g nCoV-2019.reference.fasta.sizes -b 50 > variants.slop.bed"
class: CommandLineTool
cwlVersion: v1.0
requirements:
  ShellCommandRequirement: {}
arguments:
  - valueFrom: |-
      zcat $(inputs.input_vcf.path) |\
      grep -v '#' |\
      awk -v FS=OFS='\t' '{print $1, ($2-1), ($2)}' > variants.bed && \
      bedtools slop -i variants.bed -g $(inputs.reference_fasta_sizes.path) -b 50
    shellQuote: false
inputs:
  - id: input_vcf
    type: File
  - id: reference_fasta_sizes
    type: File
  - id: output_name
    type: string
    default: variants.slop.bed
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: out
    type: stdout
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mulled-v2-093691b47d719890dc19ac0c13c4528e9776897f:27211b8c38006480d69eb1be3ef09a7bf0a49d76-0
