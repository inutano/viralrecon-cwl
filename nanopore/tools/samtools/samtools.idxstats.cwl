#!/usr/bin/env cwl-runner
# Generated from: samtools idxstats SAMPLE_01.mapped.sorted.bam > SAMPLE_01.mapped.sorted.bam.idxstats
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [samtools, idxstats]
arguments:
  - $(inputs.input_bam)
inputs:
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
