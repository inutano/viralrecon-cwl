#!/usr/bin/env cwl-runner
# Generated from: bcftools stats  SAMPLE_01.pass.unique.vcf.gz > SAMPLE_01.bcftools_stats.txt
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [bcftools, stats]
arguments:
  - $(inputs.input_vcf)
inputs:
  - id: input_vcf
    type: File
    secondaryFiles:
      - .tbi
  - id: output_name
    type: string
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
    dockerPull: quay.io/biocontainers/bcftools:1.15.1--h0ea216a_0
