cwlVersion: v1.0
class: Workflow
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
      - all-for-debugging
outputs:
  artic.guppyplex.fastq:
    type: File
    outputSource: artic.guppyplex/fastq
  pigz:
    type: File
    outputSource: pigz/fastq_gz
  nanoplot:
      type:
        type: array
        items: [File, Directory]
      outputSource: nanoplot/all_outputs
