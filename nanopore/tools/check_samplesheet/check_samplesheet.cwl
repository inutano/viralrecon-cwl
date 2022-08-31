#!/usr/bin/env cwl-runner
# Generated from: check_samplesheet.py samplesheet_test_nanopore.csv samplesheet.valid.csv --platform nanopore
class: CommandLineTool
cwlVersion: v1.0
baseCommand: python
arguments:
  - $(inputs.script)
  - $(inputs.input)
  - $(inputs.output)
  - --platform
  - $(inputs.platform)
inputs:
  - id: script
    type: File
  - id: input
    type: File
  - id: output
    type: string
    default: samplesheet_valid.csv
  - id: platform
    type: string
    default: nanopore
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/python:3.9--1
