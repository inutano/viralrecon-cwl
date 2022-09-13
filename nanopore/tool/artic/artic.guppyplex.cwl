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
  - $(inputs.input_directory.path)/$(inputs.barcode_name)
  - --output
  - $(inputs.sample_name).fastq
inputs:
  - id: min_length
    type: int
    default: 400
  - id: max_length
    type: int
    default: 700
  - id: input_directory
    type: Directory
  - id: sample_name
    type: string
  - id: barcode_name
    type: string
outputs:
  - id: fastq
    type: File
    outputBinding:
      glob: "$(inputs.sample_name).fastq"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.2.2--pyhdfd78af_0
