
---

# BWMS Pipeline with Snakemake

This repository contains a Snakemake workflow for processing next-generation sequencing (NGS) data from raw FASTQ files to annotated VCFs. The pipeline performs alignment, BAM processing, variant calling, filtering, normalization, and annotation using industry-standard bioinformatics tools.

---

## 📁 Project Structure

```
.
workflow
    ├── config.yaml             # Configuration file for paths and tools
    ├── Snakefile               # Main workflow script
    ├── rules/
    │   └── common.smk          # Common functions/utilities used across
├── raw_data/               # Directory containing input FASTQ files
├── results/
│   └── output/             # Output directory for intermediate and final files
├── dependencies/              # Reference genome and bed file
└── README.md               # This documentation file
```

---

## ⚙️ Pipeline Overview

### Input:

* Paired-end FASTQ files
* Reference genome (FASTA + BWA index)
* Target BED file
* Configuration file (`config.yaml`)

### Output:

* BAM (sorted, indexed, with read groups)
* GVCF and VCF (raw and filtered)
* Normalized and annotated VCF
* Annotation tables from ANNOVAR

---

## 🧬 Workflow Steps

### 1. Index Reference (BWA)

Indexes the reference genome using `bwa index`.

```bash
bwa index reference.fa
```

### 2. Align Reads (`bwa mem`)

Aligns paired-end FASTQ files to the reference genome.

```bash
bwa mem reference.fa sample_R1.fastq.gz sample_R2.fastq.gz > sample.sam
```

### 3. Convert SAM to BAM

Converts SAM to BAM using `samtools view`.

### 4. Sort BAM

Sorts BAM by coordinate using `samtools sort`.

### 5. Index BAM

Creates BAM index (`.bai`) using `samtools index`.

### 6. Add Read Groups

Adds read group information using `Picard`.

### 7. Variant Calling

Performs variant calling with `GATK HaplotypeCaller` in GVCF mode.

### 8. Genotype GVCFs

Generates VCF from GVCFs using `GATK GenotypeGVCFs`.

### 9. Filter Variants

Applies quality filters with `GATK VariantFiltration`.

### 10. Normalize VCF

Normalizes variants using `bcftools` and indexes with `tabix`.

### 11. Annotate with ANNOVAR

Converts to Annovar format and annotates variants.

---

## 🔧 Configuration File (`config.yaml`)

Example parameters:

```yaml
fastq_dir: ../raw_data
reference: /path/to/hg19.fa
output_dir: ../results/output
bed: /path/to/targets.bed
picard_path: /path/to/picard.jar
java_dir: /usr/bin/java
annova_dir: /path/to/annovar
db_dir: /path/to/annovar/db
gatk_path: /path/to/gatk
samtools: /path/to/samtools
bcftools: /path/to/bcftools
tabix: /path/to/tabix
bwa: /path/to/bwa
```

---

## 🏁 Running the Pipeline

Run the workflow using:

```bash
snakemake --cores <n_cores> --verbose --printshellcmds
```

Example:

```bash
snakemake --cores 4 --verbose --printshellcmds
```

To clean up intermediate files:

```bash
snakemake clean
```

---

## 🔍 Notes

* `discover_samples()` is used to dynamically identify samples based on FASTQ filenames.
* Custom helper functions (like `get_r1`, `get_bam`, `get_gvcf`, etc.) are defined in `rules/common.smk`.
* Wildcard `{sample}` must match FASTQ filenames for correct execution.
* Ensure all required reference files and databases (BWA index, BED, ANNOVAR db) are present.

---

## 🧪 Example Input Filenames

Expected input FASTQ files should follow the format:

```
sampleName_L001_R1_001.fastq.gz
sampleName_L001_R2_001.fastq.gz
```

Example:

```
44_S44_L001_R1_001.fastq.gz
44_S44_L001_R2_001.fastq.gz
```

---

## 💡 Troubleshooting

* **Exit status 137 / "Killed"**: Indicates the process was terminated (likely due to memory limits). Try reducing the number of threads or increasing available memory.
* **Missing FASTQ files**: The workflow validates sample presence early. Check file naming or `fastq_dir` in `config.yaml`.

