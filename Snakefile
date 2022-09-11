rule all:
  input: 
    
rule trim_qual:
  input:
  output:
  params:
  conda:
  message:
        "Running quality trimming on sample {}"
  shell:
    
rule trim_adaptors:
  input:
  output:
  params:
  conda:
  message:
        "Running adaptor trimming on sample {}"
  shell:
    
    
rule snippy:
  input:
  output:
  params:
  conda:
  message:
        "Running snippy on sample {}"
  shell:
    
    
rule chewie:
  input:
  output:
  params:
  conda:
  message:
        "Running chewBBACA on sample {}"
  log: "logs/{}_bracken_species.log"
  shell:
    
    
rule trim:
  input:
  output:
  params:
  conda:
  message:
        "Running Fastp on sample {}"
  shell:
    
    
rule mlst:
  input:
  output:
  params:
  conda:
  message:
        "Running mlst on sample {}"
  shell:
    
    
rule amr: ### steal from https://github.com/pha4ge/hAMRonization_workflow/tree/master/rules
  input:
  output:
  params:
  conda:
  message:
    "Running XXX on sample {}
  shell:
    
