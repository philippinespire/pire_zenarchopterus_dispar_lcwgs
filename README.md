# _Zenarchopterus dispar_ lcWGS
---
Analysis of low-coverage whole genome sequencing data for _Zenarchopterus dispar_.

fq_gz processing being done by Gianna Mazzei.

---
## 1. fq.gz pre-processing
<details><summary>0. Set-up</summary>
<p>
  
created Zdi repo in Github and cloned to /archive/carpenterlab/pire

Make 1st sequencing run directory

```
cd /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs
mkdir 1st_sequencing_run
```
</p>
</details>


<details><summary>1. Copy raw data</summary>
<p>

```
cd pire_zenarchopterus_dispar_lcwgs
rsync -r /archive/carpenterlab/pire/downloads/zenarchopterus_dispar/1st_sequencing_run-lcwgs/fq_raw 1st_sequencing_run
```

</p>
</details>
