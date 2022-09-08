#!/usr/bin/env cwl-runner
# Generated from: samtools view --threads 1 -b -F 4 SAMPLE_01.sorted.bam > SAMPLE_01.mapped.sorted.bam
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [samtools, view]
arguments:
  - --threads
  - $(inputs.threads)
  - --bam
  - -F
  - $(inputs.exclude_flags)
  - $(inputs.input_bam)
inputs:
  - id: threads
    type: int
    default: 2
  - id: exclude_flags
    type: int
    default: 4
  - id: input_bam
    type: File
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
    dockerPull: quay.io/biocontainers/samtools:1.15.1--h1170115_0
