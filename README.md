# MinReQ
What are the minimal requirements quality parameters for WGS based data-analyses

## Introduction

We want to test whether you can extract correct information from WGS data with low quality.

## Approach

We are using the dataset published here: https://doi.org/10.1038/s41597-022-01463-7. The Zenodo repo linked to this study contains 174 isolates with a complete genome and short read WGS data.

There are two approaches we test: real data and simulated data.

For real data, we subsample the reads by ?? and ?? and test whether we can extract correct info from these subsampled read sets.

For simulated data, we *in silico* generate Illumina short reads with varying coverage and Phred quality scores. We will either filter and trim the simulated reads or not. This gives us a total of eight conditions:

| Coverage | Quality | Trimming and filtering |
|---|---|---|
|good|good|yes|
|good|good|no|
|low|good|yes|
|low|good|no|
|good|low|yes|
|good|low|no|
|low|low|yes|
|low|low|no|

 
