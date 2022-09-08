#!/usr/bin/env cwl-runner
# Generated from: samtools stats --threads 1 SAMPLE_01.mapped.sorted.bam > SAMPLE_01.mapped.sorted.bam.stats
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [samtools, stats]
arguments:
  - --threads
  - $(inputs.threads)
  - $(inputs.input_bam)
inputs:
  - id: threads
    type: int
    default: 2
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
