#!/usr/bin/env cwl-runner
# Generated from: tabix -p vcf -f SAMPLE_01.pass.unique.vcf.gz
class: CommandLineTool
cwlVersion: v1.0
baseCommand: tabix
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.input_file)
arguments:
  - --preset
  - $(inputs.preset)
  - --force
  - $(inputs.input_file)
inputs:
  - id: preset
    type:
      type: enum
      symbols:
        - gff
        - bed
        - sam
        - vcf
    default: vcf
  - id: input_file
    type: File
outputs:
  - id: index
    type: File
    outputBinding:
      glob: "$(inputs.input_file.basename).tbi"
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tabix:1.11--hdfd78af_0
