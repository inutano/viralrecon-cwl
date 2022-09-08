#!/usr/bin/env cwl-runner
# Generated from: pangolin SAMPLE_01.consensus.fasta --outfile SAMPLE_01.pangolin.csv --threads 2
class: CommandLineTool
cwlVersion: v1.0
baseCommand: pangolin
arguments:
  - $(inputs.consensus_fasta)
  - --outfile
  - $(inputs.outfile_name)
  - --threads
  - $(inputs.threads)
inputs:
  - id: consensus_fasta
    type: File
  - id: outfile_name
    type: string
  - id: threads
    type: int
    default: 2
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
#  - id: outfile
#    type: File
#    outputBinding:
#      glob: "$(inputs.outfile_name)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangolin:4.1.1--pyhdfd78af_0
