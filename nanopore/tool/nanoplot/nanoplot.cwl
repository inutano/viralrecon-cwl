#!/usr/bin/env cwl-runner
# Generated from: NanoPlot -t 2 --fastq SAMPLE_01.fastq.gz
class: CommandLineTool
cwlVersion: v1.0
baseCommand: NanoPlot
arguments:
  - -t
  - $(inputs.threads)
  - --fastq
  - $(inputs.input_fastq)
inputs:
  - id: threads
    type: int
    default: 2
  - id: input_fastq
    type: File
outputs:
  - id: all_outputs
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanoplot:1.40.0--pyhdfd78af_0
