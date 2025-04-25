import os
import glob

def get_r1(sample, fastq_dir):
    return os.path.join(fastq_dir, f"{sample}_L001_R1_001.fastq.gz")

def get_r2(sample, fastq_dir):
    return os.path.join(fastq_dir, f"{sample}_L001_R2_001.fastq.gz")

def get_bam(sample, output_dir):
    return os.path.join(output_dir, f"{sample}_sorted.bam")

def get_bai(sample, output_dir):
    return os.path.join(output_dir, f"{sample}_sorted.bam.bai")

def get_rg_bam(sample, output_dir):
    return os.path.join(output_dir, f"{sample}_sorted_rg.bam")

def get_rg_bai(sample, output_dir):
    return os.path.join(output_dir, f"{sample}_sorted_rg.bam.bai")

def get_vcf(sample, vcf_dir):
    return os.path.join(vcf_dir, f"{sample}.vcf.gz")

def get_filtered_vcf(sample, vcf_dir):
    return os.path.join(vcf_dir, f"{sample}_filtered.vcf.gz")

def get_avinput(sample, vcf_dir):
    return os.path.join(vcf_dir, f"{sample}.avinput")

def get_annovar_out(sample, vcf_dir):
    return os.path.join(vcf_dir, f"{sample}_annotated")

def get_gvcf(sample, vcf_dir):
    return os.path.join(vcf_dir, f"{sample}.g.vcf.gz")

def discover_samples(fastq_dir):
    r1_files = glob.glob(os.path.join(fastq_dir, "*_S*_L001_R1_001.fastq.gz"))
    samples = [os.path.basename(f).replace("_L001_R1_001.fastq.gz", "") for f in r1_files]
    return samples
