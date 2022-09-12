#!/usr/bin/env cwl-runner
# Generated from: SnpSift -Xmx6g extractFields -s "," -e "." SAMPLE_01.snpeff.vcf.gz CHROM POS REF ALT "ANN[*].GENE" "ANN[*].GENEID" "ANN[*].IMPACT" "ANN[*].EFFECT" "ANN[*].FEATURE" "ANN[*].FEATUREID" "ANN[*].BIOTYPE" "ANN[*].RANK" "ANN[*].HGVS_C" "ANN[*].HGVS_P" "ANN[*].CDNA_POS" "ANN[*].CDNA_LEN" "ANN[*].CDS_POS" "ANN[*].CDS_LEN" "ANN[*].AA_POS" "ANN[*].AA_LEN" "ANN[*].DISTANCE" "EFF[*].EFFECT" "EFF[*].FUNCLASS" "EFF[*].CODON" "EFF[*].AA" "EFF[*].AA_LEN" > SAMPLE_01.snpsift.txt
class: CommandLineTool
cwlVersion: v1.0
baseCommand: SnpSift
arguments:
  - -Xmx6g
  - extractFields
  - -s
  - ','
  - -e
  - '.'
  - $(inputs.input_vcf)
  - CHROM
  - POS
  - REF
  - ALT
  - "ANN[*].GENE"
  - "ANN[*].GENEID"
  - "ANN[*].IMPACT"
  - "ANN[*].EFFECT"
  - "ANN[*].FEATURE"
  - "ANN[*].FEATUREID"
  - "ANN[*].BIOTYPE"
  - "ANN[*].RANK"
  - "ANN[*].HGVS_C"
  - "ANN[*].HGVS_P"
  - "ANN[*].CDNA_POS"
  - "ANN[*].CDNA_LEN"
  - "ANN[*].CDS_POS"
  - "ANN[*].CDS_LEN"
  - "ANN[*].AA_POS"
  - "ANN[*].AA_LEN"
  - "ANN[*].DISTANCE"
  - "EFF[*].EFFECT"
  - "EFF[*].FUNCLASS"
  - "EFF[*].CODON"
  - "EFF[*].AA"
  - "EFF[*].AA_LEN"
inputs:
  - id: input_vcf
    type: File
  - id: sample_name
    type: string
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: out
    type: stdout
stdout: $(inputs.sample_name).snpsift.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpsift:4.3.1t--hdfd78af_3
