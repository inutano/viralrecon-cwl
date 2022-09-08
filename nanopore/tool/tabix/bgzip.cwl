#!/usr/bin/env cwl-runner
# Generated from: bgzip -c  -@2 SAMPLE_01.snpeff.vcf  > SAMPLE_01.snpeff.vcf.gz
class: CommandLineTool
cwlVersion: v1.0
baseCommand: bgzip
arguments:
  - -c
  - -@2
  - $(inputs.input_vcf)
inputs:
  - id: input_vcf
    type: File
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: out
    type: stdout
stdout: $(inputs.input_vcf.basename).gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tabix:1.11--hdfd78af_0
