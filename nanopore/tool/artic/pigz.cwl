#!/usr/bin/env cwl-runner
# Generated from: pigz -p 2 *.fastq
class: CommandLineTool
cwlVersion: v1.0
baseCommand: pigz
requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.input_fastq)
arguments:
  - -p
  - $(inputs.processes)
  - $(inputs.input_fastq)
inputs:
  - id: processes
    type: int
    default: 2
  - id: input_fastq
    type: File
outputs:
  - id: fastq_gz
    type: File
    outputBinding:
      glob: $(inputs.input_fastq.basename).gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.2.2--pyhdfd78af_0
