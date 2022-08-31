#!/usr/bin/env cwl-runner
# Generated from: artic guppyplex --min-length 400 --max-length 700 --directory barcode01 --output SAMPLE_01.fastq && pigz -p 2 *.fastq
class: CommandLineTool
cwlVersion: v1.0
baseCommand: artic
arguments:
  - guppyplex
  - --min-length
  - $(inputs.min_length)
  - --max-length
  - $(inputs.max_length)
  - --directory
  - $(inputs.directory)
  - --output
  - $(inputs.output_name)
inputs:
  - id: min_length
    type: int
    default: 400
  - id: max_length
    type: int
    default: 700
  - id: directory
    type: Directory
  - id: output_name
    type: string
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
#  - id: output
#    type: File
#    outputBinding:
#      glob: "$(inputs.output_name)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.2.2--pyhdfd78af_0
