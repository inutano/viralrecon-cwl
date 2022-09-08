cwlVersion: v1.0
class: Workflow
inputs:
  - id: SAMPLE_NAME
    type: string
  - id: INPUT_DIRECTORY
    type: Directory
steps:
  artic.guppyplex:
    run: ../tool/artic/artic.guppyplex.cwl
    in:
      input_directory: INPUT_DIRECTORY
      sample_name: SAMPLE_NAME
    out:
      - fastq
  pigz:
    run: ../tool/artic/pigz.cwl
    in:
      input_fastq: artic.guppyplex/fastq
    out:
      - fastq_gz
outputs:
  artic.guppyplex.fastq:
    type: File
    outputSource: artic.guppyplex/fastq
  pigz:
    type: File
    outputSource: pigz/fastq_gz
