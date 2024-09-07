<img src="https://lifg.australian.museum/Image/9uTxr6do.jpeg?version=full" alt="Zdi" width="300"/>

# _Zenarchopterus dispar_ lcWGS 

## 2nd sequencing run

Analysis of low-coverage whole genome sequencing data for Zdi 2nd_sequencing_run.

fq.gz processing done by Gianna Mazzei (started September 7 2024).

---
<details><summary>1. fq.gz Pre-processing</summary>
	
## 1. fq.gz Pre-processing

This portion follows the instructions on [this repo](https://github.com/philippinespire/pire_fq_gz_processing).

→ (*) _denotes steps with MultiQC Report Analyses_
<details><summary>0. Set-up</summary>

## 0. Set-up

Make 2nd sequencing run directory
```
[hpc-0356@wahab-01 pire_zenarchopterus_dispar_lcwgs]$ mkdir 2nd_sequencing_run
```

---
</details>


<details><summary>1. Get raw data</summary>

## 1. Get raw data

```
[hpc-0356@wahab-01 pire_zenarchopterus_dispar_lcwgs]$ rsync -r /archive/carpenterlab/pire/downloads/zenarchopterus_dispar/2nd_sequencing_run-lcwgs/fq_raw 2nd_sequencing_run
```

---
</details>

<details><summary>2. Proofread the decode file</summary>

## 2. Proofread the decode file

```
[hpc-0356@wahab-01 fq_raw]$ cat Zdi_LCWGS-FullSeq_SequenceNameDecode.tsv
```
Checked that I have sequencing data for all individuals in the decode file
```
[hpc-0356@wahab-01 fq_raw]$ ls *1.fq.gz | wc -l
96
[hpc-0356@wahab-01 fq_raw]$ ls *2.fq.gz | wc -l
96
```
Number of lines (there's a line for col names):
```
[hpc-0356@wahab-01 fq_raw]$ wc -l Zdi_LCWGS-FullSeq_SequenceNameDecode.tsv
97
```
Are there duplicates? No
```
[hpc-0356@wahab-01 fq_raw]$ cat Zdi_LCWGS-FullSeq_SequenceNameDecode.tsv | sort | uniq | wc -l
97
```
***Skip steps 3 and 4***

---
</details>

<details><summary>5. Perform a renaming dry run</summary>

## 5. Perform a renaming dry run

```
[hpc-0356@wahab-01 fq_raw]$ salloc
[hpc-0356@e1-w6420b-02 fq_raw]$ bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/renameFQGZ.bash Zdi_LCWGS-FullSeq_SequenceNameDecode.tsv
```
Looks good

---
</details>

<details><summary>6. Rename the file</summary>

## 6. Rename the file

```
[hpc-0356@e1-w6420b-02 fq_raw]$ bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/renameFQGZ.bash Zdi_LCWGS-FullSeq_SequenceNameDecode.tsv rename
```

## 7. Check the quality of raw data (*)

Executed `Multi_FASTQC.sh` 

```
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh "fq_raw" "fqc_raw_report"  "fq.gz"
Submitted batch job 3471540
```

### MultiQC output (fq_raw/fqc_raw_report.html):
