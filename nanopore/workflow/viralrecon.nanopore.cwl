cwlVersion: v1.0
class: Workflow
requirements:
  SubworkflowFeatureRequirement: {}
  StepInputExpressionRequirement: {}
inputs:
  - id: FASTQ_DIRECTORY
    type: Directory
  - id: SCHEME_DIRECTORY
    type: Directory
  - id: FAST5_DIRECTORY
    type: Directory
  - id: SEQUENCING_SUMMARY
    type: File
  - id: PRIMER_BED
    type: File
  - id: GENOME_VERSION
    type: string
    default: 'nCoV-2019.reference'
  - id: ANNOTATION_GFF_GZ_URL
    type: string
    default: "https://github.com/nf-core/test-datasets/raw/viralrecon/genome/MN908947.3/GCA_009858895.3_ASM985889v3_genomic.200409.gff.gz"
  - id: REFERENCE_FASTA_URL
    type: string
    default: "https://github.com/nf-core/test-datasets/raw/viralrecon/genome/MN908947.3/primer_schemes/artic/nCoV-2019/V1200/nCoV-2019.reference.fasta"
  - id: NEXTCLADE_TARBALL_URL
    type: string
    default: "https://github.com/nf-core/test-datasets/raw/viralrecon/genome/MN908947.3/nextclade_sars-cov-2_MN908947_2022-06-14T12_00_00Z.tar.gz"

steps:
  get_annotation_gff:
    in:
      gzip_url: ANNOTATION_GFF_GZ_URL
    out:
      - gff
    run:
      class: CommandLineTool
      requirements:
        ShellCommandRequirement: {}
      arguments:
        - valueFrom: |-
            curl -s -L --output - $(inputs.gzip_url) | gunzip
          shellQuote: False
      inputs:
        gzip_url: string
        output_name:
          type: string
          default: annotation.gff
      outputs:
        - id: gff
          type: stdout
      stdout: $(inputs.output_name)

  get_reference_fasta:
    in:
      url: REFERENCE_FASTA_URL
    out:
      - fasta
    run:
      class: CommandLineTool
      arguments:
        - curl
        - -s
        - -L
        - -o
        - reference.fasta
        - $(inputs.url)
      inputs:
        url: string
      outputs:
        - id: fasta
          type: File
          outputBinding:
            glob: "reference.fasta"

  get_nextclade_dataset:
    in:
      url: NEXTCLADE_TARBALL_URL
    out:
      - dataset
    run:
      class: CommandLineTool
      requirements:
        ShellCommandRequirement: {}
      arguments:
        - valueFrom: |-
            curl -s -L --output - $(inputs.url) | tar x
          shellQuote: False
      inputs:
        url: string
      outputs:
        - id: dataset
          type: Directory
          outputBinding:
            glob: "nextclade_*"

  snpeff.build:
    run: ../tool/snpeff/snpeff.build.cwl
    in:
      reference_fasta: get_reference_fasta/fasta
      input_gff: get_annotation_gff/gff
      genome_version: GENOME_VERSION
    out:
      - all-for-debugging
      - config
      - datadir

  viralrecon:
    run: viralrecon.nanopore.single.cwl
    in:
      SAMPLE_NAME:
        valueFrom: 'SAMPLE_01'
      FASTQ_DIRECTORY: FASTQ_DIRECTORY
      SCHEME_DIRECTORY: SCHEME_DIRECTORY
      FAST5_DIRECTORY: FAST5_DIRECTORY
      SEQUENCING_SUMMARY: SEQUENCING_SUMMARY
      PRIMER_BED: PRIMER_BED
      SNPEFF_CONFIG: snpeff.build/config
      SNPEFF_DATADIR: snpeff.build/datadir
      NEXTCLADE_DATASET: get_nextclade_dataset/dataset
    out:
      - artic.guppyplex.fastq
      - consensus_fasta

  quast:
    run: ../tool/quast/quast.cwl
    in:
      reference_genome_fasta: get_reference_fasta/fasta
      reference_feature_gff: get_annotation_gff/gff
      input_files:
        source: [viralrecon/consensus_fasta]
        linkMerge: merge_flattened
    out:
      - quast_dir

outputs:
  fastq:
    type: File
    outputSource: viralrecon/artic.guppyplex.fastq
