cwlVersion: v1.0
class: Workflow
requirements:
  StepInputExpressionRequirement: {}
inputs:
  - id: SAMPLE_NAME
    type: string
  - id: FASTQ_DIRECTORY
    type: Directory
  - id: SCHEME_DIRECTORY
    type: Directory
  - id: FAST5_DIRECTORY
    type: Directory
  - id: SEQUENCING_SUMMARY
    type: File

steps:
  artic.guppyplex:
    run: ../tool/artic/artic.guppyplex.cwl
    in:
      input_directory: FASTQ_DIRECTORY
      sample_name: SAMPLE_NAME
    out:
      - fastq
  pigz:
    run: ../tool/artic/pigz.cwl
    in:
      input_fastq: artic.guppyplex/fastq
    out:
      - fastq_gz
  nanoplot:
    run: ../tool/nanoplot/nanoplot.cwl
    in:
      input_fastq: pigz/fastq_gz
    out:
      - all_outputs
  artic.minion:
    run: ../tool/artic/artic.minion.cwl
    in:
      read_file: pigz/fastq_gz
      scheme_directory: SCHEME_DIRECTORY
      fast5_directory: FAST5_DIRECTORY
      sequencing_summary: SEQUENCING_SUMMARY
      sample_name: SAMPLE_NAME
    out:
      - sorted_bam
      - all-for-debugging
  samtools.view:
    run: ../tool/samtools/samtools.view.cwl
    in:
      input_bam: artic.minion/sorted_bam
      sample_name: SAMPLE_NAME
      output_name:
        valueFrom: "$(inputs.sample_name).mapped.sorted.bam"
    out:
      - mapped_bam

outputs:
  artic.guppyplex.fastq:
    type: File
    outputSource: artic.guppyplex/fastq
  pigz.fastq_gz:
    type: File
    outputSource: pigz/fastq_gz
  nanoplot.all:
      type:
        type: array
        items: [File, Directory]
      outputSource: nanoplot/all_outputs