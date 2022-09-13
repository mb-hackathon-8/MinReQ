rule all:
  input:

rule assemble:
  input:
    R1 = "",
    R2 = "",
  output:
    "skesa_out/{sample}.fasta"
  params:
  conda:
  message:
    "Running XXX on sample {}
  log:
    "logs/assemble/{sample}.log"
  
  shell:

rule mlst:
  input:
    "skesa_out/{sample}.fasta"
  output:
    "mlst_out/{sample}.tsv"
  params:
  conda:
  message:
        "Running mlst on sample {wildcards.sample}"
  log:
    "logs/mlst/{sample}/log"
  threads: 1
  shell:
    """
    mlst {input} > {output} 2>{log}
    """

rule quast:
  input:
    assembly = "skesa_out/{sample}.fasta",
    reference = "input/assembly/{sample}_genomic.fna",
  output:
    directory("quast_out/{sample}")
  params:
  conda:
  message:
    "Running quast on sample {wildcards.sample}"
  threads: 1
  shell:
    """
    quast.py -r {input.reference} -o {output} {input.assembly} 2>{log}
    """

rule amr: ### steal from https://github.com/pha4ge/hAMRonization_workflow/tree/master/rules
  input:
  output:
  params:
  conda:
  message:
    "Running XXX on sample {}
  shell:

