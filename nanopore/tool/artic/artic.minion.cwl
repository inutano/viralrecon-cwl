#!/usr/bin/env cwl-runner
# Generated from: export HDF5_PLUGIN_PATH=/usr/local/lib/python3.6/site-packages/ont_fast5_api/vbz_plugin && artic minion --normalise 500  --minimap2 --threads 2 --read-file SAMPLE_01.fastq.gz --scheme-directory ./primer-schemes --scheme-version 3 --fast5-directory fast5_pass --sequencing-summary sequencing_summary.txt nCoV-2019 SAMPLE_01
# primer scheme is available at https://github.com/artic-network/artic-ncov2019/tree/master/primer_schemes
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [artic, minion]
requirements:
  EnvVarRequirement:
    envDef:
      HDF5_PLUGIN_PATH: "/usr/local/lib/python3.6/site-packages/ont_fast5_api/vbz_plugin"
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.scheme_directory)
        writable: true
      - $(inputs.read_file)

arguments:
  - --normalise
  - $(inputs.normalise)
  - --minimap2
  - --threads
  - $(inputs.threads)
  - --read-file
  - $(inputs.read_file)
  - --scheme-directory
  - $(inputs.scheme_directory)
  - --scheme-version
  - $(inputs.scheme_version)
  - --fast5-directory
  - $(inputs.fast5_directory)
  - --sequencing-summary
  - $(inputs.sequencing_summary)
  - $(inputs.scheme_label)
  - $(inputs.sample_name)
inputs:
  - id: normalise
    type: int
    default: 500
  - id: threads
    type: int
    default: 2
  - id: read_file
    type: File
  - id: scheme_directory
    type: Directory
  - id: scheme_version
    type: int
    default: 3
  - id: fast5_directory
    type: Directory
  - id: sequencing_summary
    type: File
  - id: scheme_label
    type: string
    default: nCoV-2019
  - id: sample_name
    type: string
outputs:
  - id: sorted_bam
    type: File
    outputBinding:
      glob: "$(inputs.sample_name).sorted.bam"
  - id: primertrimmed_sorted_bam
    type: File
    secondaryFiles:
      - .bai
    outputBinding:
      glob: "$(inputs.sample_name).primertrimmed.rg.sorted.bam"
  - id: pass_vcf
    type: File
    secondaryFiles:
      - .tbi
    outputBinding:
      glob: "$(inputs.sample_name).pass.vcf.gz"
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.2.2--pyhdfd78af_0
