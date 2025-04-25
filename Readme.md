# BWS Snakemake Workflow

This Snakemake workflow automates a bioinformatics pipeline for variant calling from FASTQ files using tools such as BWA, SAMtools, GATK, and ANNOVAR.

## 📁 Workflow Structure

The pipeline includes the following major steps:

1. **BWA Indexing** – Creates index files for the reference genome.
2. **Read Alignment (BWA-MEM)** – Aligns FASTQ reads to the reference.
3. **SAM to BAM Conversion** – Converts SAM to BAM using SAMtools.
4. **BAM Sorting** – Sorts BAM files.
5. **BAM Indexing** – Indexes sorted BAMs.
6. **GATK Quality Control** – Performs quality control.
7. **Add Read Groups** – Adds metadata to BAM files.
8. **Variant Calling** – Calls variants using GATK.
9. **Annotation (ANNOVAR)** – Annotates variants using ANNOVAR.

## 📦 Dependencies

This workflow is designed to be portable using [conda environments](https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html#integrated-package-management).

Each rule can be optionally paired with a corresponding conda environment file in `envs/`.

To use conda integration:
```bash
snakemake --use-conda
```

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/Freeman-kuc/BWS_Snakemake.git
cd BWS_Snakemake
```

### 2. Configure your paths

Edit the `config/config.yaml` file:
```yaml
fastq_dir: "data/fastq/"
reference: "data/reference/hg38.fasta"
samples: ["sample1", "sample2"]
```

### 3. Run the workflow

To execute the full pipeline:
```bash
snakemake --cores 4 --use-conda
```

For dry-run:
```bash
snakemake -n
```

To visualize the DAG:
```bash
snakemake --dag | dot -Tpdf > workflow_dag.pdf
```

## 🧪 Directory Layout

```
.
├── Snakefile
├── rules/
│   └── common.smk
├── config.yaml
├── data/
├── results/
```

## 🔍 Linting and Best Practices

The workflow includes:
- Modular rules via `rules/`
- Log files for better error tracing
- Optional conda environments for reproducibility

## 📜 License

[MIT License](LICENSE)

## ✨ Acknowledgments

Inspired by Snakemake best practices and typical variant calling pipelines using BWA and GATK.

---

For questions or contributions, feel free to open an issue or pull request.