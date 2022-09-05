#!/usr/bin/env cwl-runner
# Generated from: mosdepth --threads 2 --by nCoV-2019.primer.collapsed.bed --fast-mode --use-median --thresholds 0,1,10,50,100,500 SAMPLE_01 SAMPLE_01.primertrimmed.rg.sorted.bam
class: CommandLineTool
cwlVersion: v1.0
baseCommand: mosdepth
arguments:
  - --threads
  - $(inputs.threads)
  - --by
  - $(inputs.by)
  - --fast-mode
  - --use-median
  - --thresholds
  - $(inputs.thresholds)
  - $(inputs.input_label)
  - $(inputs.input_bam)
inputs:
  - id: threads
    type: int
    default: 2
  - id: by
    type: File
  - id: thresholds
    type: string
    default: "0,1,10,50,100,500"
  - id: input_label
    type: string
  - id: input_bam
    type: File
    secondaryFiles:
      - .bai
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosdepth:0.3.3--hdfd78af_1
