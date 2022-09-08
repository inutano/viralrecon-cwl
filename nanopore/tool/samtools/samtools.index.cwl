#!/usr/bin/env cwl-runner
# Generated from: samtools index -@ 1 SAMPLE_01.mapped.sorted.bam
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [samtools, index]
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.input_bam)
arguments:
  - -@
  - "1"
  - $(inputs.input_bam)
inputs:
  - id: input_bam
    type: File
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.15.1--h1170115_0
