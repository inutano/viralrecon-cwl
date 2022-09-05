#!/usr/bin/env cwl-runner
# Generated from: pycoQC -f sequencing_summary.txt -o pycoqc.html -j pycoqc.json
class: CommandLineTool
cwlVersion: v1.0
baseCommand: pycoQC
arguments:
  - -f
  - $(inputs.sequencing_summary)
  - -o
  - $(inputs.output_html)
  - -j
  - $(inputs.output_json)
inputs:
  - id: sequencing_summary
    type: File
  - id: output_html
    type: string
  - id: output_json
    type: string
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
#  - id: o
#    type: File
#    outputBinding:
#      glob: "$(inputs.o_name)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycoqc:2.5.2--py_0
