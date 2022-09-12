#!/usr/bin/env cwl-runner
# Generated from: snpEff -Xmx6g build -config snpeff.config -dataDir ./snpeff_db -gff3 -v nCoV-2019.reference
class: CommandLineTool
cwlVersion: v1.0
baseCommand:
requirements:
  ShellCommandRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entryname: snpeff.config
        entry: |-
          nCoV-2019.reference.genome : nCoV-2019.reference
arguments:
  - valueFrom: |-
      mkdir -p snpeff_db/genomes snpeff_db/$(inputs.genome_version) \
      cp $(inputs.reference_fasta.path) snpeff_db/genomes/$(inputs.genome_version).fa \
      cp $(inputs.input_gff.path) snpeff_db/$(inputs.genome_version)/genes.gff \
      snpEff -Xmx6g build -config snpeff.config -dataDir ./snpeff_db -gff3 -v $(inputs.genome_version)
    shellQuote: False
inputs:
  - id: reference_fasta # snpeff_db/genomes/nCoV-2019.reference.fa
    type: File
  - id: input_gff # snpeff_db/nCoV-2019.reference/genes.gff
    type: File
  - id: genome_version # nCoV-2019.reference
    type: string
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: config
    type: File
    outputBinding:
      glob: "snpeff.config"
  - id: datadir
    type: Directory
    outputBinding:
      glob: "snpeff_db"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpeff:5.0--hdfd78af_1
