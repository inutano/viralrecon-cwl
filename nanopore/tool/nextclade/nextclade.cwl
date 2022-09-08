#!/usr/bin/env cwl-runner
# Generated from: nextclade run --jobs 2 --input-dataset nextclade_sars-cov-2_MN908947_2022-06-14T12_00_00Z --output-all ./ --output-basename SAMPLE_01 SAMPLE_01.consensus.fasta
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [nextclade, run]
arguments:
  - --jobs
  - $(inputs.jobs)
  - --input-dataset
  - $(inputs.input_dataset)
  - --output-all
  - .
  - --output-basename
  - $(inputs.output_basename)
  - $(inputs.consensus_fasta)
inputs:
  - id: jobs
    type: int
    default: 2
  - id: input_dataset
    type: Directory
  - id: output_basename
    type: string
  - id: consensus_fasta
    type: File
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
#  - id: output_all
#    type: File
#    outputBinding:
#      glob: "$(inputs.output_all_name)"
#  - id: output_basename
#    type: File
#    outputBinding:
#      glob: "$(inputs.output_basename_name)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextclade:2.2.0--h9ee0642_0
