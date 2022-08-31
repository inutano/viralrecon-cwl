#!/usr/bin/env cwl-runner
# Generated from: NanoPlot -t 2 --fastq SAMPLE_01.fastq.gz
class: CommandLineTool
cwlVersion: v1.0
baseCommand: NanoPlot
arguments:
  - -t
  - $(inputs.threads)
  - --fastq
  - $(inputs.fastq)
inputs:
  - id: threads
    type: int
    default: 2
  - id: fastq
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
    dockerPull: quay.io/biocontainers/nanoplot:1.40.0--pyhdfd78af_0
