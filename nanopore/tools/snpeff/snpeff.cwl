#!/usr/bin/env cwl-runner
# Generated from: snpEff -Xmx6g nCoV-2019.reference -config snpeff.config -dataDir snpeff_db SAMPLE_01.pass.unique.vcf.gz -csvStats SAMPLE_01.snpeff.csv > SAMPLE_01.snpeff.vcf
class: CommandLineTool
cwlVersion: v1.0
baseCommand: snpEff
arguments:
  - -Xmx6g
  - $(inputs.reference_name)
  - -config
  - $(inputs.config)
  - -dataDir
  - $(inputs.dataDir)
  - $(inputs.input_vcf)
  - -csvStats
  - $(inputs.output_csv)
inputs:
  - id: reference_name
    type: string
  - id: config
    type: File
  - id: dataDir
    type: Directory
  - id: input_vcf
    type: File
  - id: output_csv
    type: string
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
    dockerPull: quay.io/biocontainers/snpeff:5.0--hdfd78af_1
