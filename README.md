# pire_zenarchopterus_dispar_lcwgs
Analysis of low-coverage whole genome sequencing data from Zenarchopterus dispar

fq_gz processing being done by Gianna Mazzei.

## 0. Set-up: created Zdi repo in Github and cloned to /archive/carpenterlab/pire

Make 1st sequencing run directory

```
cd /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs
mkdir 1st_sequencing_run
```

## 1. Copy raw data.

```
rsync -r /archive/carpenterlab/pire/downloads/zenarchopterus_dispar/1st_sequencing_run-lcwgs/fq_raw 1st_sequencing_run
```
