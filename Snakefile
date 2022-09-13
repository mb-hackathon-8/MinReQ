#IDS, = glob_wildcards("input/assembly/{sample}_genomic.fna")

IDS = ['GCF_001022055.1_ASM102205v1', 'GCF_002741155.1_ASM274115v1', 'GCF_016903755.1_ASM1690375v1']



rule all:
  input:
#    rules.trim_lowcov.output,
#    rules.trim_highcov.output,
    expand("data/simulated/{sample}_{trimmed}_{cov}_R1.fastq.gz", sample = IDS, trimmed = ['trimmed', 'raw'], cov = ['highcov', 'lowcov'])


rule simulate_reads:
  input:
    "input/assembly/{sample}_genomic.fna"
  output:
    R1 = "data/simulated/{sample}_raw_highcov_R1.fastq.gz",
    R2 = "data/simulated/{sample}_raw_highcov_R2.fastq.gz"
  params:
    basename = "data/simulated/{sample}_raw_highcov"
  conda:
    "envs/insilicoseq.yaml"
  message:
    "Simulating reads for sample {wildcards.sample}"
  log:
    "logs/simulate_reads/{sample}.log"
  shell:
    """
    NUMBER_READS=$(python scripts/number_reads.py {input}) 
    iss generate --genome {input} --model miseq -n $NUMBER_READS --output {params.basename} 
    gzip {params.basename}_R1.fastq {params.basename}_R2.fastq 2>>{log}
    """ 

rule subsample:
  input:
    R1 = rules.simulate_reads.output.R1,
    R2 = rules.simulate_reads.output.R2,
  output: 
    R1 = "data/simulated/{sample}_raw_lowcov_R1.fastq.gz" ,
    R2 = "data/simulated/{sample}_raw_lowcov_R2.fastq.gz"
  conda:
    "envs/rasusa.yaml"
  threads: 1 
  params: 0.2
  shell: 
    """
    rasusa -i {input.R1} -i {input.R2} --frac {params} -o {output.R1} -o {output.R2}
    """



rule trim_lowcov:
  input:
    R1 = rules.subsample.output.R1,
    R2 = rules.subsample.output.R2 
  output:
    R1 = "data/simulated/{sample}_trimmed_lowcov_R1.fastq.gz",
    R2 = "data/simulated/{sample}_trimmed_lowcov_R2.fastq.gz",
  params:
    general = "-e 15 -q 15 -u 40 -n 5 -l 15 -Y 30"
  conda:
    "envs/fastp.yaml"
  message:
    "Running fastp on sample {wildcards.sample}"
  log: "logs/trim/{sample}.log"
  shell:
    """
    fastp {params.general} --in1 {input.R1} --in2 {input.R2} --out1 {output.R1} --out2 {output.R2} 2>{log}
    """
    

rule trim_highcov:
  input:
    R1 = "data/simulated/{sample}_raw_highcov_R1.fastq.gz",
    R2 = "data/simulated/{sample}_raw_highcov_R2.fastq.gz",
  output:
    R1 = "data/simulated/{sample}_trimmed_highcov_R1.fastq.gz",
    R2 = "data/simulated/{sample}_trimmed_highcov_R2.fastq.gz",
  params:
    general = "-e 15 -q 15 -u 40 -n 5 -l 15 -Y 30"
  conda:
    "envs/fastp.yaml"
  message:
        "Running fastp on sample {wildcards.sample}"
  log: "logs/trim/{sample}.log"
  shell:
    """
    fastp {params.general} --in1 {input.R1} --in2 {input.R2} --out1 {output.R1} --out2 {output.R2} 2>{log}
    """
    
