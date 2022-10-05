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
                    "class": "StepInputExpressionRequirement"
                }
            ],
            "inputs": [
                {
                    "id": "#main/SAMPLE_NAME",
                    "type": "string"
                },
                {
                    "id": "#main/BARCODE_NAME",
                    "type": "string"
                },
                {
                    "id": "#main/FASTQ_DIRECTORY",
                    "type": "Directory"
                },
                {
                    "id": "#main/SCHEME_DIRECTORY",
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
                    "id": "#main/REFERENCE_GENOME_PREFIX",
                    "type": "string",
                    "default": "nCoV-2019"
                },
                {
                    "id": "#main/SNPEFF_CONFIG",
                    "type": "File"
                },
                {
                    "id": "#main/SNPEFF_DATADIR",
                    "type": "Directory"
                },
                {
                    "id": "#main/NEXTCLADE_DATASET",
                    "type": "Directory"
                }
            ],
            "steps": [
                {
                    "run": "#artic.guppyplex.cwl",
                    "in": [
                        {
                            "source": "#main/BARCODE_NAME",
                            "id": "#main/artic.guppyplex/barcode_name"
                        },
                        {
                            "source": "#main/FASTQ_DIRECTORY",
                            "id": "#main/artic.guppyplex/input_directory"
                        },
                        {
                            "source": "#main/SAMPLE_NAME",
                            "id": "#main/artic.guppyplex/sample_name"
                        }
                    ],
                    "out": [
                        "#main/artic.guppyplex/fastq"
                    ],
                    "id": "#main/artic.guppyplex"
                },
                {
                    "run": "#artic.minion.cwl",
                    "in": [
                        {
                            "source": "#main/FAST5_DIRECTORY",
                            "id": "#main/artic.minion/fast5_directory"
                        },
                        {
                            "source": "#main/pigz/fastq_gz",
                            "id": "#main/artic.minion/read_file"
                        },
                        {
                            "source": "#main/SAMPLE_NAME",
                            "id": "#main/artic.minion/sample_name"
                        },
                        {
                            "source": "#main/SCHEME_DIRECTORY",
                            "id": "#main/artic.minion/scheme_directory"
                        },
                        {
                            "source": "#main/SEQUENCING_SUMMARY",
                            "id": "#main/artic.minion/sequencing_summary"
                        }
                    ],
                    "out": [
                        "#main/artic.minion/sorted_bam",
                        "#main/artic.minion/primertrimmed_sorted_bam",
                        "#main/artic.minion/pass_vcf",
                        "#main/artic.minion/consensus_fasta",
                        "#main/artic.minion/all-for-debugging"
                    ],
                    "id": "#main/artic.minion"
                },
                {
                    "run": "#bcftools.stats.cwl",
                    "in": [
                        {
                            "source": "#main/to_vcf_with_index/vcf_with_index",
                            "id": "#main/bcftools.stats/input_vcf"
                        },
                        {
                            "valueFrom": "$(inputs.sample_name).bcftools_stats.txt",
                            "id": "#main/bcftools.stats/output_name"
                        },
                        {
                            "source": "#main/SAMPLE_NAME",
                            "id": "#main/bcftools.stats/sample_name"
                        }
                    ],
                    "out": [
                        "#main/bcftools.stats/out"
                    ],
                    "id": "#main/bcftools.stats"
                },
                {
                    "run": "#collapse_primer_bed.cwl",
                    "in": [
                        {
                            "source": "#main/extract_primer_bed/primer_bed",
                            "id": "#main/collapse_primer_bed/input_bed"
                        }
                    ],
                    "out": [
                        "#main/collapse_primer_bed/collapsed_bed"
                    ],
                    "id": "#main/collapse_primer_bed"
                },
                {
                    "in": [
                        {
                            "source": "#main/SCHEME_DIRECTORY",
                            "id": "#main/extract_primer_bed/dir"
                        },
                        {
                            "source": "#main/REFERENCE_GENOME_PREFIX",
                            "id": "#main/extract_primer_bed/prefix"
                        }
                    ],
                    "out": [
                        "#main/extract_primer_bed/primer_bed"
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
                                "id": "#main/extract_primer_bed/92783747-885b-4b39-8dac-ef4db4a4a35c/dir"
                            },
                            {
                                "type": "string",
                                "id": "#main/extract_primer_bed/92783747-885b-4b39-8dac-ef4db4a4a35c/prefix"
                            },
                            {
                                "type": "string",
                                "default": "V3",
                                "id": "#main/extract_primer_bed/92783747-885b-4b39-8dac-ef4db4a4a35c/version"
                            }
                        ],
                        "outputs": [
                            {
                                "id": "#main/extract_primer_bed/92783747-885b-4b39-8dac-ef4db4a4a35c/primer_bed",
                                "type": "File",
                                "outputBinding": {
                                    "glob": "$(inputs.dir.path)/$(inputs.prefix)/$(inputs.version)/nCoV-2019.primer.bed"
                                }
                            }
                        ],
                        "id": "#main/extract_primer_bed/92783747-885b-4b39-8dac-ef4db4a4a35c"
                    },
                    "id": "#main/extract_primer_bed"
                },
                {
                    "run": "#mosdepth.amplicon.cwl",
                    "in": [
                        {
                            "source": "#main/collapse_primer_bed/collapsed_bed",
                            "id": "#main/mosdepth.amplicon/by"
                        },
                        {
                            "source": "#main/artic.minion/primertrimmed_sorted_bam",
                            "id": "#main/mosdepth.amplicon/input_bam"
                        },
                        {
                            "source": "#main/SAMPLE_NAME",
                            "id": "#main/mosdepth.amplicon/input_label"
                        }
                    ],
                    "out": [
                        "#main/mosdepth.amplicon/all"
                    ],
                    "id": "#main/mosdepth.amplicon"
                },
                {
                    "run": "#mosdepth.genome.cwl",
                    "in": [
                        {
                            "source": "#main/artic.minion/primertrimmed_sorted_bam",
                            "id": "#main/mosdepth.genome/input_bam"
                        },
                        {
                            "source": "#main/SAMPLE_NAME",
                            "id": "#main/mosdepth.genome/sample_name"
                        }
                    ],
                    "out": [
                        "#main/mosdepth.genome/all"
                    ],
                    "id": "#main/mosdepth.genome"
                },
                {
                    "run": "#nanoplot.cwl",
                    "in": [
                        {
                            "source": "#main/pigz/fastq_gz",
                            "id": "#main/nanoplot/input_fastq"
                        }
                    ],
                    "out": [
                        "#main/nanoplot/all"
                    ],
                    "id": "#main/nanoplot"
                },
                {
                    "run": "#nextclade.cwl",
                    "in": [
                        {
                            "source": "#main/artic.minion/consensus_fasta",
                            "id": "#main/nextclade/consensus_fasta"
                        },
                        {
                            "source": "#main/NEXTCLADE_DATASET",
                            "id": "#main/nextclade/input_dataset"
                        },
                        {
                            "source": "#main/SAMPLE_NAME",
                            "id": "#main/nextclade/output_basename"
                        }
                    ],
                    "out": [
                        "#main/nextclade/out"
                    ],
                    "id": "#main/nextclade"
                },
                {
                    "run": "#pangolin.cwl",
                    "in": [
                        {
                            "source": "#main/artic.minion/consensus_fasta",
                            "id": "#main/pangolin/consensus_fasta"
                        },
                        {
                            "source": "#main/SAMPLE_NAME",
                            "id": "#main/pangolin/outfile_name"
                        }
                    ],
                    "out": [
                        "#main/pangolin/csv"
                    ],
                    "id": "#main/pangolin"
                },
                {
                    "run": "#pigz.cwl",
                    "in": [
                        {
                            "source": "#main/artic.guppyplex/fastq",
                            "id": "#main/pigz/input_fastq"
                        }
                    ],
                    "out": [
                        "#main/pigz/fastq_gz"
                    ],
                    "id": "#main/pigz"
                },
                {
                    "run": "#samtools.view.cwl",
                    "in": [
                        {
                            "source": "#main/artic.minion/sorted_bam",
                            "id": "#main/samtools.view/input_bam"
                        },
                        {
                            "valueFrom": "$(inputs.sample_name).mapped.sorted.bam",
                            "id": "#main/samtools.view/output_name"
                        },
                        {
                            "source": "#main/SAMPLE_NAME",
                            "id": "#main/samtools.view/sample_name"
                        }
                    ],
                    "out": [
                        "#main/samtools.view/mapped_bam"
                    ],
                    "id": "#main/samtools.view"
                },
                {
                    "run": "#snpeff.cwl",
                    "in": [
                        {
                            "source": "#main/SNPEFF_CONFIG",
                            "id": "#main/snpeff/config"
                        },
                        {
                            "source": "#main/SNPEFF_DATADIR",
                            "id": "#main/snpeff/dataDir"
                        },
                        {
                            "source": "#main/vcfuniq/uniq_vcf",
                            "id": "#main/snpeff/input_vcf"
                        },
                        {
                            "source": "#main/REFERENCE_GENOME_PREFIX",
                            "id": "#main/snpeff/reference_name"
                        },
                        {
                            "source": "#main/SAMPLE_NAME",
                            "id": "#main/snpeff/sample_name"
                        }
                    ],
                    "out": [
                        "#main/snpeff/vcf"
                    ],
                    "id": "#main/snpeff"
                },
                {
                    "run": "#snpsift.cwl",
                    "in": [
                        {
                            "source": "#main/snpeff/vcf",
                            "id": "#main/snpsift/input_vcf"
                        },
                        {
                            "source": "#main/SAMPLE_NAME",
                            "id": "#main/snpsift/sample_name"
                        }
                    ],
                    "out": [
                        "#main/snpsift/out"
                    ],
                    "id": "#main/snpsift"
                },
                {
                    "run": "#tabix.cwl",
                    "in": [
                        {
                            "source": "#main/vcfuniq/uniq_vcf",
                            "id": "#main/tabix/input_file"
                        }
                    ],
                    "out": [
                        "#main/tabix/index"
                    ],
                    "id": "#main/tabix"
                },
                {
                    "in": [
                        {
                            "source": "#main/tabix/index",
                            "id": "#main/to_vcf_with_index/index"
                        },
                        {
                            "source": "#main/vcfuniq/uniq_vcf",
                            "id": "#main/to_vcf_with_index/vcf"
                        }
                    ],
                    "out": [
                        "#main/to_vcf_with_index/vcf_with_index"
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
                                "id": "#main/to_vcf_with_index/c5649067-8c91-434c-9701-f33dd9af09a3/index"
                            },
                            {
                                "type": "File",
                                "id": "#main/to_vcf_with_index/c5649067-8c91-434c-9701-f33dd9af09a3/vcf"
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
                                "id": "#main/to_vcf_with_index/c5649067-8c91-434c-9701-f33dd9af09a3/vcf_with_index"
                            }
                        ],
                        "id": "#main/to_vcf_with_index/c5649067-8c91-434c-9701-f33dd9af09a3"
                    },
                    "id": "#main/to_vcf_with_index"
                },
                {
                    "run": "#vcfuniq.cwl",
                    "in": [
                        {
                            "source": "#main/artic.minion/pass_vcf",
                            "id": "#main/vcfuniq/input_vcf"
                        },
                        {
                            "source": "#main/SAMPLE_NAME",
                            "id": "#main/vcfuniq/sample_name"
                        }
                    ],
                    "out": [
                        "#main/vcfuniq/uniq_vcf"
                    ],
                    "id": "#main/vcfuniq"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputSource": "#main/bcftools.stats/out",
                    "id": "#main/bcftoos.stats.txt"
                },
                {
                    "type": "File",
                    "outputSource": "#main/artic.minion/consensus_fasta",
                    "id": "#main/consensus_fasta"
                },
                {
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputSource": "#main/mosdepth.amplicon/all",
                    "id": "#main/mosdepth.amplicon.all"
                },
                {
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputSource": "#main/mosdepth.genome/all",
                    "id": "#main/mosdepth.genome.all"
                },
                {
                    "type": {
                        "type": "array",
                        "items": [
                            "File",
                            "Directory"
                        ]
                    },
                    "outputSource": "#main/nanoplot/all",
                    "id": "#main/nanoplot.all"
                },
                {
                    "type": "Directory",
                    "outputSource": "#main/nextclade/out",
                    "id": "#main/nextclade.out"
                },
                {
                    "type": "File",
                    "outputSource": "#main/pangolin/csv",
                    "id": "#main/pangolin.csv"
                },
                {
                    "type": "File",
                    "outputSource": "#main/snpsift/out",
                    "id": "#main/snpsift.out"
                }
            ],
            "id": "#main"
        }
    ],
    "cwlVersion": "v1.0"
}
