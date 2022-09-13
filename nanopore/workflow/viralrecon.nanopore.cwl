cwlVersion: v1.0
class: Workflow
requirements:
  SubworkflowFeatureRequirement: {}
  StepInputExpressionRequirement: {}
  ScatterFeatureRequirement: {}
inputs:
  - id: LIST_SAMPLE_NAME
    type: string[]
    default:
      - SAMPLE_01
  - id: LIST_BARCODE_NAME
    type: string[]
    default:
      - barcode01
  - id: FASTQ_DIRECTORY
    type: Directory
  - id: FAST5_DIRECTORY
    type: Directory
  - id: SEQUENCING_SUMMARY
    type: File
  # - id: FASTQ_DIRECTORY_S3_URL
  #   type: string
  #   default: "s3://nf-core-awsmegatests/viralrecon/input_data/minion_test/fastq_pass"
  # - id: FAST5_DIRECTORY_S3_URL
  #   type: string
  #   default: "s3://nf-core-awsmegatests/viralrecon/input_data/minion_test/fast5_pass"
  # - id: SEQUENCING_SUMMARY_S3_URL
  #   type: string
  #   default: "s3://nf-core-awsmegatests/viralrecon/input_data/minion_test/sequencing_summary.txt"
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
  # awscli requires user credential: download data by setup.sh for now
  # get_fastq_dir:
  #   in:
  #     url: FASTQ_DIRECTORY_S3_URL
  #   out:
  #     - dir
  #   run:
  #     class: CommandLineTool
  #     hints:
  #       - class: DockerRequirement
  #         dockerPull: amazon/aws-cli:2.7.31
  #     arguments:
  #       - aws
  #       - s3
  #       - mirror
  #       - $(inputs.url)
  #       - '.'
  #     inputs:
  #       url: string
  #     outputs:
  #       - id: dir
  #         type: Directory
  #         outputBinding:
  #           glob: "fastq_*"
  #
  # get_fast5_dir:
  #   in:
  #     url: FAST5_DIRECTORY_S3_URL
  #   out:
  #     - dir
  #   run:
  #     class: CommandLineTool
  #     hints:
  #       - class: DockerRequirement
  #         dockerPull: amazon/aws-cli:2.7.31
  #     arguments:
  #       - aws
  #       - s3
  #       - mirror
  #       - $(inputs.url)
  #       - '.'
  #     inputs:
  #       url: string
  #     outputs:
  #       - id: dir
  #         type: Directory
  #         outputBinding:
  #           glob: "fast5_*"
  #
  # get_sequencing_summary:
  #   in:
  #     url: SEQUENCING_SUMMARY_S3_URL
  #   out:
  #     - sequencing_summary
  #   run:
  #     class: CommandLineTool
  #     hints:
  #       - class: DockerRequirement
  #         dockerPull: amazon/aws-cli:2.7.31
  #     arguments:
  #       - aws
  #       - s3
  #       - mirror
  #       - $(inputs.url)
  #       - .
  #     inputs:
  #       url: string
  #     outputs:
  #       - id: sequencing_summary
  #         type: File
  #         outputBinding:
  #           glob: "sequencing_summary.txt"

  get_primer_scheme:
    in: {}
    out:
      - scheme_dir
    run:
      class: CommandLineTool
      arguments:
        - git
        - clone
        - --depth=1
        - $(inputs.url)
      inputs:
        url:
          type: string
          default: "https://github.com/artic-network/artic-ncov2019"
      outputs:
        - id: scheme_dir
          type: Directory
          outputBinding:
            glob: "artic-ncov2019/primer_schemes"

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
    scatter: [SAMPLE_NAME, BARCODE_NAME]
    scatterMethod: dotproduct
    in:
      SAMPLE_NAME: LIST_SAMPLE_NAME
      BARCODE_NAME: LIST_BARCODE_NAME
      # FASTQ_DIRECTORY: get_fastq_dir/dir
      # FAST5_DIRECTORY: get_fast5_dir/dir
      # SEQUENCING_SUMMARY: get_sequencing_summary/sequencing_summary
      # SCHEME_DIRECTORY: get_primer_scheme/scheme_dir
      FASTQ_DIRECTORY: FASTQ_DIRECTORY
      FAST5_DIRECTORY: FAST5_DIRECTORY
      SEQUENCING_SUMMARY: SEQUENCING_SUMMARY
      SCHEME_DIRECTORY: get_primer_scheme/scheme_dir
      SNPEFF_CONFIG: snpeff.build/config
      SNPEFF_DATADIR: snpeff.build/datadir
      NEXTCLADE_DATASET: get_nextclade_dataset/dataset
    out:
      - consensus_fasta
      - nanoplot.all
      - mosdepth.amplicon.all
      - mosdepth.genome.all
      - bcftoos.stats.txt
      - snpsift.out
      - pangolin.csv
      - nextclade.out

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
  nanoplot.all:
    type:
      type: array
      items:
        type: array
        items: [File, Directory]
    outputSource: viralrecon/nanoplot.all
  mosdepth.amplicon.all:
    type:
      type: array
      items:
        type: array
        items: [File, Directory]
    outputSource: viralrecon/mosdepth.amplicon.all
  mosdepth.genome.all:
    type:
      type: array
      items:
        type: array
        items: [File, Directory]
    outputSource: viralrecon/mosdepth.genome.all
  bcftoos.stats.txt:
    type: File[]
    outputSource: viralrecon/bcftoos.stats.txt
  snpsift.out:
    type: File[]
    outputSource: viralrecon/snpsift.out
  pangolin.csv:
    type: File[]
    outputSource: viralrecon/pangolin.csv
  nextclade.out:
    type: Directory[]
    outputSource: viralrecon/nextclade.out
  quast.dir:
    type: Directory
    outputSource: quast/quast_dir
