#!/usr/bin/env cwl-runner
# Generated from: pigz -p 2 *.fastq
class: CommandLineTool
cwlVersion: v1.0
baseCommand: pigz
arguments:
  - -p
  - $(inputs.processes)
  - $(inputs.fastq)
inputs:
  - id: processes
    type: int
    default: 2
  - id: fastq
    type: File[]
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.2.2--pyhdfd78af_0
