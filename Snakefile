IDS, = glob_wildcards("input/assembly/{sample}_genomic.fna")

rule all:
  input:
#    expand("data/simulated_{cov}_{trimmed}/{sample}_R1.fastq.gz", sample=IDS, cov=['highcov', 'lowcov'], trimmed=['trimmed', 'raw'])
    expand("data/simulated_{trimmed}/{sample}_R1.fastq.gz", sample=IDS, trimmed=['trimmed', 'raw'])

rule simulate_reads:
  input:
    "input/assembly/{sample}_genomic.fna"
  output:
    R1 = "data/simulated_raw/{sample}_R1.fastq.gz",
    R2 = "data/simulated_raw/{sample}_R2.fastq.gz"
  params:
    basename = "data/simulated_raw/{sample}"
  conda:
    "conda_env/insilicoseq.yaml"
  message:
    "Simulating reads for sample {wildcards.sample}"
  log:
    "logs/simulate_reads/{sample}.log"
  shell:
    """
    iss --output {params.basename} 2>{log}
    gzip {params.basename}_R1.fastq {params.basename}_R2.fastq 2>>{log}
    """ 

rule trim:
  input:
    R1 = "data/simulated_raw/{sample}_R1.fastq.gz",
    R2 = "data/simulated_raw/{sample}_R2.fastq.gz",
  output:
    R1 = "data/simulated_trimmed/{sample}_R1.fastq.gz",
    R2 = "data/simulated_trimmed/{sample}_R2.fastq.gz",
  params:
    general = "-e 15 -q 15 -u 40 -n 5 -l 15 -Y 30"
  conda:
    "conda_env/fastp.yaml"
  message:
        "Running fastp on sample {wildcards.sample}"
  log: "logs/trim/{sample}.log"
  shell:
    """
    fastp {params.general} --in1 {input.R1} --in2 {input.R2} --out1 {output.R1} --out2 {output.R2} 2>{log}
    """
    
#rule assemble:
#  input:
#  output:
#  params:
#  conda:
#  message:
#    "Running XXX on sample {}
#  shell:
#    
#rule mlst:
#  input:
#  output:
#  params:
#  conda:
#  message:
#        "Running mlst on sample {}"
#  shell:
#    
#    
#rule amr: ### steal from https://github.com/pha4ge/hAMRonization_workflow/tree/master/rules
#  input:
#  output:
#  params:
#  conda:
#  message:
#    "Running XXX on sample {}
#  shell:
#    
