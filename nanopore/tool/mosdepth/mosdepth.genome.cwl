#!/usr/bin/env cwl-runner
# Generated from: mosdepth --threads 2 --fast-mode --by 200 SAMPLE_01 SAMPLE_01.primertrimmed.rg.sorted.bam
class: CommandLineTool
cwlVersion: v1.0
baseCommand: mosdepth
arguments:
  - --threads
  - $(inputs.threads)
  - --fast-mode
  - --by
  - $(inputs.by)
  - $(inputs.sample_name)
  - $(inputs.input_bam)
inputs:
  - id: threads
    type: int
    default: 2
  - id: by
    type: int
    default: 200
  - id: sample_name
    type: string
  - id: input_bam
    type: File
    secondaryFiles:
      - .bai
outputs:
  - id: all
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosdepth:0.3.3--hdfd78af_1
