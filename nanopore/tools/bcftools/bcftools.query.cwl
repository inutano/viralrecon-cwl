#!/usr/bin/env cwl-runner
# Generated from: bcftools query --output SAMPLE_01.bcftools_query.txt -H -f '%CHROM\t%POS\t%REF\t%ALT\t%FILTER\t%StrandSupport\n' SAMPLE_01.pass.unique.vcf.gz
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [bcftools, query]
arguments:
  - --output
  - $(inputs.output_name)
  - --print-header
  - --format
  - $(inputs.format)
  - $(inputs.input_vcf)
inputs:
  - id: output_name
    type: string
  - id: format
    type: string
    default: '%CHROM\t%POS\t%REF\t%ALT\t%FILTER\t%StrandSupport\n'
  - id: input_vcf
    type: File
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
#  - id: output
#    type: File
#    outputBinding:
#      glob: "$(inputs.output_name)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools:1.15.1--h0ea216a_0
