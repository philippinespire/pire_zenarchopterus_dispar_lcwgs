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

<details><summary>2. Proofread the decode file</summary>
<p>

Proofread the decode file
```
cat Zdi_LCWGS-test_SequenceNameDecode.txt
```
Checked that I have sequencing data for all individuals in the decode file
```
ls *1.fq.gz | wc -l 
ls *2.fq.gz | wc -l
```
Number of lines:
```
wc -l Zdi_LCWGS-test_SequenceNameDecode.txt
```
Are there duplicates?
```
cat Zdi_LCWGS-test_SequenceNameDecode.txt| sort | uniq | wc -l
```

</p>
</details>

<details><summary>5. Perform a renaming dry run</summary>
<p>

  ```
  [hpc-0356@wahab-01 1st_sequencing_run]$ cd fq_raw/
  [hpc-0356@wahab-01 fq_raw]$ salloc

  [hpc-0356@e1-w6420b-02 fq_raw]$ bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/renameFQGZ.bash Zdi_LCWGS-test_SequenceNameDecode.txt
  ```
</p>
</details>

<details><summary>6. Rename the file</summary>
<p>

```
[hpc-0356@e1-w6420b-02 fq_raw]$ bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/renameFQGZ.bash Zdi_LCWGS-test_SequenceNameDecode.txt rename
```

</p>
</details>

</p>

<details><summary>7. Check data quality</summary>
<p>

Executed Multi_FASTQC.sh 

directory changed to 1st_sequencing_run
```
[hpc-0356@wahab-01 fq_raw]$ cd ..
[hpc-0356@wahab-01 1st_sequencing_run]$ sbatch --mail-user=gmazzei@ucsc.edu --mail-type=END /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh "fq_raw" "fqc_raw_report"  "fq.gz"
```
