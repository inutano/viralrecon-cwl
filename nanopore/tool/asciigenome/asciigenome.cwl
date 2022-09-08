#!/usr/bin/env cwl-runner
# Generated from: ASCIIGenome -ni -x "trackHeight 0 bam#1 && trackHeight 50 bam@2 && readsAsPairs -on && filterVariantReads && save SAMPLE_01.%r.pdf" \" "--batchFile variants.slop.bed --fasta nCoV-2019.reference.fasta SAMPLE_01.primertrimmed.rg.sorted.bam SAMPLE_01.pass.unique.vcf.gz nCoV-2019.primer.bed GCA_009858895.3_ASM985889v3_genomic.200409.gff > /dev/null
class: CommandLineTool
cwlVersion: v1.0
baseCommand: ASCIIGenome
arguments:
  - --nonInteractive
  - --exec
  - $(inputs.command)
  - --batchFile
  - $(inputs.batch_file)
  - --fasta
  - $(inputs.reference_fasta)
  - $(inputs.input_files)
inputs:
  - id: command
    type: string
    default: "trackHeight 0 bam#1 && trackHeight 50 bam@2 && readsAsPairs -on && filterVariantReads && save SAMPLE_01.%r.pdf"
  - id: batch_file
    type: File
  - id: reference_fasta
    type: File
    secondaryFiles:
      - .fai
  - id: input_files
    type: File[]
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mulled-v2-093691b47d719890dc19ac0c13c4528e9776897f:27211b8c38006480d69eb1be3ef09a7bf0a49d76-0
