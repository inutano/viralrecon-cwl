{
    "$graph": [
        {
            "class": "CommandLineTool",
            "baseCommand": "artic",
            "arguments": [
                "guppyplex",
                "--min-length",
                "$(inputs.min_length)",
                "--max-length",
                "$(inputs.max_length)",
                "--directory",
                "$(inputs.input_directory.path)/$(inputs.barcode_name)",
                "--output",
                "$(inputs.sample_name).fastq"
            ],
            "inputs": [
                {
                    "id": "#artic.guppyplex.cwl/min_length",
                    "type": "int",
                    "default": 400
                },
                {
                    "id": "#artic.guppyplex.cwl/max_length",
                    "type": "int",
                    "default": 700
                },
                {
                    "id": "#artic.guppyplex.cwl/input_directory",
                    "type": "Directory"
                },
                {
                    "id": "#artic.guppyplex.cwl/sample_name",
                    "type": "string"
                },
                {
                    "id": "#artic.guppyplex.cwl/barcode_name",
                    "type": "string"
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/artic:1.2.2--pyhdfd78af_0"
                }
            ],
            "id": "#artic.guppyplex.cwl",
            "outputs": [
                {
                    "id": "#artic.guppyplex.cwl/fastq",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.sample_name).fastq"
                    }
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "baseCommand": [
                "artic",
                "minion"
            ],
            "requirements": [
                {
                    "envDef": [
                        {
                            "envValue": "/usr/local/lib/python3.6/site-packages/ont_fast5_api/vbz_plugin",
                            "envName": "HDF5_PLUGIN_PATH"
                        }
                    ],
                    "class": "EnvVarRequirement"
                },
                {
                    "listing": [
                        {
                            "entry": "$(inputs.scheme_directory)",
                            "writable": true
                        },
                        "$(inputs.read_file)"
                    ],
                    "class": "InitialWorkDirRequirement"
                }
            ],
            "arguments": [
                "--normalise",
                "$(inputs.normalise)",
                "--minimap2",
                "--threads",
                "$(inputs.threads)",
                "--read-file",
                "$(inputs.read_file)",
                "--scheme-directory",
                "$(inputs.scheme_directory)",
                "--scheme-version",
                "$(inputs.scheme_version)",
                "--fast5-directory",
                "$(inputs.fast5_directory)",
                "--sequencing-summary",
                "$(inputs.sequencing_summary)",
                "$(inputs.scheme_label)",
                "$(inputs.sample_name)"
            ],
            "inputs": [
                {
                    "id": "#artic.minion.cwl/normalise",
                    "type": "int",
                    "default": 500
                },
                {
                    "id": "#artic.minion.cwl/threads",
                    "type": "int",
                    "default": 2
                },
                {
                    "id": "#artic.minion.cwl/read_file",
                    "type": "File"
                },
                {
                    "id": "#artic.minion.cwl/scheme_directory",
                    "type": "Directory"
                },
                {
                    "id": "#artic.minion.cwl/scheme_version",
                    "type": "int",
                    "default": 3
                },
                {
                    "id": "#artic.minion.cwl/fast5_directory",
                    "type": "Directory"
                },
                {
                    "id": "#artic.minion.cwl/sequencing_summary",
                    "type": "File"
                },
                {
                    "id": "#artic.minion.cwl/scheme_label",
                    "type": "string",
                    "default": "nCoV-2019"
                },
                {
                    "id": "#artic.minion.cwl/sample_name",
                    "type": "string"
                }
            ],
            "outputs": [
                {
                    "id": "#artic.minion.cwl/sorted_bam",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.sample_name).sorted.bam"
                    }
                },
                {
                    "id": "#artic.minion.cwl/primertrimmed_sorted_bam",
                    "type": "File",
                    "secondaryFiles": [
                        ".bai"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.sample_name).primertrimmed.rg.sorted.bam"
                    }
                },
                {
                    "id": "#artic.minion.cwl/pass_vcf",
                    "type": "File",
                    "secondaryFiles": [
                        ".tbi"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.sample_name).pass.vcf.gz"
                    }
                },
                {
                    "id": "#artic.minion.cwl/consensus_fasta",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.sample_name).consensus.fasta"
                    }
                },
                {
                    "id": "#artic.minion.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/artic:1.2.2--pyhdfd78af_0"
                }
            ],
            "id": "#artic.minion.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "pigz",
            "requirements": [
                {
                    "listing": [
                        "$(inputs.input_fastq)"
                    ],
                    "class": "InitialWorkDirRequirement"
                }
            ],
            "arguments": [
                "-p",
                "$(inputs.processes)",
                "$(inputs.input_fastq)"
            ],
            "inputs": [
                {
                    "id": "#pigz.cwl/processes",
                    "type": "int",
                    "default": 2
                },
                {
                    "id": "#pigz.cwl/input_fastq",
                    "type": "File"
                }
            ],
            "outputs": [
                {
                    "id": "#pigz.cwl/fastq_gz",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.input_fastq.basename).gz"
                    }
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/artic:1.2.2--pyhdfd78af_0"
                }
            ],
            "id": "#pigz.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": [
                "bcftools",
                "stats"
            ],
            "arguments": [
                "$(inputs.input_vcf)"
            ],
            "inputs": [
                {
                    "id": "#bcftools.stats.cwl/input_vcf",
                    "type": "File",
                    "secondaryFiles": [
                        ".tbi"
                    ]
                },
                {
                    "id": "#bcftools.stats.cwl/output_name",
                    "type": "string"
                }
            ],
            "outputs": [
                {
                    "id": "#bcftools.stats.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                },
                {
                    "id": "#bcftools.stats.cwl/out",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_name)"
                    }
                }
            ],
            "stdout": "$(inputs.output_name)",
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/bcftools:1.15.1--h0ea216a_0"
                }
            ],
            "id": "#bcftools.stats.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "python",
            "arguments": [
                "$(inputs.script)",
                "--left_primer_suffix",
                "$(inputs.left_primer_suffix)",
                "--right_primer_suffix",
                "$(inputs.right_primer_suffix)",
                "$(inputs.input_bed)",
                "$(inputs.output_bed_name)"
            ],
            "inputs": [
                {
                    "id": "#collapse_primer_bed.cwl/script",
                    "type": "File",
                    "default": {
                        "class": "File",
                        "location": "file:///Users/inutano/repos/cwl/viralrecon-cwl/nanopore/tool/collapse_primer_bed/collapse_primer_bed.py"
                    }
                },
                {
                    "id": "#collapse_primer_bed.cwl/left_primer_suffix",
                    "type": "string",
                    "default": "_LEFT"
                },
                {
                    "id": "#collapse_primer_bed.cwl/right_primer_suffix",
                    "type": "string",
                    "default": "_RIGHT"
                },
                {
                    "id": "#collapse_primer_bed.cwl/input_bed",
                    "type": "File",
                    "label": "nCoV-2019_primer.bed"
                },
                {
                    "id": "#collapse_primer_bed.cwl/output_bed_name",
                    "type": "string",
                    "default": "nCoV_2019_primer_collapsed.bed"
                }
            ],
            "outputs": [
                {
                    "id": "#collapse_primer_bed.cwl/collapsed_bed",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_bed_name)"
                    }
                },
                {
                    "id": "#collapse_primer_bed.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/python:3.9--1"
                }
            ],
            "id": "#collapse_primer_bed.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "mosdepth",
            "arguments": [
                "--threads",
                "$(inputs.threads)",
                "--by",
                "$(inputs.by)",
                "--fast-mode",
                "--use-median",
                "--thresholds",
                "$(inputs.thresholds)",
                "$(inputs.input_label)",
                "$(inputs.input_bam)"
            ],
            "inputs": [
                {
                    "id": "#mosdepth.amplicon.cwl/threads",
                    "type": "int",
                    "default": 2
                },
                {
                    "id": "#mosdepth.amplicon.cwl/by",
                    "type": "File"
                },
                {
                    "id": "#mosdepth.amplicon.cwl/thresholds",
                    "type": "string",
                    "default": "0,1,10,50,100,500"
                },
                {
                    "id": "#mosdepth.amplicon.cwl/input_label",
                    "type": "string"
                },
                {
                    "id": "#mosdepth.amplicon.cwl/input_bam",
                    "type": "File",
                    "secondaryFiles": [
                        ".bai"
                    ]
                }
            ],
            "outputs": [
                {
                    "id": "#mosdepth.amplicon.cwl/all",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/mosdepth:0.3.3--hdfd78af_1"
                }
            ],
            "id": "#mosdepth.amplicon.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "mosdepth",
            "arguments": [
                "--threads",
                "$(inputs.threads)",
                "--fast-mode",
                "--by",
                "$(inputs.by)",
                "$(inputs.sample_name)",
                "$(inputs.input_bam)"
            ],
            "inputs": [
                {
                    "id": "#mosdepth.genome.cwl/threads",
                    "type": "int",
                    "default": 2
                },
                {
                    "id": "#mosdepth.genome.cwl/by",
                    "type": "int",
                    "default": 200
                },
                {
                    "id": "#mosdepth.genome.cwl/sample_name",
                    "type": "string"
                },
                {
                    "id": "#mosdepth.genome.cwl/input_bam",
                    "type": "File",
                    "secondaryFiles": [
                        ".bai"
                    ]
                }
            ],
            "outputs": [
                {
                    "id": "#mosdepth.genome.cwl/all",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/mosdepth:0.3.3--hdfd78af_1"
                }
            ],
            "id": "#mosdepth.genome.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "NanoPlot",
            "arguments": [
                "-t",
                "$(inputs.threads)",
                "--fastq",
                "$(inputs.input_fastq)"
            ],
            "inputs": [
                {
                    "id": "#nanoplot.cwl/threads",
                    "type": "int",
                    "default": 2
                },
                {
                    "id": "#nanoplot.cwl/input_fastq",
                    "type": "File"
                }
            ],
            "outputs": [
                {
                    "id": "#nanoplot.cwl/all",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/nanoplot:1.40.0--pyhdfd78af_0"
                }
            ],
            "id": "#nanoplot.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": [
                "nextclade",
                "run"
            ],
            "arguments": [
                "--jobs",
                "$(inputs.jobs)",
                "--input-dataset",
                "$(inputs.input_dataset)",
                "--output-all",
                "$(inputs.output_dirname)",
                "--output-basename",
                "$(inputs.output_basename)",
                "$(inputs.consensus_fasta)"
            ],
            "inputs": [
                {
                    "id": "#nextclade.cwl/jobs",
                    "type": "int",
                    "default": 2
                },
                {
                    "id": "#nextclade.cwl/input_dataset",
                    "type": "Directory"
                },
                {
                    "id": "#nextclade.cwl/output_dirname",
                    "type": "string",
                    "default": "nextclade_out"
                },
                {
                    "id": "#nextclade.cwl/output_basename",
                    "type": "string"
                },
                {
                    "id": "#nextclade.cwl/consensus_fasta",
                    "type": "File"
                }
            ],
            "outputs": [
                {
                    "id": "#nextclade.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                },
                {
                    "id": "#nextclade.cwl/out",
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "$(inputs.output_dirname)"
                    }
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/nextclade:2.2.0--h9ee0642_0"
                }
            ],
            "id": "#nextclade.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "pangolin",
            "arguments": [
                "$(inputs.consensus_fasta)",
                "--outfile",
                "$(inputs.outfile_name)",
                "--threads",
                "$(inputs.threads)"
            ],
            "inputs": [
                {
                    "id": "#pangolin.cwl/consensus_fasta",
                    "type": "File"
                },
                {
                    "id": "#pangolin.cwl/outfile_name",
                    "type": "string"
                },
                {
                    "id": "#pangolin.cwl/threads",
                    "type": "int",
                    "default": 2
                }
            ],
            "outputs": [
                {
                    "id": "#pangolin.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                },
                {
                    "id": "#pangolin.cwl/csv",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.outfile_name)"
                    }
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/pangolin:4.1.1--pyhdfd78af_0"
                }
            ],
            "id": "#pangolin.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "quast.py",
            "arguments": [
                "--output-dir",
                "$(inputs.output_dir_name)",
                "-r",
                "$(inputs.reference_genome_fasta)",
                "--features",
                "$(inputs.reference_feature_gff)",
                "--threads",
                "$(inputs.threads)",
                "$(inputs.input_files)"
            ],
            "inputs": [
                {
                    "id": "#quast.cwl/output_dir_name",
                    "type": "string",
                    "default": "quast"
                },
                {
                    "id": "#quast.cwl/reference_genome_fasta",
                    "type": "File"
                },
                {
                    "id": "#quast.cwl/reference_feature_gff",
                    "type": "File"
                },
                {
                    "id": "#quast.cwl/threads",
                    "type": "int",
                    "default": 2
                },
                {
                    "id": "#quast.cwl/input_files",
                    "type": {
                        "type": "array",
                        "items": "File"
                    }
                }
            ],
            "outputs": [
                {
                    "id": "#quast.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                },
                {
                    "id": "#quast.cwl/quast_dir",
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "quast"
                    }
                },
                {
                    "id": "#quast.cwl/report",
                    "type": "File",
                    "outputBinding": {
                        "glob": "**/report.tsv"
                    }
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/quast:5.2.0--py39pl5321h2add14b_1"
                }
            ],
            "id": "#quast.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": [
                "samtools",
                "view"
            ],
            "arguments": [
                "--threads",
                "$(inputs.threads)",
                "--bam",
                "-F",
                "$(inputs.exclude_flags)",
                "$(inputs.input_bam)"
            ],
            "inputs": [
                {
                    "id": "#samtools.view.cwl/threads",
                    "type": "int",
                    "default": 2
                },
                {
                    "id": "#samtools.view.cwl/exclude_flags",
                    "type": "int",
                    "default": 4
                },
                {
                    "id": "#samtools.view.cwl/input_bam",
                    "type": "File"
                },
                {
                    "id": "#samtools.view.cwl/output_name",
                    "type": "string"
                }
            ],
            "outputs": [
                {
                    "id": "#samtools.view.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                },
                {
                    "id": "#samtools.view.cwl/mapped_bam",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_name)"
                    }
                }
            ],
            "stdout": "$(inputs.output_name)",
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/samtools:1.15.1--h1170115_0"
                }
            ],
            "id": "#samtools.view.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": null,
            "requirements": [
                {
                    "listing": [
                        {
                            "entryname": "snpeff.config",
                            "entry": "nCoV-2019.reference.genome : nCoV-2019.reference"
                        }
                    ],
                    "class": "InitialWorkDirRequirement"
                },
                {
                    "class": "ShellCommandRequirement"
                }
            ],
            "arguments": [
                {
                    "valueFrom": "mkdir -p snpeff_db/genomes snpeff_db/$(inputs.genome_version) \\\ncp $(inputs.reference_fasta.path) snpeff_db/genomes/$(inputs.genome_version).fa \\\ncp $(inputs.input_gff.path) snpeff_db/$(inputs.genome_version)/genes.gff \\\nsnpEff -Xmx6g build -config snpeff.config -dataDir ./snpeff_db -gff3 -v $(inputs.genome_version)",
                    "shellQuote": false
                }
            ],
            "inputs": [
                {
                    "id": "#snpeff.build.cwl/reference_fasta",
                    "type": "File"
                },
                {
                    "id": "#snpeff.build.cwl/input_gff",
                    "type": "File"
                },
                {
                    "id": "#snpeff.build.cwl/genome_version",
                    "type": "string"
                }
            ],
            "outputs": [
                {
                    "id": "#snpeff.build.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                },
                {
                    "id": "#snpeff.build.cwl/config",
                    "type": "File",
                    "outputBinding": {
                        "glob": "snpeff.config"
                    }
                },
                {
                    "id": "#snpeff.build.cwl/datadir",
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "snpeff_db"
                    }
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/snpeff:5.0--hdfd78af_1"
                }
            ],
            "id": "#snpeff.build.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "snpEff",
            "arguments": [
                "-Xmx6g",
                "$(inputs.reference_name).reference",
                "-config",
                "$(inputs.config)",
                "-dataDir",
                "$(inputs.dataDir)",
                "$(inputs.input_vcf)",
                "-csvStats",
                "$(inputs.sample_name).snpeff.csv"
            ],
            "inputs": [
                {
                    "id": "#snpeff.cwl/reference_name",
                    "type": "string"
                },
                {
                    "id": "#snpeff.cwl/config",
                    "type": "File"
                },
                {
                    "id": "#snpeff.cwl/dataDir",
                    "type": "Directory"
                },
                {
                    "id": "#snpeff.cwl/input_vcf",
                    "type": "File"
                },
                {
                    "id": "#snpeff.cwl/sample_name",
                    "type": "string"
                }
            ],
            "outputs": [
                {
                    "id": "#snpeff.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                },
                {
                    "id": "#snpeff.cwl/vcf",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.sample_name).snpeff.vcf"
                    }
                }
            ],
            "stdout": "$(inputs.sample_name).snpeff.vcf",
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/snpeff:5.0--hdfd78af_1"
                }
            ],
            "id": "#snpeff.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "SnpSift",
            "arguments": [
                "-Xmx6g",
                "extractFields",
                "-s",
                ",",
                "-e",
                ".",
                "$(inputs.input_vcf)",
                "CHROM",
                "POS",
                "REF",
                "ALT",
                "ANN[*].GENE",
                "ANN[*].GENEID",
                "ANN[*].IMPACT",
                "ANN[*].EFFECT",
                "ANN[*].FEATURE",
                "ANN[*].FEATUREID",
                "ANN[*].BIOTYPE",
                "ANN[*].RANK",
                "ANN[*].HGVS_C",
                "ANN[*].HGVS_P",
                "ANN[*].CDNA_POS",
                "ANN[*].CDNA_LEN",
                "ANN[*].CDS_POS",
                "ANN[*].CDS_LEN",
                "ANN[*].AA_POS",
                "ANN[*].AA_LEN",
                "ANN[*].DISTANCE",
                "EFF[*].EFFECT",
                "EFF[*].FUNCLASS",
                "EFF[*].CODON",
                "EFF[*].AA",
                "EFF[*].AA_LEN"
            ],
            "inputs": [
                {
                    "id": "#snpsift.cwl/input_vcf",
                    "type": "File"
                },
                {
                    "id": "#snpsift.cwl/sample_name",
                    "type": "string"
                }
            ],
            "outputs": [
                {
                    "id": "#snpsift.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                },
                {
                    "id": "#snpsift.cwl/out",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.sample_name).snpsift.txt"
                    }
                }
            ],
            "stdout": "$(inputs.sample_name).snpsift.txt",
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/snpsift:4.3.1t--hdfd78af_3"
                }
            ],
            "id": "#snpsift.cwl"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": "tabix",
            "requirements": [
                {
                    "listing": [
                        "$(inputs.input_file)"
                    ],
                    "class": "InitialWorkDirRequirement"
                }
            ],
            "arguments": [
                "--preset",
                "$(inputs.preset)",
                "--force",
                "$(inputs.input_file)"
            ],
            "inputs": [
                {
                    "id": "#tabix.cwl/preset",
                    "type": {
                        "type": "enum",
                        "symbols": [
                            "#tabix.cwl/preset/gff",
                            "#tabix.cwl/preset/bed",
                            "#tabix.cwl/preset/sam",
                            "#tabix.cwl/preset/vcf"
                        ]
                    },
                    "default": "vcf"
                },
                {
                    "id": "#tabix.cwl/input_file",
                    "type": "File"
                }
            ],
            "outputs": [
                {
                    "id": "#tabix.cwl/index",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.input_file.basename).tbi"
                    }
                },
                {
                    "id": "#tabix.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                }
            ],
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/tabix:1.11--hdfd78af_0"
                }
            ],
            "id": "#tabix.cwl"
        },
        {
            "class": "CommandLineTool",
            "requirements": [
                {
                    "class": "ShellCommandRequirement"
                }
            ],
            "arguments": [
                {
                    "valueFrom": "vcfuniq $(inputs.input_vcf.path) | bgzip -c -f",
                    "shellQuote": false
                }
            ],
            "inputs": [
                {
                    "id": "#vcfuniq.cwl/input_vcf",
                    "type": "File",
                    "secondaryFiles": [
                        ".tbi"
                    ]
                },
                {
                    "id": "#vcfuniq.cwl/sample_name",
                    "type": "string"
                }
            ],
            "outputs": [
                {
                    "id": "#vcfuniq.cwl/all-for-debugging",
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputBinding": {
                        "glob": "*"
                    }
                },
                {
                    "id": "#vcfuniq.cwl/uniq_vcf",
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.sample_name).unique.vcf.gz"
                    }
                }
            ],
            "stdout": "$(inputs.sample_name).unique.vcf.gz",
            "hints": [
                {
                    "class": "DockerRequirement",
                    "dockerPull": "quay.io/biocontainers/vcflib:1.0.3--hecb563c_1"
                }
            ],
            "id": "#vcfuniq.cwl"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "id": "#main/LIST_SAMPLE_NAME",
                    "type": {
                        "type": "array",
                        "items": "string"
                    },
                    "default": [
                        "SAMPLE_01"
                    ]
                },
                {
                    "id": "#main/LIST_BARCODE_NAME",
                    "type": {
                        "type": "array",
                        "items": "string"
                    },
                    "default": [
                        "barcode01"
                    ]
                },
                {
                    "id": "#main/FASTQ_DIRECTORY",
                    "type": "Directory"
                },
                {
                    "id": "#main/FAST5_DIRECTORY",
                    "type": "Directory"
                },
                {
                    "id": "#main/SEQUENCING_SUMMARY",
                    "type": "File"
                },
                {
                    "id": "#main/GENOME_VERSION",
                    "type": "string",
                    "default": "nCoV-2019.reference"
                },
                {
                    "id": "#main/ANNOTATION_GFF_GZ_URL",
                    "type": "string",
                    "default": "https://github.com/nf-core/test-datasets/raw/viralrecon/genome/MN908947.3/GCA_009858895.3_ASM985889v3_genomic.200409.gff.gz"
                },
                {
                    "id": "#main/REFERENCE_FASTA_URL",
                    "type": "string",
                    "default": "https://github.com/nf-core/test-datasets/raw/viralrecon/genome/MN908947.3/primer_schemes/artic/nCoV-2019/V1200/nCoV-2019.reference.fasta"
                },
                {
                    "id": "#main/NEXTCLADE_TARBALL_URL",
                    "type": "string",
                    "default": "https://github.com/nf-core/test-datasets/raw/viralrecon/genome/MN908947.3/nextclade_sars-cov-2_MN908947_2022-06-14T12_00_00Z.tar.gz"
                }
            ],
            "steps": [
                {
                    "in": [
                        {
                            "source": "#main/ANNOTATION_GFF_GZ_URL",
                            "id": "#main/get_annotation_gff/gzip_url"
                        }
                    ],
                    "out": [
                        "#main/get_annotation_gff/gff"
                    ],
                    "run": {
                        "class": "CommandLineTool",
                        "requirements": [
                            {
                                "class": "ShellCommandRequirement"
                            }
                        ],
                        "arguments": [
                            {
                                "valueFrom": "curl -s -L --output - $(inputs.gzip_url) | gunzip",
                                "shellQuote": false
                            }
                        ],
                        "inputs": [
                            {
                                "type": "string",
                                "id": "#main/get_annotation_gff/3a453825-eb7c-4dbf-9d55-c9cfe3d48910/gzip_url"
                            },
                            {
                                "type": "string",
                                "default": "annotation.gff",
                                "id": "#main/get_annotation_gff/3a453825-eb7c-4dbf-9d55-c9cfe3d48910/output_name"
                            }
                        ],
                        "outputs": [
                            {
                                "id": "#main/get_annotation_gff/3a453825-eb7c-4dbf-9d55-c9cfe3d48910/gff",
                                "type": "File",
                                "outputBinding": {
                                    "glob": "$(inputs.output_name)"
                                }
                            }
                        ],
                        "stdout": "$(inputs.output_name)",
                        "id": "#main/get_annotation_gff/3a453825-eb7c-4dbf-9d55-c9cfe3d48910"
                    },
                    "id": "#main/get_annotation_gff"
                },
                {
                    "in": [
                        {
                            "source": "#main/NEXTCLADE_TARBALL_URL",
                            "id": "#main/get_nextclade_dataset/url"
                        }
                    ],
                    "out": [
                        "#main/get_nextclade_dataset/dataset"
                    ],
                    "run": {
                        "class": "CommandLineTool",
                        "requirements": [
                            {
                                "class": "ShellCommandRequirement"
                            }
                        ],
                        "arguments": [
                            {
                                "valueFrom": "curl -s -L --output - $(inputs.url) | tar x",
                                "shellQuote": false
                            }
                        ],
                        "inputs": [
                            {
                                "type": "string",
                                "id": "#main/get_nextclade_dataset/05d11223-525b-4759-9c79-50c00ff92de1/url"
                            }
                        ],
                        "outputs": [
                            {
                                "id": "#main/get_nextclade_dataset/05d11223-525b-4759-9c79-50c00ff92de1/dataset",
                                "type": "Directory",
                                "outputBinding": {
                                    "glob": "nextclade_*"
                                }
                            }
                        ],
                        "id": "#main/get_nextclade_dataset/05d11223-525b-4759-9c79-50c00ff92de1"
                    },
                    "id": "#main/get_nextclade_dataset"
                },
                {
                    "in": [],
                    "out": [
                        "#main/get_primer_scheme/scheme_dir"
                    ],
                    "run": {
                        "class": "CommandLineTool",
                        "arguments": [
                            "git",
                            "clone",
                            "--depth=1",
                            "$(inputs.url)"
                        ],
                        "inputs": [
                            {
                                "type": "string",
                                "default": "https://github.com/artic-network/artic-ncov2019",
                                "id": "#main/get_primer_scheme/a6f52aa1-8f64-46ad-a972-13cc151d446a/url"
                            }
                        ],
                        "outputs": [
                            {
                                "id": "#main/get_primer_scheme/a6f52aa1-8f64-46ad-a972-13cc151d446a/scheme_dir",
                                "type": "Directory",
                                "outputBinding": {
                                    "glob": "artic-ncov2019/primer_schemes"
                                }
                            }
                        ],
                        "id": "#main/get_primer_scheme/a6f52aa1-8f64-46ad-a972-13cc151d446a"
                    },
                    "id": "#main/get_primer_scheme"
                },
                {
                    "in": [
                        {
                            "source": "#main/REFERENCE_FASTA_URL",
                            "id": "#main/get_reference_fasta/url"
                        }
                    ],
                    "out": [
                        "#main/get_reference_fasta/fasta"
                    ],
                    "run": {
                        "class": "CommandLineTool",
                        "arguments": [
                            "curl",
                            "-s",
                            "-L",
                            "-o",
                            "reference.fasta",
                            "$(inputs.url)"
                        ],
                        "inputs": [
                            {
                                "type": "string",
                                "id": "#main/get_reference_fasta/58a8b88e-3c0d-4be2-9bc8-54d935cb4526/url"
                            }
                        ],
                        "outputs": [
                            {
                                "id": "#main/get_reference_fasta/58a8b88e-3c0d-4be2-9bc8-54d935cb4526/fasta",
                                "type": "File",
                                "outputBinding": {
                                    "glob": "reference.fasta"
                                }
                            }
                        ],
                        "id": "#main/get_reference_fasta/58a8b88e-3c0d-4be2-9bc8-54d935cb4526"
                    },
                    "id": "#main/get_reference_fasta"
                },
                {
                    "run": "#quast.cwl",
                    "in": [
                        {
                            "source": [
                                "#main/viralrecon/consensus_fasta"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/quast/input_files"
                        },
                        {
                            "source": "#main/get_annotation_gff/gff",
                            "id": "#main/quast/reference_feature_gff"
                        },
                        {
                            "source": "#main/get_reference_fasta/fasta",
                            "id": "#main/quast/reference_genome_fasta"
                        }
                    ],
                    "out": [
                        "#main/quast/quast_dir"
                    ],
                    "id": "#main/quast"
                },
                {
                    "run": "#snpeff.build.cwl",
                    "in": [
                        {
                            "source": "#main/GENOME_VERSION",
                            "id": "#main/snpeff.build/genome_version"
                        },
                        {
                            "source": "#main/get_annotation_gff/gff",
                            "id": "#main/snpeff.build/input_gff"
                        },
                        {
                            "source": "#main/get_reference_fasta/fasta",
                            "id": "#main/snpeff.build/reference_fasta"
                        }
                    ],
                    "out": [
                        "#main/snpeff.build/all-for-debugging",
                        "#main/snpeff.build/config",
                        "#main/snpeff.build/datadir"
                    ],
                    "id": "#main/snpeff.build"
                },
                {
                    "run": "#viralrecon.nanopore.single.cwl",
                    "scatter": [
                        "#main/viralrecon/SAMPLE_NAME",
                        "#main/viralrecon/BARCODE_NAME"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "source": "#main/LIST_BARCODE_NAME",
                            "id": "#main/viralrecon/BARCODE_NAME"
                        },
                        {
                            "source": "#main/FAST5_DIRECTORY",
                            "id": "#main/viralrecon/FAST5_DIRECTORY"
                        },
                        {
                            "source": "#main/FASTQ_DIRECTORY",
                            "id": "#main/viralrecon/FASTQ_DIRECTORY"
                        },
                        {
                            "source": "#main/get_nextclade_dataset/dataset",
                            "id": "#main/viralrecon/NEXTCLADE_DATASET"
                        },
                        {
                            "source": "#main/LIST_SAMPLE_NAME",
                            "id": "#main/viralrecon/SAMPLE_NAME"
                        },
                        {
                            "source": "#main/get_primer_scheme/scheme_dir",
                            "id": "#main/viralrecon/SCHEME_DIRECTORY"
                        },
                        {
                            "source": "#main/SEQUENCING_SUMMARY",
                            "id": "#main/viralrecon/SEQUENCING_SUMMARY"
                        },
                        {
                            "source": "#main/snpeff.build/config",
                            "id": "#main/viralrecon/SNPEFF_CONFIG"
                        },
                        {
                            "source": "#main/snpeff.build/datadir",
                            "id": "#main/viralrecon/SNPEFF_DATADIR"
                        }
                    ],
                    "out": [
                        "#main/viralrecon/consensus_fasta",
                        "#main/viralrecon/nanoplot.all",
                        "#main/viralrecon/mosdepth.amplicon.all",
                        "#main/viralrecon/mosdepth.genome.all",
                        "#main/viralrecon/bcftoos.stats.txt",
                        "#main/viralrecon/snpsift.out",
                        "#main/viralrecon/pangolin.csv",
                        "#main/viralrecon/nextclade.out"
                    ],
                    "id": "#main/viralrecon"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#main/viralrecon/bcftoos.stats.txt",
                    "id": "#main/bcftoos.stats.txt"
                },
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "array",
                            "items": [
                                "File",
                                "Directory"
                            ]
                        }
                    },
                    "outputSource": "#main/viralrecon/mosdepth.amplicon.all",
                    "id": "#main/mosdepth.amplicon.all"
                },
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "array",
                            "items": [
                                "File",
                                "Directory"
                            ]
                        }
                    },
                    "outputSource": "#main/viralrecon/mosdepth.genome.all",
                    "id": "#main/mosdepth.genome.all"
                },
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "array",
                            "items": [
                                "File",
                                "Directory"
                            ]
                        }
                    },
                    "outputSource": "#main/viralrecon/nanoplot.all",
                    "id": "#main/nanoplot.all"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "Directory"
                    },
                    "outputSource": "#main/viralrecon/nextclade.out",
                    "id": "#main/nextclade.out"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#main/viralrecon/pangolin.csv",
                    "id": "#main/pangolin.csv"
                },
                {
                    "type": "Directory",
                    "outputSource": "#main/quast/quast_dir",
                    "id": "#main/quast.dir"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#main/viralrecon/snpsift.out",
                    "id": "#main/snpsift.out"
                }
            ],
            "id": "#main"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "StepInputExpressionRequirement"
                }
            ],
            "inputs": [
                {
                    "id": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                    "type": "string"
                },
                {
                    "id": "#viralrecon.nanopore.single.cwl/BARCODE_NAME",
                    "type": "string"
                },
                {
                    "id": "#viralrecon.nanopore.single.cwl/FASTQ_DIRECTORY",
                    "type": "Directory"
                },
                {
                    "id": "#viralrecon.nanopore.single.cwl/SCHEME_DIRECTORY",
                    "type": "Directory"
                },
                {
                    "id": "#viralrecon.nanopore.single.cwl/FAST5_DIRECTORY",
                    "type": "Directory"
                },
                {
                    "id": "#viralrecon.nanopore.single.cwl/SEQUENCING_SUMMARY",
                    "type": "File"
                },
                {
                    "id": "#viralrecon.nanopore.single.cwl/REFERENCE_GENOME_PREFIX",
                    "type": "string",
                    "default": "nCoV-2019"
                },
                {
                    "id": "#viralrecon.nanopore.single.cwl/SNPEFF_CONFIG",
                    "type": "File"
                },
                {
                    "id": "#viralrecon.nanopore.single.cwl/SNPEFF_DATADIR",
                    "type": "Directory"
                },
                {
                    "id": "#viralrecon.nanopore.single.cwl/NEXTCLADE_DATASET",
                    "type": "Directory"
                }
            ],
            "steps": [
                {
                    "run": "#artic.guppyplex.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/BARCODE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/artic.guppyplex/barcode_name"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/FASTQ_DIRECTORY",
                            "id": "#viralrecon.nanopore.single.cwl/artic.guppyplex/input_directory"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/artic.guppyplex/sample_name"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/artic.guppyplex/fastq"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/artic.guppyplex"
                },
                {
                    "run": "#artic.minion.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/FAST5_DIRECTORY",
                            "id": "#viralrecon.nanopore.single.cwl/artic.minion/fast5_directory"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/pigz/fastq_gz",
                            "id": "#viralrecon.nanopore.single.cwl/artic.minion/read_file"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/artic.minion/sample_name"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SCHEME_DIRECTORY",
                            "id": "#viralrecon.nanopore.single.cwl/artic.minion/scheme_directory"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SEQUENCING_SUMMARY",
                            "id": "#viralrecon.nanopore.single.cwl/artic.minion/sequencing_summary"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/artic.minion/sorted_bam",
                        "#viralrecon.nanopore.single.cwl/artic.minion/primertrimmed_sorted_bam",
                        "#viralrecon.nanopore.single.cwl/artic.minion/pass_vcf",
                        "#viralrecon.nanopore.single.cwl/artic.minion/consensus_fasta",
                        "#viralrecon.nanopore.single.cwl/artic.minion/all-for-debugging"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/artic.minion"
                },
                {
                    "run": "#bcftools.stats.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/to_vcf_with_index/vcf_with_index",
                            "id": "#viralrecon.nanopore.single.cwl/bcftools.stats/input_vcf"
                        },
                        {
                            "valueFrom": "$(inputs.sample_name).bcftools_stats.txt",
                            "id": "#viralrecon.nanopore.single.cwl/bcftools.stats/output_name"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/bcftools.stats/sample_name"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/bcftools.stats/out"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/bcftools.stats"
                },
                {
                    "run": "#collapse_primer_bed.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/extract_primer_bed/primer_bed",
                            "id": "#viralrecon.nanopore.single.cwl/collapse_primer_bed/input_bed"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/collapse_primer_bed/collapsed_bed"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/collapse_primer_bed"
                },
                {
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SCHEME_DIRECTORY",
                            "id": "#viralrecon.nanopore.single.cwl/extract_primer_bed/dir"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/REFERENCE_GENOME_PREFIX",
                            "id": "#viralrecon.nanopore.single.cwl/extract_primer_bed/prefix"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/extract_primer_bed/primer_bed"
                    ],
                    "run": {
                        "class": "CommandLineTool",
                        "baseCommand": "true",
                        "requirements": [
                            {
                                "listing": [
                                    {
                                        "entry": "$(inputs.dir)"
                                    }
                                ],
                                "class": "InitialWorkDirRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": "Directory",
                                "id": "#viralrecon.nanopore.single.cwl/extract_primer_bed/00a73591-4533-4b51-80ce-3e518df8627d/dir"
                            },
                            {
                                "type": "string",
                                "id": "#viralrecon.nanopore.single.cwl/extract_primer_bed/00a73591-4533-4b51-80ce-3e518df8627d/prefix"
                            },
                            {
                                "type": "string",
                                "default": "V3",
                                "id": "#viralrecon.nanopore.single.cwl/extract_primer_bed/00a73591-4533-4b51-80ce-3e518df8627d/version"
                            }
                        ],
                        "outputs": [
                            {
                                "id": "#viralrecon.nanopore.single.cwl/extract_primer_bed/00a73591-4533-4b51-80ce-3e518df8627d/primer_bed",
                                "type": "File",
                                "outputBinding": {
                                    "glob": "$(inputs.dir.path)/$(inputs.prefix)/$(inputs.version)/nCoV-2019.primer.bed"
                                }
                            }
                        ],
                        "id": "#viralrecon.nanopore.single.cwl/extract_primer_bed/00a73591-4533-4b51-80ce-3e518df8627d"
                    },
                    "id": "#viralrecon.nanopore.single.cwl/extract_primer_bed"
                },
                {
                    "run": "#mosdepth.amplicon.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/collapse_primer_bed/collapsed_bed",
                            "id": "#viralrecon.nanopore.single.cwl/mosdepth.amplicon/by"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/artic.minion/primertrimmed_sorted_bam",
                            "id": "#viralrecon.nanopore.single.cwl/mosdepth.amplicon/input_bam"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/mosdepth.amplicon/input_label"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/mosdepth.amplicon/all"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/mosdepth.amplicon"
                },
                {
                    "run": "#mosdepth.genome.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/artic.minion/primertrimmed_sorted_bam",
                            "id": "#viralrecon.nanopore.single.cwl/mosdepth.genome/input_bam"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/mosdepth.genome/sample_name"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/mosdepth.genome/all"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/mosdepth.genome"
                },
                {
                    "run": "#nanoplot.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/pigz/fastq_gz",
                            "id": "#viralrecon.nanopore.single.cwl/nanoplot/input_fastq"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/nanoplot/all"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/nanoplot"
                },
                {
                    "run": "#nextclade.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/artic.minion/consensus_fasta",
                            "id": "#viralrecon.nanopore.single.cwl/nextclade/consensus_fasta"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/NEXTCLADE_DATASET",
                            "id": "#viralrecon.nanopore.single.cwl/nextclade/input_dataset"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/nextclade/output_basename"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/nextclade/out"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/nextclade"
                },
                {
                    "run": "#pangolin.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/artic.minion/consensus_fasta",
                            "id": "#viralrecon.nanopore.single.cwl/pangolin/consensus_fasta"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/pangolin/outfile_name"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/pangolin/csv"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/pangolin"
                },
                {
                    "run": "#pigz.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/artic.guppyplex/fastq",
                            "id": "#viralrecon.nanopore.single.cwl/pigz/input_fastq"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/pigz/fastq_gz"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/pigz"
                },
                {
                    "run": "#samtools.view.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/artic.minion/sorted_bam",
                            "id": "#viralrecon.nanopore.single.cwl/samtools.view/input_bam"
                        },
                        {
                            "valueFrom": "$(inputs.sample_name).mapped.sorted.bam",
                            "id": "#viralrecon.nanopore.single.cwl/samtools.view/output_name"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/samtools.view/sample_name"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/samtools.view/mapped_bam"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/samtools.view"
                },
                {
                    "run": "#snpeff.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SNPEFF_CONFIG",
                            "id": "#viralrecon.nanopore.single.cwl/snpeff/config"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SNPEFF_DATADIR",
                            "id": "#viralrecon.nanopore.single.cwl/snpeff/dataDir"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/vcfuniq/uniq_vcf",
                            "id": "#viralrecon.nanopore.single.cwl/snpeff/input_vcf"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/REFERENCE_GENOME_PREFIX",
                            "id": "#viralrecon.nanopore.single.cwl/snpeff/reference_name"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/snpeff/sample_name"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/snpeff/vcf"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/snpeff"
                },
                {
                    "run": "#snpsift.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/snpeff/vcf",
                            "id": "#viralrecon.nanopore.single.cwl/snpsift/input_vcf"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/snpsift/sample_name"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/snpsift/out"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/snpsift"
                },
                {
                    "run": "#tabix.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/vcfuniq/uniq_vcf",
                            "id": "#viralrecon.nanopore.single.cwl/tabix/input_file"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/tabix/index"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/tabix"
                },
                {
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/tabix/index",
                            "id": "#viralrecon.nanopore.single.cwl/to_vcf_with_index/index"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/vcfuniq/uniq_vcf",
                            "id": "#viralrecon.nanopore.single.cwl/to_vcf_with_index/vcf"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/to_vcf_with_index/vcf_with_index"
                    ],
                    "run": {
                        "class": "CommandLineTool",
                        "requirements": [
                            {
                                "listing": [
                                    {
                                        "entry": "$(inputs.vcf)"
                                    },
                                    {
                                        "entry": "$(inputs.index)"
                                    }
                                ],
                                "class": "InitialWorkDirRequirement"
                            }
                        ],
                        "baseCommand": "true",
                        "inputs": [
                            {
                                "type": "File",
                                "id": "#viralrecon.nanopore.single.cwl/to_vcf_with_index/67efc14e-ef35-440f-bfa6-c90863b0b752/index"
                            },
                            {
                                "type": "File",
                                "id": "#viralrecon.nanopore.single.cwl/to_vcf_with_index/67efc14e-ef35-440f-bfa6-c90863b0b752/vcf"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "outputBinding": {
                                    "glob": "$(inputs.vcf.basename)"
                                },
                                "secondaryFiles": [
                                    ".tbi"
                                ],
                                "id": "#viralrecon.nanopore.single.cwl/to_vcf_with_index/67efc14e-ef35-440f-bfa6-c90863b0b752/vcf_with_index"
                            }
                        ],
                        "id": "#viralrecon.nanopore.single.cwl/to_vcf_with_index/67efc14e-ef35-440f-bfa6-c90863b0b752"
                    },
                    "id": "#viralrecon.nanopore.single.cwl/to_vcf_with_index"
                },
                {
                    "run": "#vcfuniq.cwl",
                    "in": [
                        {
                            "source": "#viralrecon.nanopore.single.cwl/artic.minion/pass_vcf",
                            "id": "#viralrecon.nanopore.single.cwl/vcfuniq/input_vcf"
                        },
                        {
                            "source": "#viralrecon.nanopore.single.cwl/SAMPLE_NAME",
                            "id": "#viralrecon.nanopore.single.cwl/vcfuniq/sample_name"
                        }
                    ],
                    "out": [
                        "#viralrecon.nanopore.single.cwl/vcfuniq/uniq_vcf"
                    ],
                    "id": "#viralrecon.nanopore.single.cwl/vcfuniq"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputSource": "#viralrecon.nanopore.single.cwl/bcftools.stats/out",
                    "id": "#viralrecon.nanopore.single.cwl/bcftoos.stats.txt"
                },
                {
                    "type": "File",
                    "outputSource": "#viralrecon.nanopore.single.cwl/artic.minion/consensus_fasta",
                    "id": "#viralrecon.nanopore.single.cwl/consensus_fasta"
                },
                {
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputSource": "#viralrecon.nanopore.single.cwl/mosdepth.amplicon/all",
                    "id": "#viralrecon.nanopore.single.cwl/mosdepth.amplicon.all"
                },
                {
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputSource": "#viralrecon.nanopore.single.cwl/mosdepth.genome/all",
                    "id": "#viralrecon.nanopore.single.cwl/mosdepth.genome.all"
                },
                {
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputSource": "#viralrecon.nanopore.single.cwl/nanoplot/all",
                    "id": "#viralrecon.nanopore.single.cwl/nanoplot.all"
                },
                {
                    "type": "Directory",
                    "outputSource": "#viralrecon.nanopore.single.cwl/nextclade/out",
                    "id": "#viralrecon.nanopore.single.cwl/nextclade.out"
                },
                {
                    "type": "File",
                    "outputSource": "#viralrecon.nanopore.single.cwl/pangolin/csv",
                    "id": "#viralrecon.nanopore.single.cwl/pangolin.csv"
                },
                {
                    "type": "File",
                    "outputSource": "#viralrecon.nanopore.single.cwl/snpsift/out",
                    "id": "#viralrecon.nanopore.single.cwl/snpsift.out"
                }
            ],
            "id": "#viralrecon.nanopore.single.cwl"
        }
    ],
    "cwlVersion": "v1.0"
}
