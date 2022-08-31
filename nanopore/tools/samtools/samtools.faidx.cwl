#!/usr/bin/env cwl-runner
# Generated from: samtools faidx nCoV-2019.reference.fasta && cut -f 1,2 nCoV-2019.reference.fasta.fai > nCoV-2019.reference.fasta.sizes
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [samtools, faidx]
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.reference_fasta)
arguments:
  - $(inputs.reference_fasta)
inputs:
  - id: reference_fasta
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
