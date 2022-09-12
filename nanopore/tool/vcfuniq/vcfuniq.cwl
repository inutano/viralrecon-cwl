#!/usr/bin/env cwl-runner
# Generated from: vcfuniq SAMPLE_01.pass.vcf.gz | bgzip -c -f > SAMPLE_01.pass.unique.vcf.gz
class: CommandLineTool
cwlVersion: v1.0
requirements:
  ShellCommandRequirement: {}
arguments:
  - valueFrom: "vcfuniq $(inputs.input_vcf.path) | bgzip -c -f"
    shellQuote: False
inputs:
  - id: input_vcf
    type: File
    secondaryFiles:
      - .tbi
  - id: sample_name
    type: string
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: uniq_vcf
    type: stdout
stdout: $(inputs.sample_name).unique.vcf.gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflib:1.0.3--hecb563c_1
