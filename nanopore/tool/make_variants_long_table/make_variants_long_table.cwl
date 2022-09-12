#!/usr/bin/env cwl-runner
# Generated from: make_variants_long_table.py --bcftools_query_dir ./bcftools_query --snpsift_dir ./snpsift --pangolin_dir ./pangolin --variant_caller nanopolish
class: CommandLineTool
cwlVersion: v1.0
baseCommand: make_variants_long_table.py
arguments:
  - --bcftools_query_dir
  - $(inputs.bcftools_query_dir)
  - --snpsift_dir
  - $(inputs.snpsift_dir)
  - --pangolin_dir
  - $(inputs.pangolin_dir)
  - --variant_caller
  - $(inputs.variant_caller)
inputs:
  - id: bcftools_query_dir
    type: Directory
    default:
      class: Directory
      location: ./bcftools_query
  - id: snpsift_dir
    type: Directory
    default:
      class: Directory
      location: ./snpsift
  - id: pangolin_dir
    type: Directory
    default:
      class: Directory
      location: ./pangolin
  - id: variant_caller
    type: string
    default: nanopolish
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mulled-v2-77320db00eefbbf8c599692102c3d387a37ef02a:08144a66f00dc7684fad061f1466033c0176e7ad-0
