#!/usr/bin/env cwl-runner
# Generated from: collapse_primer_bed.py --left_primer_suffix _LEFT --right_primer_suffix _RIGHT nCoV-2019.primer.bed nCoV-2019.primer.collapsed.bed
class: CommandLineTool
cwlVersion: v1.0
baseCommand: python
arguments:
  - $(inputs.script)
  - --left_primer_suffix
  - $(inputs.left_primer_suffix)
  - --right_primer_suffix
  - $(inputs.right_primer_suffix)
  - $(inputs.input_bed)
  - $(inputs.output_bed_name)
inputs:
  - id: script
    type: File
    default:
      class: File
      location: collapse_primer_bed.py
  - id: left_primer_suffix
    type: string
    default: _LEFT
  - id: right_primer_suffix
    type: string
    default: _RIGHT
  - id: input_bed
    type: File
    label: "nCoV-2019_primer.bed"
  - id: output_bed_name
    type: string
    default: nCoV_2019_primer_collapsed.bed
outputs:
  - id: collapsed_bed
    type: File
    outputBinding:
      glob: $(inputs.output_bed_name)
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/python:3.9--1
