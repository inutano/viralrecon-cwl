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
  - id: REFERENCE_GENOME_PREFIX
    type: string
    default: "nCoV-2019.reference"
  - id: SNPEFF_CONFIG
    type: File
  - id: SNPEFF_DATADIR
    type: Directory
  - id: NEXTCLADE_DATASET
    type: Directory

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
      - primertrimmed_sorted_bam
      - pass_vcf
      - consensus_fasta
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

  extract_primer_bed:
    in:
      dir: SCHEME_DIRECTORY
    out:
      - primer_bed
    run:
      class: CommandLineTool
      baseCommand: 'true'
      inputs:
        dir: Directory
      outputs:
        - id: primer_bed
          type: File
          outputBinding:
            glob: "$(inputs.dir)/**/nCoV-2019.primer.bed"

  collapse_primer_bed:
    run: ../tool/collapse_primer_bed/collapse_primer_bed.cwl
    in:
      input_bed: extract_primer_bed/primer_bed
    out:
      - collapsed_bed
  mosdepth.amplicon:
    run: ../tool/mosdepth/mosdepth.amplicon.cwl
    in:
      by: collapse_primer_bed/collapsed_bed
      input_label: SAMPLE_NAME
      input_bam: artic.minion/primertrimmed_sorted_bam
    out:
      - all
  mosdepth.genome:
    run: ../tool/mosdepth/mosdepth.genome.cwl
    in:
      sample_name: SAMPLE_NAME
      input_bam: artic.minion/primertrimmed_sorted_bam
    out:
      - all
  vcfuniq:
    run: ../tool/vcfuniq/vcfuniq.cwl
    in:
      input_vcf: artic.minion/pass_vcf
      sample_name: SAMPLE_NAME
    out:
      - uniq_vcf
  tabix:
    run: ../tool/tabix/tabix.cwl
    in:
      input_file: vcfuniq/uniq_vcf
    out:
      - index
  to_vcf_with_index:
    in:
      vcf: vcfuniq/uniq_vcf
      index: tabix/index
    out:
      - vcf_with_index
    run:
      class: CommandLineTool
      requirements:
        InitialWorkDirRequirement:
          listing:
            - entry: $(inputs.vcf)
            - entry: $(inputs.index)
      baseCommand: "true"
      inputs:
        vcf: File
        index: File
      outputs:
        vcf_with_index:
          type: File
          outputBinding:
            glob: $(inputs.vcf.basename)
          secondaryFiles:
            - .tbi
  bcftools.stats:
    run: ../tool/bcftools/bcftools.stats.cwl
    in:
      input_vcf: to_vcf_with_index/vcf_with_index
      sample_name: SAMPLE_NAME
      output_name:
        valueFrom: $(inputs.sample_name).bcftools_stats.txt
    out:
      - out
  snpeff:
    run: ../tool/snpeff/snpeff.cwl
    in:
      reference_name: REFERENCE_GENOME_PREFIX
      config: SNPEFF_CONFIG
      dataDir: SNPEFF_DATADIR
      input_vcf: vcfuniq/uniq_vcf
      sample_name: SAMPLE_NAME
    out:
      - vcf
  snpsift:
    run: ../tool/snpsift/snpsift.cwl
    in:
      input_vcf: snpeff/vcf
      sample_name: SAMPLE_NAME
    out:
      - out

  pangolin:
    run: ../tool/pangolin/pangolin.cwl
    in:
      consensus_fasta: artic.minion/consensus_fasta
      outfile_name: SAMPLE_NAME
    out:
      - csv

  nextclade:
    run: ../tool/nextclade/nextclade.cwl
    in:
      input_dataset: NEXTCLADE_DATASET
      output_basename: SAMPLE_NAME
      consensus_fasta: artic.minion/consensus_fasta
    out:
      - out


outputs:
  artic.guppyplex.fastq:
    type: File
    outputSource: artic.guppyplex/fastq
  pigz.fastq_gz:
    type: File
    outputSource: pigz/fastq_gz
  consensus_fasta:
    type: File
    outputSource: artic.minion/consensus_fasta
  # nanoplot.all:
  #     type:
  #       type: array
  #       items: [File, Directory]
  #     outputSource: nanoplot/all_outputs
  # mosdepth.amplicon.all:
  #     type:
  #       type: array
  #       items: [File, Directory]
  #     outputSource: nanoplot/all_outputs
  # mosdepth.genome.all:
  #     type:
  #       type: array
  #       items: [File, Directory]
  #     outputSource: nanoplot/all_outputs
  bcftoos.stats.txt:
    type: File
    outputSource: bcftools.stats/out
