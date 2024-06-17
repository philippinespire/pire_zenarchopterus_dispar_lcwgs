# _Zenarchopterus dispar_ lcWGS
---
Analysis of low-coverage whole genome sequencing data for _Zenarchopterus dispar_.

fq_gz processing being done by Gianna Mazzei.

---
<details><summary>1. fq.gz Pre-processing</summary>
	
## 1. fq.gz Pre-processing
→ (*) _denotes steps with MultiQC Report Analyses_
<details><summary>0. Set-up</summary>
<p>

## 0. Set-up
  
created Zdi repo in Github and cloned to /archive/carpenterlab/pire

Make 1st sequencing run directory

```
cd /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs
mkdir 1st_sequencing_run
```
</p>

---
</details>


<details><summary>1. Get raw data</summary>
<p>

## 1. Get raw data

```
cd pire_zenarchopterus_dispar_lcwgs
rsync -r /archive/carpenterlab/pire/downloads/zenarchopterus_dispar/1st_sequencing_run-lcwgs/fq_raw 1st_sequencing_run
```

</p>

---
</details>

<details><summary>2. Proofread the decode file</summary>
<p>

## 2. Proofread the decode file

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

---
</details>

<details><summary>5. Perform a renaming dry run</summary>
<p>

## 5. Perform a renaming dry run

  ```
  [hpc-0356@wahab-01 1st_sequencing_run]$ cd fq_raw/
  [hpc-0356@wahab-01 fq_raw]$ salloc

  [hpc-0356@e1-w6420b-02 fq_raw]$ bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/renameFQGZ.bash Zdi_LCWGS-test_SequenceNameDecode.txt
  ```
</p>

---
</details>

<details><summary>6. Rename the file</summary>
<p>

## 6. Rename the file

```
[hpc-0356@e1-w6420b-02 fq_raw]$ bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/renameFQGZ.bash Zdi_LCWGS-test_SequenceNameDecode.txt rename
```

</p>

---
</details>

</p>

<details><summary>7. Check the quality of raw data (*)</summary>
<p>

## 7. Check the quality of raw data (*)

Executed `Multi_FASTQC.sh` 

directory changed to `1st_sequencing_run`
```
[hpc-0356@wahab-01 fq_raw]$ cd ..
[hpc-0356@wahab-01 1st_sequencing_run]$ sbatch --mail-user=gmazzei@ucsc.edu --mail-type=END /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh "fq_raw" "fqc_raw_report"  "fq.gz"
```

### MultiQC output (fq_raw/fastqc_report.html):
* GC content is high on average
	* ~50% for Albatross; ~60% for Contemporary
* Per Sequence GC Content peaks aroung 70% -> potential for bacterial contamination
* % Dups is high on average (~30%)
* Adapter Content is high

```  
‣ % duplication - 
	• Alb: 9.3-40.4%
 	• Contemp: 12.9-90.3%
‣ GC content - 
	• Alb: 46-65%
 	• Contemp: 46-93%
‣ number of reads - 
	• Alb: 0-54.8 mil
 	• Contemp: 0-9.8 mil
```
<details><summary>* Multi_FASTQC Report:</summary>
<p>
  
```
Sample Name	                        % Dups  % GC    M Seqs
Zdi-ADup_001-Ex1-11B-lcwgs-1-1.1	22.5%	49%	21.9
Zdi-ADup_001-Ex1-11B-lcwgs-1-1.2	23.1%	49%	21.9
Zdi-ADup_002-Ex1-9G-lcwgs-1-1.1	        13.8%	51%	18.5
Zdi-ADup_002-Ex1-9G-lcwgs-1-1.2	        14.3%	49%	18.5
Zdi-ADup_003-Ex1-9H-lcwgs-1-1.1	        13.2%	52%	20.8
Zdi-ADup_003-Ex1-9H-lcwgs-1-1.2	        13.7%	50%	20.8
Zdi-ADup_004-Ex1-10A-lcwgs-1-1.1	35.8%	61%	0.0
Zdi-ADup_004-Ex1-10A-lcwgs-1-1.2	37.1%	65%	0.0
Zdi-ADup_005-Ex1-10B-lcwgs-1-1.1	15.3%	52%	0.9
Zdi-ADup_005-Ex1-10B-lcwgs-1-1.2	15.7%	50%	0.9
Zdi-ADup_006-Ex1-10C-lcwgs-1-1.1	20.2%	51%	27.2
Zdi-ADup_006-Ex1-10C-lcwgs-1-1.2	20.9%	51%	27.2
Zdi-ADup_007-Ex1-10D-lcwgs-1-1.1	26.8%	54%	28.6
Zdi-ADup_007-Ex1-10D-lcwgs-1-1.2	26.9%	53%	28.6
Zdi-ADup_008-Ex1-10E-lcwgs-1-1.1	15.4%	48%	4.2
Zdi-ADup_008-Ex1-10E-lcwgs-1-1.2	16.1%	48%	4.2
Zdi-ADup_009-Ex1-10F-lcwgs-1-1.1	11.9%	52%	1.0
Zdi-ADup_009-Ex1-10F-lcwgs-1-1.2	12.5%	51%	1.0
Zdi-ADup_010-Ex1-10G-lcwgs-1-1.1	13.4%	52%	0.2
Zdi-ADup_010-Ex1-10G-lcwgs-1-1.2	14.3%	51%	0.2
Zdi-ADup_011-Ex1-10H-lcwgs-1-1.1	18.2%	53%	19.5
Zdi-ADup_011-Ex1-10H-lcwgs-1-1.2	18.8%	52%	19.5
Zdi-ADup_012-Ex1-11A-lcwgs-1-1.1	38.7%	61%	0.4
Zdi-ADup_012-Ex1-11A-lcwgs-1-1.2	40.0%	65%	0.4
Zdi-ADup_013-Ex1-12F-lcwgs-1-1.1	37.9%	59%	2.1
Zdi-ADup_013-Ex1-12F-lcwgs-1-1.2	39.5%	65%	2.1
Zdi-ADup_014-Ex1-11C-lcwgs-1-1.1	39.4%	59%	11.2
Zdi-ADup_014-Ex1-11C-lcwgs-1-1.2	40.4%	63%	11.2
Zdi-ADup_015-Ex1-11D-lcwgs-1-1.1	12.5%	51%	16.2
Zdi-ADup_015-Ex1-11D-lcwgs-1-1.2	12.8%	50%	16.2
Zdi-ADup_016-Ex1-11E-lcwgs-1-1.1	19.7%	48%	28.4
Zdi-ADup_016-Ex1-11E-lcwgs-1-1.2	20.5%	48%	28.4
Zdi-ADup_017-Ex1-11F-lcwgs-1-1.1	15.0%	52%	15.7
Zdi-ADup_017-Ex1-11F-lcwgs-1-1.2	15.4%	51%	15.7
Zdi-ADup_018-Ex1-11G-lcwgs-1-1.1	16.7%	51%	26.5
Zdi-ADup_018-Ex1-11G-lcwgs-1-1.2	17.2%	51%	26.5
Zdi-ADup_019-Ex1-11H-lcwgs-1-1.1	18.5%	51%	4.7
Zdi-ADup_019-Ex1-11H-lcwgs-1-1.2	19.2%	52%	4.7
Zdi-ADup_020-Ex1-12A-lcwgs-1-1.1	11.9%	50%	0.0
Zdi-ADup_020-Ex1-12A-lcwgs-1-1.2	14.5%	52%	0.0
Zdi-ADup_021-Ex1-12B-lcwgs-1-1.1	11.5%	49%	0.1
Zdi-ADup_021-Ex1-12B-lcwgs-1-1.2	12.9%	50%	0.1
Zdi-ADup_022-Ex1-12C-lcwgs-1-1.1	20.8%	50%	54.8
Zdi-ADup_022-Ex1-12C-lcwgs-1-1.2	21.3%	51%	54.8
Zdi-ADup_023-Ex1-12D-lcwgs-1-1.1	21.9%	52%	7.1
Zdi-ADup_023-Ex1-12D-lcwgs-1-1.2	22.7%	54%	7.1
Zdi-ADup_024-Ex1-12E-lcwgs-1-1.1	30.9%	57%	5.5
Zdi-ADup_024-Ex1-12E-lcwgs-1-1.2	31.9%	60%	5.5
Zdi-ADup_025-Ex1-2A-lcwgs-1-1.1  	19.2%	53%	0.2
Zdi-ADup_025-Ex1-2A-lcwgs-1-1.2	        19.8%	52%	0.2
Zdi-ADup_026-Ex1-12G-lcwgs-1-1.1	14.4%	52%	1.4
Zdi-ADup_026-Ex1-12G-lcwgs-1-1.2	15.3%	53%	1.4
Zdi-ADup_027-Ex1-12H-lcwgs-1-1.1	22.1%	52%	32.4
Zdi-ADup_027-Ex1-12H-lcwgs-1-1.2	22.6%	52%	32.4
Zdi-ADup_028-Ex1-9F-lcwgs-1-1.1	        15.3%	53%	11.3
Zdi-ADup_028-Ex1-9F-lcwgs-1-1.2	        15.9%	52%	11.3
Zdi-ADup_029-Ex1-1A-lcwgs-1-1.1	        9.3%	47%	0.1
Zdi-ADup_029-Ex1-1A-lcwgs-1-1.2	        10.2%	46%	0.1
Zdi-ADup_030-Ex1-1B-lcwgs-1-1.1	        13.5%	50%	0.2
Zdi-ADup_030-Ex1-1B-lcwgs-1-1.2	        14.2%	47%	0.2
Zdi-ADup_031-Ex1-1C-lcwgs-1-1.1	        12.0%	48%	0.2
Zdi-ADup_031-Ex1-1C-lcwgs-1-1.2	        12.7%	47%	0.2
Zdi-ADup_032-Ex1-1D-lcwgs-1-1.1	        21.3%	51%	3.0
Zdi-ADup_032-Ex1-1D-lcwgs-1-1.2	        21.8%	50%	3.0
Zdi-ADup_033-Ex1-1E-lcwgs-1-1.1	        12.1%	51%	0.3
Zdi-ADup_033-Ex1-1E-lcwgs-1-1.2	        12.8%	48%	0.3
Zdi-ADup_034-Ex1-1F-lcwgs-1-1.1	        11.0%	49%	0.3
Zdi-ADup_034-Ex1-1F-lcwgs-1-1.2	        11.8%	47%	0.3
Zdi-ADup_035-Ex1-1G-lcwgs-1-1.1	        14.4%	53%	1.4
Zdi-ADup_035-Ex1-1G-lcwgs-1-1.2	        15.0%	50%	1.4
Zdi-ADup_036-Ex1-1H-lcwgs-1-1.1	        20.1%	54%	0.5
Zdi-ADup_036-Ex1-1H-lcwgs-1-1.2	        21.2%	53%	0.5
Zdi-ADup_037-Ex1-3D-lcwgs-1-1.1	        14.3%	47%	0.3
Zdi-ADup_037-Ex1-3D-lcwgs-1-1.2	        15.4%	48%	0.3
Zdi-ADup_038-Ex1-2B-lcwgs-1-1.1	        15.4%	49%	0.2
Zdi-ADup_038-Ex1-2B-lcwgs-1-1.2	        16.0%	48%	0.2
Zdi-ADup_039-Ex1-2C-lcwgs-1-1.1	        11.8%	47%	0.3
Zdi-ADup_039-Ex1-2C-lcwgs-1-1.2	        12.5%	46%	0.3
Zdi-ADup_040-Ex1-2D-lcwgs-1-1.1	        15.0%	49%	0.3
Zdi-ADup_040-Ex1-2D-lcwgs-1-1.2	        16.0%	49%	0.3
Zdi-ADup_041-Ex1-2E-lcwgs-1-1.1	        16.0%	48%	0.2
Zdi-ADup_041-Ex1-2E-lcwgs-1-1.2	        16.7%	48%	0.2
Zdi-ADup_042-Ex1-2F-lcwgs-1-1.1	        19.2%	48%	21.8
Zdi-ADup_042-Ex1-2F-lcwgs-1-1.2	        19.8%	48%	21.8
Zdi-ADup_043-Ex1-2G-lcwgs-1-1.1  	18.4%	50%	1.5
Zdi-ADup_043-Ex1-2G-lcwgs-1-1.2 	19.2%	51%	1.5
Zdi-ADup_044-Ex1-2H-lcwgs-1-1.1 	23.4%	50%	9.9
Zdi-ADup_044-Ex1-2H-lcwgs-1-1.2 	24.1%	50%	9.9
Zdi-ADup_045-Ex1-3A-lcwgs-1-1.1 	11.5%	50%	0.3
Zdi-ADup_045-Ex1-3A-lcwgs-1-1.2 	12.3%	50%	0.3
Zdi-ADup_046-Ex1-3B-lcwgs-1-1.1 	20.7%	49%	0.2
Zdi-ADup_046-Ex1-3B-lcwgs-1-1.2 	21.6%	50%	0.2
Zdi-ADup_047-Ex1-3C-lcwgs-1-1.1 	21.6%	49%	2.2
Zdi-ADup_047-Ex1-3C-lcwgs-1-1.2 	22.2%	49%	2.2
Zdi-CDup_001-Ex1-5D-lcwgs-1-1.1 	55.8%	64%	3.1
Zdi-CDup_001-Ex1-5D-lcwgs-1-1.2 	57.1%	73%	3.1
Zdi-CDup_002-Ex1-5E-lcwgs-1-1.1 	38.2%	55%	0.2
Zdi-CDup_002-Ex1-5E-lcwgs-1-1.2 	39.8%	60%	0.2
Zdi-CDup_003-Ex1-5F-lcwgs-1-1.1 	27.5%	54%	1.1
Zdi-CDup_003-Ex1-5F-lcwgs-1-1.2 	28.8%	57%	1.1
Zdi-CDup_004-Ex1-5G-lcwgs-1-1.1 	44.2%	57%	0.2
Zdi-CDup_004-Ex1-5G-lcwgs-1-1.2 	45.6%	62%	0.2
Zdi-CDup_005-Ex1-5H-lcwgs-1-1.1 	18.4%	49%	3.1
Zdi-CDup_005-Ex1-5H-lcwgs-1-1.2	        19.2%	50%	3.1
Zdi-CDup_006-Ex1-6A-lcwgs-1-1.1	        15.7%	47%	6.6
Zdi-CDup_006-Ex1-6A-lcwgs-1-1.2 	16.5%	47%	6.6
Zdi-CDup_007-Ex1-6B-lcwgs-1-1.1 	22.6%	54%	1.8
Zdi-CDup_007-Ex1-6B-lcwgs-1-1.2 	23.7%	55%	1.8
Zdi-CDup_008-Ex1-6C-lcwgs-1-1.1 	34.5%	56%	0.9
Zdi-CDup_008-Ex1-6C-lcwgs-1-1.2 	36.2%	60%	0.9
Zdi-CDup_010-Ex1-6D-lcwgs-1-1.1 	43.0%	59%	7.0
Zdi-CDup_010-Ex1-6D-lcwgs-1-1.2 	44.2%	64%	7.0
Zdi-CDup_011-Ex1-6E-lcwgs-1-1.1 	28.4%	53%	4.1
Zdi-CDup_011-Ex1-6E-lcwgs-1-1.2 	29.5%	56%	4.1
Zdi-CDup_012-Ex1-6F-lcwgs-1-1.1 	58.5%	65%	1.6
Zdi-CDup_012-Ex1-6F-lcwgs-1-1.2 	59.8%	73%	1.6
Zdi-CDup_013-Ex1-6G-lcwgs-1-1.1 	29.5%	53%	0.5
Zdi-CDup_013-Ex1-6G-lcwgs-1-1.2 	31.4%	57%	0.5
Zdi-CDup_014-Ex1-6H-lcwgs-1-1.1 	24.9%	55%	5.3
Zdi-CDup_014-Ex1-6H-lcwgs-1-1.2 	26.0%	57%	5.3
Zdi-CDup_015-Ex1-7A-lcwgs-1-1.1 	27.8%	54%	0.5
Zdi-CDup_015-Ex1-7A-lcwgs-1-1.2 	29.4%	57%	0.5
Zdi-CDup_016-Ex1-7B-lcwgs-1-1.1 	18.8%	53%	3.7
Zdi-CDup_016-Ex1-7B-lcwgs-1-1.2 	19.7%	53%	3.7
Zdi-CDup_017-Ex1-7C-lcwgs-1-1.1 	24.6%	55%	1.0
Zdi-CDup_017-Ex1-7C-lcwgs-1-1.2 	25.9%	57%	1.0
Zdi-CDup_018-Ex1-7D-lcwgs-1-1.1 	50.7%	62%	5.4
Zdi-CDup_018-Ex1-7D-lcwgs-1-1.2 	51.9%	69%	5.4
Zdi-CDup_019-Ex1-7E-lcwgs-1-1.1 	12.9%	49%	6.0
Zdi-CDup_019-Ex1-7E-lcwgs-1-1.2 	13.5%	49%	6.0
Zdi-CDup_020-Ex1-7F-lcwgs-1-1.1 	46.9%	62%	0.3
Zdi-CDup_020-Ex1-7F-lcwgs-1-1.2 	48.2%	69%	0.3
Zdi-CDup_021-Ex1-7G-lcwgs-1-1.1 	42.8%	59%	9.8
Zdi-CDup_021-Ex1-7G-lcwgs-1-1.2 	44.0%	65%	9.8
Zdi-CDup_022-Ex1-7H-lcwgs-1-1.1 	14.1%	50%	0.8
Zdi-CDup_022-Ex1-7H-lcwgs-1-1.2 	15.0%	50%	0.8
Zdi-CDup_023-Ex1-8A-lcwgs-1-1.1 	40.1%	59%	0.1
Zdi-CDup_023-Ex1-8A-lcwgs-1-1.2 	42.4%	66%	0.1
Zdi-CDup_024-Ex1-8B-lcwgs-1-1.1 	43.1%	60%	0.1
Zdi-CDup_024-Ex1-8B-lcwgs-1-1.2 	45.4%	67%	0.1
Zdi-CDup_025-Ex1-8C-lcwgs-1-1.1 	62.8%	67%	0.3
Zdi-CDup_025-Ex1-8C-lcwgs-1-1.2 	63.9%	79%	0.3
Zdi-CDup_026-Ex1-8D-lcwgs-1-1.1  	56.8%	64%	1.3
Zdi-CDup_026-Ex1-8D-lcwgs-1-1.2 	58.4%	74%	1.3
Zdi-CDup_027-Ex1-8E-lcwgs-1-1.1 	63.5%	68%	0.2
Zdi-CDup_027-Ex1-8E-lcwgs-1-1.2 	65.7%	80%	0.2
Zdi-CDup_028-Ex1-8F-lcwgs-1-1.1 	30.4%	51%	0.2
Zdi-CDup_028-Ex1-8F-lcwgs-1-1.2 	31.4%	54%	0.2
Zdi-CDup_029-Ex1-8G-lcwgs-1-1.1  	24.9%	49%	0.1
Zdi-CDup_029-Ex1-8G-lcwgs-1-1.2 	26.1%	52%	0.1
Zdi-CDup_030-Ex1-8H-lcwgs-1-1.1 	31.2%	56%	0.0
Zdi-CDup_030-Ex1-8H-lcwgs-1-1.2 	34.0%	61%	0.0
Zdi-CDup_031-Ex1-9A-lcwgs-1-1.1 	17.0%	50%	3.7
Zdi-CDup_031-Ex1-9A-lcwgs-1-1.2  	17.8%	51%	3.7
Zdi-CDup_032-Ex1-9B-lcwgs-1-1.1 	44.9%	60%	0.4
Zdi-CDup_032-Ex1-9B-lcwgs-1-1.2 	46.8%	67%	0.4
Zdi-CDup_033-Ex1-9C-lcwgs-1-1.1 	58.9%	66%	2.5
Zdi-CDup_033-Ex1-9C-lcwgs-1-1.2 	60.2%	76%	2.5
Zdi-CDup_034-Ex1-9D-lcwgs-1-1.1 	70.0%	68%	8.0
Zdi-CDup_034-Ex1-9D-lcwgs-1-1.2 	70.8%	81%	8.0
Zdi-CDup_035-Ex1-9E-lcwgs-1-1.1 	71.9%	69%	1.5
Zdi-CDup_035-Ex1-9E-lcwgs-1-1.2 	73.1%	83%	1.5
Zdi-CDup_036-Ex1-9F-lcwgs-1-1.1 	54.9%	62%	0.3
Zdi-CDup_036-Ex1-9F-lcwgs-1-1.2 	55.8%	70%	0.3
Zdi-CDup_037-Ex1-9G-lcwgs-1-1.1 	62.3%	65%	1.2
Zdi-CDup_037-Ex1-9G-lcwgs-1-1.2 	63.7%	76%	1.2
Zdi-CDup_038-Ex1-9H-lcwgs-1-1.1 	70.0%	69%	0.7
Zdi-CDup_038-Ex1-9H-lcwgs-1-1.2 	71.4%	82%	0.7
Zdi-CDup_039-Ex1-10A-lcwgs-1-1.1	20.6%	52%	0.3
Zdi-CDup_039-Ex1-10A-lcwgs-1-1.2	22.1%	54%	0.3
Zdi-CDup_040-Ex1-10B-lcwgs-1-1.1	26.6%	56%	0.3
Zdi-CDup_040-Ex1-10B-lcwgs-1-1.2	28.1%	58%	0.3
Zdi-CDup_041-Ex1-10C-lcwgs-1-1.1	38.9%	61%	0.9
Zdi-CDup_041-Ex1-10C-lcwgs-1-1.2	40.4%	66%	0.9
Zdi-CDup_042-Ex1-10D-lcwgs-1-1.1	23.9%	54%	3.5
Zdi-CDup_042-Ex1-10D-lcwgs-1-1.2	25.0%	56%	3.5
Zdi-CDup_043-Ex1-10E-lcwgs-1-1.1	31.3%	55%	7.3
Zdi-CDup_043-Ex1-10E-lcwgs-1-1.2	32.4%	58%	7.3
Zdi-CDup_044-Ex1-10F-lcwgs-1-1.1	67.1%	68%	0.3
Zdi-CDup_044-Ex1-10F-lcwgs-1-1.2	67.6%	78%	0.3
Zdi-CDup_045-Ex1-10G-lcwgs-1-1.1	37.2%	59%	1.4
Zdi-CDup_045-Ex1-10G-lcwgs-1-1.2	38.6%	64%	1.4
Zdi-CDup_046-Ex1-10H-lcwgs-1-1.1	43.6%	61%	0.8
Zdi-CDup_046-Ex1-10H-lcwgs-1-1.2	45.2%	67%	0.8
Zdi-CDup_047-Ex1-11A-lcwgs-1-1.1	13.9%	53%	9.4
Zdi-CDup_047-Ex1-11A-lcwgs-1-1.2	14.4%	51%	9.4
Zdi-CDup_048-Ex1-11B-lcwgs-1-1.1	48.9%	61%	0.2
Zdi-CDup_048-Ex1-11B-lcwgs-1-1.2	49.7%	66%	0.2
Zdi-CDup_049-Ex1-11C-lcwgs-1-1.1	38.2%	60%	0.3
Zdi-CDup_049-Ex1-11C-lcwgs-1-1.2	39.8%	65%	0.3
Zdi-CDup_050-Ex1-11D-lcwgs-1-1.1	52.7%	65%	0.6
Zdi-CDup_050-Ex1-11D-lcwgs-1-1.2	54.3%	73%	0.6
Zdi-CDup_051-Ex1-11E-lcwgs-1-1.1	58.4%	67%	0.4
Zdi-CDup_051-Ex1-11E-lcwgs-1-1.2	59.9%	76%	0.4
Zdi-CDup_053-Ex1-11F-lcwgs-1-1.1	33.5%	59%	0.1
Zdi-CDup_053-Ex1-11F-lcwgs-1-1.2	34.9%	63%	0.1
Zdi-CDup_054-Ex1-11G-lcwgs-1-1.1	65.7%	70%	1.4
Zdi-CDup_054-Ex1-11G-lcwgs-1-1.2	67.0%	81%	1.4
Zdi-CDup_055-Ex1-11H-lcwgs-1-1.1	25.7%	56%	0.1
Zdi-CDup_055-Ex1-11H-lcwgs-1-1.2	27.1%	59%	0.1
Zdi-CDup_056-Ex1-12A-lcwgs-1-1.1	42.6%	56%	8.1
Zdi-CDup_056-Ex1-12A-lcwgs-1-1.2	43.9%	62%	8.1
Zdi-CDup_057-Ex1-12B-lcwgs-1-1.1	69.9%	68%	2.8
Zdi-CDup_057-Ex1-12B-lcwgs-1-1.2	71.1%	80%	2.8
Zdi-CDup_058-Ex1-12C-lcwgs-1-1.1	39.5%	60%	7.2
Zdi-CDup_058-Ex1-12C-lcwgs-1-1.2	40.7%	65%	7.2
Zdi-CDup_059-Ex1-12D-lcwgs-1-1.1	89.8%	75%	6.8
Zdi-CDup_059-Ex1-12D-lcwgs-1-1.2	90.3%	93%	6.8
Zdi-CDup_060-Ex1-12E-lcwgs-1-1.1	49.8%	59%	0.3
Zdi-CDup_060-Ex1-12E-lcwgs-1-1.2	51.2%	66%	0.3
Zdi-CDup_061-Ex1-12F-lcwgs-1-1.1	55.4%	65%	3.7
Zdi-CDup_061-Ex1-12F-lcwgs-1-1.2	56.7%	74%	3.7
Zdi-CDup_062-Ex1-12G-lcwgs-1-1.1	44.0%	61%	0.3
Zdi-CDup_062-Ex1-12G-lcwgs-1-1.2	46.1%	68%	0.3
Zdi-CDup_064-Ex1-5A-lcwgs-1-1.1 	18.0%	46%	1.9
Zdi-CDup_064-Ex1-5A-lcwgs-1-1.2 	18.9%	47%	1.9
Zdi-CDup_065-Ex1-5B-lcwgs-1-1.1 	43.5%	58%	0.5
Zdi-CDup_065-Ex1-5B-lcwgs-1-1.2 	45.4%	64%	0.5
Zdi-CDup_066-Ex1-5C-lcwgs-1-1.1 	64.7%	68%	7.7
Zdi-CDup_066-Ex1-5C-lcwgs-1-1.2 	65.7%	79%	7.7
Zdi-CDup_071-Ex1-12H-lcwgs-1-1.1	48.6%	61%	0.6
Zdi-CDup_071-Ex1-12H-lcwgs-1-1.2	50.5%	69%	0.6
  ```
  
</p>
</details>

</p>

---
</details>

<details><summary>8. First trim (*)</summary>
<p>

## 8. First trim (*)
	
```
[hpc-0356@wahab-01 1st_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFASTP_1st_trim.sbatch fq_raw fq_fp1
```

### Review the FastQC output (fq_fp1/1st_fastp_report.html):
After 1st trim:
* % Dup went considerably down
* GC content down to more typical levels
* % PF relatively high for Albatross samples, more variable for contemporary
* High % adapter

```  
‣ % duplication - 
    	• Alb: 4.9-19.9%
	• Contemp: 6.6-17.4%
‣ GC content -
    	• Alb: 36.5-55.3%
	• Contemp: 42-49.6%
‣ passing filter - 
    	• Alb: 64.7-96.7%
     	• Contemp: 11.6-95.7%
‣ % adapter - 
    	• Alb: 52.8-95.8%
     	• Contemp: 49.9-85.3%
‣ number of reads - 
    	• Alb: 0-109 mil
     	• Contemp: 0-19.6 mil
```
<details><summary>* 1st FASTP Report:</summary>
<p>
  
```

Sample Name	            	% Duplication	% GC    % PF	% Adapter
Zdi-ADup_001-Ex1-11B-lcwgs-1-1		14.4%	41.2%	92.2%	85.3%
Zdi-ADup_002-Ex1-9G-lcwgs-1-1		9.4%	40.3%	94.0%	92.3%
Zdi-ADup_003-Ex1-9H-lcwgs-1-1		8.9%	41.1%	93.3%	91.9%
Zdi-ADup_004-Ex1-10A-lcwgs-1-1		6.4%	40.4%	64.7%	77.8%
Zdi-ADup_005-Ex1-10B-lcwgs-1-1		6.7%	41.2%	94.0%	94.9%
Zdi-ADup_006-Ex1-10C-lcwgs-1-1		12.1%	39.3%	87.6%	81.8%
Zdi-ADup_007-Ex1-10D-lcwgs-1-1		8.8%	44.1%	91.4%	92.9%
Zdi-ADup_008-Ex1-10E-lcwgs-1-1		12.4%	38.6%	92.7%	87.4%
Zdi-ADup_009-Ex1-10F-lcwgs-1-1		7.5%	42.2%	93.7%	92.1%
Zdi-ADup_010-Ex1-10G-lcwgs-1-1		4.9%	41.8%	90.5%	87.4%
Zdi-ADup_011-Ex1-10H-lcwgs-1-1		10.0%	42.0%	89.9%	89.5%
Zdi-ADup_012-Ex1-11A-lcwgs-1-1		19.9%	55.3%	76.1%	52.8%
Zdi-ADup_013-Ex1-12F-lcwgs-1-1		13.2%	49.7%	69.3%	68.5%
Zdi-ADup_014-Ex1-11C-lcwgs-1-1		14.4%	46.8%	73.4%	78.3%
Zdi-ADup_015-Ex1-11D-lcwgs-1-1		8.0%	41.3%	94.0%	91.6%
Zdi-ADup_016-Ex1-11E-lcwgs-1-1		15.6%	39.3%	92.0%	85.3%
Zdi-ADup_017-Ex1-11F-lcwgs-1-1		9.3%	42.9%	93.1%	92.1%
Zdi-ADup_018-Ex1-11G-lcwgs-1-1		11.2%	42.9%	92.7%	89.0%
Zdi-ADup_019-Ex1-11H-lcwgs-1-1		9.1%	39.6%	87.7%	88.7%
Zdi-ADup_020-Ex1-12A-lcwgs-1-1		5.9%	44.2%	88.9%	74.5%
Zdi-ADup_021-Ex1-12B-lcwgs-1-1		5.4%	42.1%	90.9%	82.4%
Zdi-ADup_022-Ex1-12C-lcwgs-1-1		11.8%	41.4%	91.7%	90.3%
Zdi-ADup_023-Ex1-12D-lcwgs-1-1		9.6%	42.8%	87.0%	87.7%
Zdi-ADup_024-Ex1-12E-lcwgs-1-1		14.7%	48.2%	79.1%	78.8%
Zdi-ADup_025-Ex1-2A-lcwgs-1-1		5.9%	38.7%	89.7%	90.2%
Zdi-ADup_026-Ex1-12G-lcwgs-1-1		7.8%	44.8%	92.8%	93.4%
Zdi-ADup_027-Ex1-12H-lcwgs-1-1		11.9%	45.2%	93.7%	95.8%
Zdi-ADup_028-Ex1-9F-lcwgs-1-1		7.5%	39.8%	89.5%	91.6%
Zdi-ADup_029-Ex1-1A-lcwgs-1-1		6.3%	40.2%	95.4%	75.1%
Zdi-ADup_030-Ex1-1B-lcwgs-1-1		7.2%	39.3%	96.7%	88.4%
Zdi-ADup_031-Ex1-1C-lcwgs-1-1		6.8%	39.7%	95.1%	80.1%
Zdi-ADup_032-Ex1-1D-lcwgs-1-1		13.2%	43.1%	92.7%	84.5%
Zdi-ADup_033-Ex1-1E-lcwgs-1-1		6.8%	38.2%	93.5%	89.4%
Zdi-ADup_034-Ex1-1F-lcwgs-1-1		7.2%	38.5%	94.8%	86.0%
Zdi-ADup_035-Ex1-1G-lcwgs-1-1		6.6%	37.3%	91.7%	92.4%
Zdi-ADup_036-Ex1-1H-lcwgs-1-1		6.4%	39.0%	85.9%	84.0%
Zdi-ADup_037-Ex1-3D-lcwgs-1-1		6.5%	37.0%	91.3%	85.6%
Zdi-ADup_038-Ex1-2B-lcwgs-1-1		6.5%	37.6%	94.1%	90.2%
Zdi-ADup_039-Ex1-2C-lcwgs-1-1		6.7%	37.7%	94.0%	85.0%
Zdi-ADup_040-Ex1-2D-lcwgs-1-1		6.3%	37.9%	89.8%	85.4%
Zdi-ADup_041-Ex1-2E-lcwgs-1-1		6.2%	37.8%	91.8%	86.3%
Zdi-ADup_042-Ex1-2F-lcwgs-1-1		12.9%	37.4%	92.1%	90.5%
Zdi-ADup_043-Ex1-2G-lcwgs-1-1		8.7%	37.6%	88.0%	88.8%
Zdi-ADup_044-Ex1-2H-lcwgs-1-1		11.3%	37.0%	89.5%	90.7%
Zdi-ADup_045-Ex1-3A-lcwgs-1-1		6.3%	37.7%	93.4%	94.0%
Zdi-ADup_046-Ex1-3B-lcwgs-1-1		6.5%	36.5%	88.1%	87.8%
Zdi-ADup_047-Ex1-3C-lcwgs-1-1		8.8%	38.9%	94.0%	93.3%
Zdi-CDup_001-Ex1-5D-lcwgs-1-1		9.5%	45.8%	51.4%	64.9%
Zdi-CDup_002-Ex1-5E-lcwgs-1-1		8.7%	44.4%	75.0%	69.3%
Zdi-CDup_003-Ex1-5F-lcwgs-1-1		11.2%	46.7%	83.4%	73.3%
Zdi-CDup_004-Ex1-5G-lcwgs-1-1		9.8%	44.9%	70.4%	67.9%
Zdi-CDup_005-Ex1-5H-lcwgs-1-1		13.9%	45.0%	93.0%	66.5%
Zdi-CDup_006-Ex1-6A-lcwgs-1-1		14.5%	43.8%	95.5%	60.7%
Zdi-CDup_007-Ex1-6B-lcwgs-1-1		9.7%	45.2%	86.0%	77.8%
Zdi-CDup_008-Ex1-6C-lcwgs-1-1		11.3%	43.7%	72.8%	61.2%
Zdi-CDup_010-Ex1-6D-lcwgs-1-1		13.4%	44.7%	66.2%	58.7%
Zdi-CDup_011-Ex1-6E-lcwgs-1-1		13.9%	43.3%	80.5%	61.2%
Zdi-CDup_012-Ex1-6F-lcwgs-1-1		12.0%	45.4%	49.4%	61.5%
Zdi-CDup_013-Ex1-6G-lcwgs-1-1		10.7%	42.2%	77.5%	60.9%
Zdi-CDup_014-Ex1-6H-lcwgs-1-1		10.0%	44.1%	81.6%	75.0%
Zdi-CDup_015-Ex1-7A-lcwgs-1-1		9.0%	43.4%	77.9%	66.3%
Zdi-CDup_016-Ex1-7B-lcwgs-1-1		9.9%	45.4%	89.8%	79.4%
Zdi-CDup_017-Ex1-7C-lcwgs-1-1		9.1%	44.7%	81.9%	75.2%
Zdi-CDup_018-Ex1-7D-lcwgs-1-1		11.7%	46.8%	58.7%	61.4%
Zdi-CDup_019-Ex1-7E-lcwgs-1-1		11.3%	43.8%	95.7%	73.3%
Zdi-CDup_020-Ex1-7F-lcwgs-1-1		9.6%	44.2%	58.2%	66.4%
Zdi-CDup_021-Ex1-7G-lcwgs-1-1		11.2%	43.4%	64.0%	65.4%
Zdi-CDup_022-Ex1-7H-lcwgs-1-1		9.7%	42.8%	92.8%	78.8%
Zdi-CDup_023-Ex1-8A-lcwgs-1-1		10.1%	44.1%	62.2%	64.7%
Zdi-CDup_024-Ex1-8B-lcwgs-1-1		12.7%	44.7%	61.2%	64.0%
Zdi-CDup_025-Ex1-8C-lcwgs-1-1		10.1%	44.1%	39.3%	61.3%
Zdi-CDup_026-Ex1-8D-lcwgs-1-1		10.1%	44.6%	48.0%	62.8%
Zdi-CDup_027-Ex1-8E-lcwgs-1-1		10.6%	44.0%	36.6%	60.1%
Zdi-CDup_028-Ex1-8F-lcwgs-1-1		14.1%	44.1%	85.6%	65.3%
Zdi-CDup_029-Ex1-8G-lcwgs-1-1		13.8%	42.5%	86.6%	63.8%
Zdi-CDup_030-Ex1-8H-lcwgs-1-1		10.4%	43.5%	71.3%	68.2%
Zdi-CDup_031-Ex1-9A-lcwgs-1-1		11.8%	44.1%	92.3%	73.3%
Zdi-CDup_032-Ex1-9B-lcwgs-1-1		11.0%	45.2%	61.8%	67.9%
Zdi-CDup_033-Ex1-9C-lcwgs-1-1		9.5%	45.8%	45.9%	65.1%
Zdi-CDup_034-Ex1-9D-lcwgs-1-1		10.9%	43.9%	34.7%	58.6%
Zdi-CDup_035-Ex1-9E-lcwgs-1-1		11.0%	44.7%	31.5%	58.1%
Zdi-CDup_036-Ex1-9F-lcwgs-1-1		11.8%	44.1%	55.6%	64.5%
Zdi-CDup_037-Ex1-9G-lcwgs-1-1		11.7%	43.9%	43.4%	60.5%
Zdi-CDup_038-Ex1-9H-lcwgs-1-1		9.9%	44.7%	32.9%	59.9%
Zdi-CDup_039-Ex1-10A-lcwgs-1-1		9.1%	44.3%	86.3%	69.2%
Zdi-CDup_040-Ex1-10B-lcwgs-1-1		8.3%	43.3%	79.2%	76.5%
Zdi-CDup_041-Ex1-10C-lcwgs-1-1		7.4%	44.9%	65.3%	73.5%
Zdi-CDup_042-Ex1-10D-lcwgs-1-1		9.6%	44.8%	83.7%	71.2%
Zdi-CDup_043-Ex1-10E-lcwgs-1-1		12.8%	46.0%	79.3%	60.5%
Zdi-CDup_044-Ex1-10F-lcwgs-1-1		9.5%	44.9%	40.6%	62.8%
Zdi-CDup_045-Ex1-10G-lcwgs-1-1		8.9%	43.7%	67.6%	70.3%
Zdi-CDup_046-Ex1-10H-lcwgs-1-1		8.7%	44.2%	60.7%	68.5%
Zdi-CDup_047-Ex1-11A-lcwgs-1-1		8.0%	44.5%	94.0%	85.3%
Zdi-CDup_048-Ex1-11B-lcwgs-1-1		8.9%	44.4%	64.4%	71.7%
Zdi-CDup_049-Ex1-11C-lcwgs-1-1		8.3%	44.4%	67.0%	72.4%
Zdi-CDup_050-Ex1-11D-lcwgs-1-1		7.7%	45.0%	50.4%	66.4%
Zdi-CDup_051-Ex1-11E-lcwgs-1-1		8.6%	45.1%	45.1%	62.7%
Zdi-CDup_053-Ex1-11F-lcwgs-1-1		9.2%	44.3%	70.2%	72.2%
Zdi-CDup_054-Ex1-11G-lcwgs-1-1		6.6%	45.3%	36.5%	65.1%
Zdi-CDup_055-Ex1-11H-lcwgs-1-1		7.9%	44.3%	77.7%	74.0%
Zdi-CDup_056-Ex1-12A-lcwgs-1-1		17.4%	43.3%	67.4%	49.9%
Zdi-CDup_057-Ex1-12B-lcwgs-1-1		13.5%	44.5%	35.0%	55.6%
Zdi-CDup_058-Ex1-12C-lcwgs-1-1		8.7%	44.3%	65.5%	72.5%
Zdi-CDup_059-Ex1-12D-lcwgs-1-1		15.1%	43.7%	11.6%	50.0%
Zdi-CDup_060-Ex1-12E-lcwgs-1-1		8.2%	44.1%	62.4%	64.3%
Zdi-CDup_061-Ex1-12F-lcwgs-1-1		8.6%	44.7%	49.3%	68.6%
Zdi-CDup_062-Ex1-12G-lcwgs-1-1		8.5%	43.7%	59.6%	67.2%
Zdi-CDup_064-Ex1-5A-lcwgs-1-1		16.2%	42.0%	93.6%	54.0%
Zdi-CDup_065-Ex1-5B-lcwgs-1-1		12.4%	43.0%	64.3%	64.1%
Zdi-CDup_066-Ex1-5C-lcwgs-1-1		9.9%	49.6%	42.0%	62.6%
Zdi-CDup_071-Ex1-12H-lcwgs-1-1		12.0%	44.0%	57.5%	61.0%				
```

</p>
</details>

</p>

---
</details>

<details><summary>9. Remove duplicates with clumpify</summary>
<p>

## 9. Remove duplicates with clumpify

### 9a. Remove duplicates
 ```
[hpc-0356@wahab-01 1st_sequencing_run]$ bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runCLUMPIFY_r1r2_array.bash fq_fp1 fq_fp1_clmp /scratch/hpc-0356 20
```
### 9c. Check duplicate removal success

Clumpify Successfully worked on all samples
```
salloc
enable_lmod
module load container_env R/4.3 
[hpc-0356@d4-w6420b-08 1st_sequencing_run]$ crun R < /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/checkClumpify_EG.R --no-save
     # I did not have tidyverse
     [hpc-0356@d4-w6420b-01 1st_sequencing_run]$ crun R
     > install.packages("tidyverse")
     # ctrl + d to quit R
[hpc-0356@d4-w6420b-08 1st_sequencing_run]$ crun R < /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/checkClumpify_EG.R --no-save
[hpc-0356@d4-w6420b-01 1st_sequencing_run]$ exit
```
### 9d. Clean the sratch drive
```
[hpc-0356@d6-w6420b-01 1st_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/cleanSCRATCH.sbatch /scratch/hpc-0356 "*clumpify*temp*"
```
### 9e. Generate metadata on deduplicated FASTQ files
```
[hpc-0356@wahab-01 1st_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh "fq_fp1_clmp" "fqc_clmp_report"  "fq.gz"
```

</p>

---
</details>

<details><summary>10. Second trim (*)</summary>
<p>

## 10. Second trim (*)
 
```
[hpc-0356@wahab-01 1st_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFASTP_2.sbatch fq_fp1_clmp fq_fp1_clmp_fp2 33
```
### Review the FastQC output (fq_fp1_clmp_fp2/2nd_fastp_report.html):
After 2nd trim:
* % passing filter all above 99%
* GC content variable between Read Position 1-10 even after filtering
* % adapter at or below 1%

```
‣ % duplication -
	• Alb: 0.4-2.3%
	• Contemp: 0.5-2.5%
‣ GC content -
	• Alb: 36.4-55.7%
	• Contemp: 42-49%
‣ passing filter -
	• Alb: 98.8-99.6%
	• Contemp: 99-99.5%
‣ % adapter -
	• Alb: 0.4-1.2%
	• Contemp: 0.4-1%
‣ number of reads -
	• Alb: 0.02-73.5 mil
	• Contemp: 0.04-14.9 mil
```
<details><summary>* 2nd FASTP Report:</summary>
<p>
  
```
Sample Name					% Duplication	% GC 	% PF	% Adapter
Zdi-ADup_001-Ex1-11B-lcwgs-1-1.clmp.r1r2_fastp		1.8%	41.0%	99.3%	0.6%
Zdi-ADup_002-Ex1-9G-lcwgs-1-1.clmp.r1r2_fastp		0.9%	40.2%	99.5%	0.6%
Zdi-ADup_003-Ex1-9H-lcwgs-1-1.clmp.r1r2_fastp		0.8%	41.0%	99.5%	0.6%
Zdi-ADup_004-Ex1-10A-lcwgs-1-1.clmp.r1r2_fastp		0.5%	40.4%	99.5%	0.7%
Zdi-ADup_005-Ex1-10B-lcwgs-1-1.clmp.r1r2_fastp		0.6%	40.8%	99.4%	0.7%
Zdi-ADup_006-Ex1-10C-lcwgs-1-1.clmp.r1r2_fastp		1.4%	39.3%	99.4%	0.6%
Zdi-ADup_007-Ex1-10D-lcwgs-1-1.clmp.r1r2_fastp		0.9%	43.9%	99.3%	0.7%
Zdi-ADup_008-Ex1-10E-lcwgs-1-1.clmp.r1r2_fastp		1.4%	38.6%	99.4%	0.6%
Zdi-ADup_009-Ex1-10F-lcwgs-1-1.clmp.r1r2_fastp		0.7%	42.1%	99.4%	0.7%
Zdi-ADup_010-Ex1-10G-lcwgs-1-1.clmp.r1r2_fastp		0.4%	41.7%	99.2%	1.2%
Zdi-ADup_011-Ex1-10H-lcwgs-1-1.clmp.r1r2_fastp		1.1%	41.8%	99.4%	0.6%
Zdi-ADup_012-Ex1-11A-lcwgs-1-1.clmp.r1r2_fastp		2.3%	55.7%	99.0%	0.4%
Zdi-ADup_013-Ex1-12F-lcwgs-1-1.clmp.r1r2_fastp		1.3%	49.7%	99.2%	0.7%
Zdi-ADup_014-Ex1-11C-lcwgs-1-1.clmp.r1r2_fastp		1.7%	46.8%	99.3%	0.7%
Zdi-ADup_015-Ex1-11D-lcwgs-1-1.clmp.r1r2_fastp		0.7%	41.1%	99.4%	0.7%
Zdi-ADup_016-Ex1-11E-lcwgs-1-1.clmp.r1r2_fastp		1.9%	39.2%	99.4%	0.6%
Zdi-ADup_017-Ex1-11F-lcwgs-1-1.clmp.r1r2_fastp		0.8%	42.7%	99.4%	0.7%
Zdi-ADup_018-Ex1-11G-lcwgs-1-1.clmp.r1r2_fastp		1.2%	42.7%	99.4%	0.7%
Zdi-ADup_019-Ex1-11H-lcwgs-1-1.clmp.r1r2_fastp		0.8%	39.6%	99.5%	0.7%
Zdi-ADup_020-Ex1-12A-lcwgs-1-1.clmp.r1r2_fastp		0.4%	44.1%	99.1%	1.0%
Zdi-ADup_021-Ex1-12B-lcwgs-1-1.clmp.r1r2_fastp		0.5%	42.0%	98.8%	1.1%
Zdi-ADup_022-Ex1-12C-lcwgs-1-1.clmp.r1r2_fastp		1.2%	41.0%	99.4%	0.7%
Zdi-ADup_023-Ex1-12D-lcwgs-1-1.clmp.r1r2_fastp		0.9%	42.7%	99.4%	0.7%
Zdi-ADup_024-Ex1-12E-lcwgs-1-1.clmp.r1r2_fastp		1.6%	48.2%	99.1%	0.7%
Zdi-ADup_025-Ex1-2A-lcwgs-1-1.clmp.r1r2_fastp		0.4%	38.5%	99.5%	0.8%
Zdi-ADup_026-Ex1-12G-lcwgs-1-1.clmp.r1r2_fastp		0.6%	44.7%	99.3%	0.9%
Zdi-ADup_027-Ex1-12H-lcwgs-1-1.clmp.r1r2_fastp		1.2%	45.1%	99.4%	0.7%
Zdi-ADup_028-Ex1-9F-lcwgs-1-1.clmp.r1r2_fastp		0.6%	39.6%	99.5%	0.7%
Zdi-ADup_029-Ex1-1A-lcwgs-1-1.clmp.r1r2_fastp		0.6%	40.1%	99.2%	1.2%
Zdi-ADup_030-Ex1-1B-lcwgs-1-1.clmp.r1r2_fastp		0.6%	39.0%	99.4%	0.9%
Zdi-ADup_031-Ex1-1C-lcwgs-1-1.clmp.r1r2_fastp		0.7%	39.5%	99.2%	1.0%
Zdi-ADup_032-Ex1-1D-lcwgs-1-1.clmp.r1r2_fastp		1.5%	42.9%	99.3%	0.6%
Zdi-ADup_033-Ex1-1E-lcwgs-1-1.clmp.r1r2_fastp		0.6%	38.1%	99.5%	0.8%
Zdi-ADup_034-Ex1-1F-lcwgs-1-1.clmp.r1r2_fastp		0.7%	38.4%	99.4%	0.9%
Zdi-ADup_035-Ex1-1G-lcwgs-1-1.clmp.r1r2_fastp		0.6%	37.2%	99.5%	0.7%
Zdi-ADup_036-Ex1-1H-lcwgs-1-1.clmp.r1r2_fastp		0.5%	38.9%	99.3%	0.9%
Zdi-ADup_037-Ex1-3D-lcwgs-1-1.clmp.r1r2_fastp		0.5%	36.9%	99.4%	0.9%
Zdi-ADup_038-Ex1-2B-lcwgs-1-1.clmp.r1r2_fastp		0.5%	37.5%	99.5%	0.9%
Zdi-ADup_039-Ex1-2C-lcwgs-1-1.clmp.r1r2_fastp		0.6%	37.6%	99.3%	1.0%
Zdi-ADup_040-Ex1-2D-lcwgs-1-1.clmp.r1r2_fastp		0.6%	37.8%	99.3%	1.0%
Zdi-ADup_041-Ex1-2E-lcwgs-1-1.clmp.r1r2_fastp		0.5%	37.8%	99.4%	0.9%
Zdi-ADup_042-Ex1-2F-lcwgs-1-1.clmp.r1r2_fastp		1.4%	37.4%	99.5%	0.6%
Zdi-ADup_043-Ex1-2G-lcwgs-1-1.clmp.r1r2_fastp		0.8%	37.5%	99.5%	0.7%
Zdi-ADup_044-Ex1-2H-lcwgs-1-1.clmp.r1r2_fastp		1.2%	36.8%	99.5%	0.6%
Zdi-ADup_045-Ex1-3A-lcwgs-1-1.clmp.r1r2_fastp		0.4%	37.7%	99.6%	0.7%
Zdi-ADup_046-Ex1-3B-lcwgs-1-1.clmp.r1r2_fastp		0.5%	36.4%	99.5%	0.8%
Zdi-ADup_047-Ex1-3C-lcwgs-1-1.clmp.r1r2_fastp		0.8%	38.3%	99.4%	0.7%
Zdi-CDup_001-Ex1-5D-lcwgs-1-1.clmp.r1r2_fastp		1.0%	45.3%	99.4%	0.6%
Zdi-CDup_002-Ex1-5E-lcwgs-1-1.clmp.r1r2_fastp		0.9%	44.3%	99.1%	1.0%
Zdi-CDup_003-Ex1-5F-lcwgs-1-1.clmp.r1r2_fastp		1.3%	46.2%	99.4%	0.6%
Zdi-CDup_004-Ex1-5G-lcwgs-1-1.clmp.r1r2_fastp		1.1%	44.8%	99.4%	0.7%
Zdi-CDup_005-Ex1-5H-lcwgs-1-1.clmp.r1r2_fastp		1.8%	44.8%	99.3%	0.5%
Zdi-CDup_006-Ex1-6A-lcwgs-1-1.clmp.r1r2_fastp		1.9%	43.5%	99.3%	0.5%
Zdi-CDup_007-Ex1-6B-lcwgs-1-1.clmp.r1r2_fastp		1.0%	44.9%	99.4%	0.6%
Zdi-CDup_008-Ex1-6C-lcwgs-1-1.clmp.r1r2_fastp		1.5%	43.6%	99.3%	0.7%
Zdi-CDup_010-Ex1-6D-lcwgs-1-1.clmp.r1r2_fastp		1.8%	44.5%	99.3%	0.5%
Zdi-CDup_011-Ex1-6E-lcwgs-1-1.clmp.r1r2_fastp		1.8%	43.2%	99.3%	0.5%
Zdi-CDup_012-Ex1-6F-lcwgs-1-1.clmp.r1r2_fastp		1.5%	45.2%	99.3%	0.6%
Zdi-CDup_013-Ex1-6G-lcwgs-1-1.clmp.r1r2_fastp		1.3%	42.2%	99.3%	0.7%
Zdi-CDup_014-Ex1-6H-lcwgs-1-1.clmp.r1r2_fastp		1.1%	43.9%	99.4%	0.6%
Zdi-CDup_015-Ex1-7A-lcwgs-1-1.clmp.r1r2_fastp		1.1%	43.3%	99.3%	0.7%
Zdi-CDup_016-Ex1-7B-lcwgs-1-1.clmp.r1r2_fastp		1.0%	45.0%	99.4%	0.6%
Zdi-CDup_017-Ex1-7C-lcwgs-1-1.clmp.r1r2_fastp		1.0%	44.6%	99.4%	0.6%
Zdi-CDup_018-Ex1-7D-lcwgs-1-1.clmp.r1r2_fastp		1.4%	46.3%	99.3%	0.6%
Zdi-CDup_019-Ex1-7E-lcwgs-1-1.clmp.r1r2_fastp		1.3%	43.6%	99.4%	0.5%
Zdi-CDup_020-Ex1-7F-lcwgs-1-1.clmp.r1r2_fastp		1.0%	44.1%	99.4%	0.7%
Zdi-CDup_021-Ex1-7G-lcwgs-1-1.clmp.r1r2_fastp		1.3%	43.2%	99.4%	0.5%
Zdi-CDup_022-Ex1-7H-lcwgs-1-1.clmp.r1r2_fastp		1.0%	42.7%	99.4%	0.6%
Zdi-CDup_023-Ex1-8A-lcwgs-1-1.clmp.r1r2_fastp		1.0%	44.1%	99.3%	0.7%
Zdi-CDup_024-Ex1-8B-lcwgs-1-1.clmp.r1r2_fastp		1.4%	44.7%	99.4%	0.6%
Zdi-CDup_025-Ex1-8C-lcwgs-1-1.clmp.r1r2_fastp		1.0%	44.0%	99.4%	0.6%
Zdi-CDup_026-Ex1-8D-lcwgs-1-1.clmp.r1r2_fastp		1.1%	44.5%	99.4%	0.5%
Zdi-CDup_027-Ex1-8E-lcwgs-1-1.clmp.r1r2_fastp		1.0%	44.0%	99.4%	0.6%
Zdi-CDup_028-Ex1-8F-lcwgs-1-1.clmp.r1r2_fastp		1.7%	44.1%	99.4%	0.5%
Zdi-CDup_029-Ex1-8G-lcwgs-1-1.clmp.r1r2_fastp		1.7%	42.5%	99.3%	0.5%
Zdi-CDup_030-Ex1-8H-lcwgs-1-1.clmp.r1r2_fastp		1.2%	43.5%	99.4%	0.7%
Zdi-CDup_031-Ex1-9A-lcwgs-1-1.clmp.r1r2_fastp		1.3%	43.8%	99.4%	0.6%
Zdi-CDup_032-Ex1-9B-lcwgs-1-1.clmp.r1r2_fastp		1.1%	44.9%	99.4%	0.7%
Zdi-CDup_033-Ex1-9C-lcwgs-1-1.clmp.r1r2_fastp		1.0%	45.6%	99.4%	0.6%
Zdi-CDup_034-Ex1-9D-lcwgs-1-1.clmp.r1r2_fastp		1.2%	43.7%	99.4%	0.6%
Zdi-CDup_035-Ex1-9E-lcwgs-1-1.clmp.r1r2_fastp		1.1%	44.6%	99.2%	0.8%
Zdi-CDup_036-Ex1-9F-lcwgs-1-1.clmp.r1r2_fastp		1.3%	44.1%	99.4%	0.6%
Zdi-CDup_037-Ex1-9G-lcwgs-1-1.clmp.r1r2_fastp		1.3%	43.8%	99.4%	0.6%
Zdi-CDup_038-Ex1-9H-lcwgs-1-1.clmp.r1r2_fastp		1.0%	44.6%	99.4%	0.7%
Zdi-CDup_039-Ex1-10A-lcwgs-1-1.clmp.r1r2_fastp		1.1%	44.2%	99.4%	0.7%
Zdi-CDup_040-Ex1-10B-lcwgs-1-1.clmp.r1r2_fastp		0.8%	43.3%	99.4%	0.6%
Zdi-CDup_041-Ex1-10C-lcwgs-1-1.clmp.r1r2_fastp		0.7%	44.6%	99.5%	0.6%
Zdi-CDup_042-Ex1-10D-lcwgs-1-1.clmp.r1r2_fastp		1.1%	44.4%	99.4%	0.5%
Zdi-CDup_043-Ex1-10E-lcwgs-1-1.clmp.r1r2_fastp		1.8%	45.6%	99.2%	0.5%
Zdi-CDup_044-Ex1-10F-lcwgs-1-1.clmp.r1r2_fastp		0.9%	44.9%	99.4%	0.6%
Zdi-CDup_045-Ex1-10G-lcwgs-1-1.clmp.r1r2_fastp		1.0%	43.6%	99.3%	0.7%
Zdi-CDup_046-Ex1-10H-lcwgs-1-1.clmp.r1r2_fastp		1.0%	44.1%	99.2%	0.8%
Zdi-CDup_047-Ex1-11A-lcwgs-1-1.clmp.r1r2_fastp		0.8%	44.0%	99.4%	0.6%
Zdi-CDup_048-Ex1-11B-lcwgs-1-1.clmp.r1r2_fastp		0.9%	44.3%	99.4%	0.7%
Zdi-CDup_049-Ex1-11C-lcwgs-1-1.clmp.r1r2_fastp		0.8%	44.3%	99.4%	0.7%
Zdi-CDup_050-Ex1-11D-lcwgs-1-1.clmp.r1r2_fastp		0.8%	44.8%	99.4%	0.7%
Zdi-CDup_051-Ex1-11E-lcwgs-1-1.clmp.r1r2_fastp		1.0%	44.9%	99.0%	1.0%
Zdi-CDup_053-Ex1-11F-lcwgs-1-1.clmp.r1r2_fastp		0.9%	44.2%	99.0%	1.0%
Zdi-CDup_054-Ex1-11G-lcwgs-1-1.clmp.r1r2_fastp		0.5%	45.1%	99.4%	0.7%
Zdi-CDup_055-Ex1-11H-lcwgs-1-1.clmp.r1r2_fastp		0.8%	44.2%	99.4%	0.8%
Zdi-CDup_056-Ex1-12A-lcwgs-1-1.clmp.r1r2_fastp		2.5%	43.3%	99.2%	0.4%
Zdi-CDup_057-Ex1-12B-lcwgs-1-1.clmp.r1r2_fastp		1.7%	44.3%	99.1%	0.7%
Zdi-CDup_058-Ex1-12C-lcwgs-1-1.clmp.r1r2_fastp		0.9%	44.0%	99.4%	0.6%
Zdi-CDup_059-Ex1-12D-lcwgs-1-1.clmp.r1r2_fastp		2.1%	43.8%	99.0%	0.7%
Zdi-CDup_060-Ex1-12E-lcwgs-1-1.clmp.r1r2_fastp		0.9%	44.0%	99.0%	1.0%
Zdi-CDup_061-Ex1-12F-lcwgs-1-1.clmp.r1r2_fastp		0.8%	44.4%	99.4%	0.6%
Zdi-CDup_062-Ex1-12G-lcwgs-1-1.clmp.r1r2_fastp		0.8%	43.7%	99.4%	0.7%
Zdi-CDup_064-Ex1-5A-lcwgs-1-1.clmp.r1r2_fastp		2.1%	42.0%	99.4%	0.4%
Zdi-CDup_065-Ex1-5B-lcwgs-1-1.clmp.r1r2_fastp		1.4%	42.9%	99.4%	0.5%
Zdi-CDup_066-Ex1-5C-lcwgs-1-1.clmp.r1r2_fastp		1.1%	49.0%	99.3%	0.6%
Zdi-CDup_071-Ex1-12H-lcwgs-1-1.clmp.r1r2_fastp		1.4%	43.9%	99.3%	0.6%
```
</p>
</details>

</p>

---
</details>

<details><summary>11. Decontaminate files (*)</summary>
<p>

## 11. Decontaminate files (*)

<details><summary>11a. Run fastq_screen</summary>
	
### 11a. Run fastq_screen

```
[hpc-0356@wahab-01 1st_sequencing_run]$ bash
[hpc-0356@wahab-01 1st_sequencing_run]$ fqScrnPATH=/home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFQSCRN_6.bash
indir=fq_fp1_clmp_fp2
[hpc-0356@wahab-01 1st_sequencing_run]$ outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
nodes=20
[hpc-0356@wahab-01 1st_sequencing_run]$ bash $fqScrnPATH $indir $outdir $nodes
```
---

</details>

<details><summary>11b. Check for Errors</summary>
	
### 11b. Check for Errors

```
[hpc-0356@wahab-01 1st_sequencing_run]$ outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
[hpc-0356@wahab-01 1st_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/validateFQ.sbatch $outdir "*filter.fastq.gz"

# when complete check the $outdir/fqValidateReport.txt file
less -S $outdir/fqValidationReport.txt file
```
#### Confirm files were succesfully completed:
* ***one file was not***

```
[hpc-0356@wahab-01 1st_sequencing_run]$ bash
[hpc-0356@wahab-01 1st_sequencing_run]$ indir=fq_fp1_clmp_fp2
[hpc-0356@wahab-01 1st_sequencing_run]$ outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
```
Check that all 5 files were created for each fqgz file:
```
[hpc-0356@wahab-01 1st_sequencing_run]$ ls $outdir/*r1.tagged.fastq.gz | wc -l
					ls $outdir/*r2.tagged.fastq.gz | wc -l
					ls $outdir/*r1.tagged_filter.fastq.gz | wc -l
					ls $outdir/*r2.tagged_filter.fastq.gz | wc -l 
					ls $outdir/*r1_screen.txt | wc -l
					ls $outdir/*r2_screen.txt | wc -l
					ls $outdir/*r1_screen.png | wc -l
					ls $outdir/*r2_screen.png | wc -l
					ls $outdir/*r1_screen.html | wc -l
					ls $outdir/*r2_screen.html | wc -l
111
110
111  
110
111
111
111
111
111
110
```
For each, you should have the same number as the number of input files (number of fq.gz files):
```
[hpc-0356@wahab-01 1st_sequencing_run]$ ls $indir/*r1.fq.gz | wc -l
					ls $indir/*r2.fq.gz | wc -l
111
111
```
Check for any errors in the `*out` files: (none)
```
[hpc-0356@wahab-01 1st_sequencing_run]$ grep 'error' slurm-fqscrn.*out
					grep 'No reads in' slurm-fqscrn.*out
					grep 'FATAL' slurm-fqscrn.*out
```
Looked at the outfiles to see if there are any unzipped files with the word temp, which means that the job didn't finish and needs to be rerun:
* **One hit:** `Zdi-ADup_003-Ex1-9H-lcwgs-1-1.clmp.fp2_r2.fq.gz_temp_subset.fastq`
```
[hpc-0356@wahab-01 1st_sequencing_run]$ outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
					ls $outdir/*temp*
/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn/Zdi-ADup_003-Ex1-9H-lcwgs-1-1.clmp.fp2_r2.fq.gz_temp_subset.fastq
```
---

</details>

<details><summary>11d. Rerun Files That Failed</summary>
	
### 11d. Rerun Files That Failed
I had run into some issues with this portion of code.

<details><summary>To see what went wrong and how it was fixed:</summary>
<p>

I started by running these lines:
```
[hpc-0356@wahab-01 1st_sequencing_run]$ bash
					outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
					ls $outdir/*temp* | sed 's/^nowga.*\///' | sed 's/_temp_subset\.fastq//' > fqscrn_files_to_rerun_temp.txt
					cat fqscrn_files_to_rerun_temp.txt

#output
/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn/Zdi-ADup_003-Ex1-9H-lcwgs-1-1.clmp.fp2_r2.fq.gz
```

Then these:
```
ls $outdir/*temp*
rm $outdir/*temp*

#output
/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn/Zdi-ADup_003-Ex1-9H-lcwgs-1-1.clmp.fp2_r2.fq.gz_temp_subset.fastq
```

Then these:
```
[hpc-0356@wahab-01 1st_sequencing_run]$ cat fqscrn_files_to_rerun_noreads.txt fqscrn_files_to_rerun_fatal.txt fqscrn_files_to_rerun_temp.txt | sort | unique > fqscrn_files_to_rerun.txt
					indir="fq_fp1_clmp_fp2"
					outdir="/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn"
					nodes=1
					rerun_file=fqscrn_files_to_rerun.txt

#output
bash: unique: command not found
cat: fqscrn_files_to_rerun_noreads.txt: No such file or directory
cat: fqscrn_files_to_rerun_fatal.txt: No such file or directory
```

Because of these error messages, I reran the first lines to see if the file would still come up:
```
[hpc-0356@wahab-01 1st_sequencing_run]$ outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
					ls $outdir/*temp* | sed 's/^nowga.*\///' | sed 's/_temp_subset\.fastq//' > fqscrn_files_to_rerun_temp.txt

#output
ls: cannot access '/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn/*temp*': No such file or directory
```
It seemed the file had been deleted.
Thanks to Jem, she offered this solution:
```
[hpc-0356@wahab-01 1st_sequencing_run]$ nano fqscrn_files_to_rerun.txt

#within the txt file, copy and paste the name of the missing file: Zdi-ADup_003-Ex1-9H-lcwgs-1-1.clmp.fp2_r2.fq.gz
#exit and save
```

</p>
</details>

Correct code (thanks to Jem):
```
[hpc-0356@wahab-01 1st_sequencing_run]$ bash
[hpc-0356@wahab-01 1st_sequencing_run]$ indir="fq_fp1_clmp_fp2"
					outdir="/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn"
					nodes=1
					rerun_file=fqscrn_files_to_rerun.txt
[hpc-0356@wahab-01 1st_sequencing_run]$ while read -r fqfile; do
  						sbatch --wrap="bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFQSCRN_6.bash $indir $outdir $nodes $fqfile"
					done < $rerun_file
```
Check that it has been rerun:
```
[hpc-0356@wahab-01 1st_sequencing_run]$ bash
[hpc-0356@wahab-01 1st_sequencing_run]$ indir=fq_fp1_clmp_fp2
[hpc-0356@wahab-01 1st_sequencing_run]$ outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
[hpc-0356@wahab-01 1st_sequencing_run]$ ls $outdir/*r1.tagged.fastq.gz | wc -l
					ls $outdir/*r2.tagged.fastq.gz | wc -l
					ls $outdir/*r1.tagged_filter.fastq.gz | wc -l
					ls $outdir/*r2.tagged_filter.fastq.gz | wc -l 
					ls $outdir/*r1_screen.txt | wc -l
					ls $outdir/*r2_screen.txt | wc -l
					ls $outdir/*r1_screen.png | wc -l
					ls $outdir/*r2_screen.png | wc -l
					ls $outdir/*r1_screen.html | wc -l
					ls $outdir/*r2_screen.html | wc -l
111
111
111
111
111
111
111
111
111
111
```

---

</details>

<details><summary>11e. Move output files</summary>
	
### 11e. Move output files

```
outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
fqscrndir=fq_fp1_clmp_fp2_fqscrn
mkdir $fqscrndir
screen mv $outdir $fqscrndir
```
---
</details>

<details><summary>11f. Run MultiQC (*)</summary>
	
### 11f. Run MultiQC (*)

```
[hpc-0356@wahab-01 1st_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runMULTIQC.sbatch fq_fp1_clmp_fp2_fqscrn fastq_screen_report
```
#### Review the MultiQC output (fq_fp1_clmp_fp2_fqscrn/fastq_screen_report.html):
FastQ Screen: Mapped Reads:

* multiple genomes were the largest hit between both Albatross and Contemporary samples (around 3-5% in contemporary; 2-4% albatross)
* there were 3 Albatross samples that did not have as high of a percentage in the "No hits" catergory. The three samples seem to have bacterial contamination:
	* `Zdi-ADup_012-Ex1-11A`: bacteria 21.7%
 	* `Zdi-ADup_013-Ex1-12F`: bacteria 11.1%
 	* `Zdi-ADup_024-Ex1-12E`: bacteria 7.7%
 
```
‣ no hits -
	• Alb: 90.6-97%, 3 samples were much lower: 67.6%, 74.1%, and 82.3%, respectively
	• Contemp: 93.3-96.1%
```

</details>

---


</details>

<details><summary>12. Repair FASTQ Files Messed Up by FASTQ_SCREEN (*)</summary>
<p>

## 12. Repair FASTQ Files Messed Up by FASTQ_SCREEN (*)

#### Execute `runREPAIR.sbatch`

```
[hpc-0356@wahab-01 1st_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runREPAIR.sbatch fq_fp1_clmp_fp2_fqscrn fq_fp1_clmp_fp2_fqscrn_rprd 5
```

```
[hpc-0356@wahab-01 1st_sequencing_run]$ bash
[hpc-0356@wahab-01 1st_sequencing_run]$ SCRIPT=/home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/validateFQPE.sbatch
					DIR=fq_fp1_clmp_fp2_fqscrn_rprd
					fqPATTERN="*fq.gz"
[hpc-0356@wahab-01 1st_sequencing_run]$ sbatch $SCRIPT $DIR $fqPATTERN
```

#### Run `Multi_FASTQC`
```
[hpc-0356@wahab-01 1st_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh "./fq_fp1_clmp_fp2_fqscrn_rprd" "fqc_rprd_report" "fq.gz"
```

#### Review MultiQC output (fq_fp1_clmp_fp2_fqscrn_rprd/fastqc_report.html):
* per base sequence content: about half not passing- variation between 1-10 bp
* per sequence GC content: about one-fifth not passing (mainly albatross samples)
	* 1 fail was `Zdi-ADup_012-Ex1-11A-lcwgs-1-1.clmp.fp2_repr.R1`, likely bacterial contamination
* sequence length distribution: warning for all samples

```
‣ % duplication -
	• Alb: 0.4-3%
	• Contemp: 0.5-3%
‣ GC content -
	• Alb: 36-51%
	• Contemp: 41-48%
‣ number of reads -
	• Alb: 0-34.5 mil
	• Contemp: 0-7 mil
```

<details><summary>* Multi_FASTQC Report:</summary>
<p>
  
```

Sample Name	                              % Dups	% GC	Length	M Seqs
Zdi-ADup_001-Ex1-11B-lcwgs-1-1.clmp.fp2_repr.R1	2.1%	40%	94 bp	14.2
Zdi-ADup_001-Ex1-11B-lcwgs-1-1.clmp.fp2_repr.R2	2.3%	40%	94 bp	14.2
Zdi-ADup_002-Ex1-9G-lcwgs-1-1.clmp.fp2_repr.R1	1.0%	40%	83 bp	13.7
Zdi-ADup_002-Ex1-9G-lcwgs-1-1.clmp.fp2_repr.R2	1.0%	40%	83 bp	13.7
Zdi-ADup_003-Ex1-9H-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	41%	82 bp	15.3
Zdi-ADup_003-Ex1-9H-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	40%	82 bp	15.3
Zdi-ADup_004-Ex1-10A-lcwgs-1-1.clmp.fp2_repr.R1	0.5%	39%	77 bp	0.0
Zdi-ADup_004-Ex1-10A-lcwgs-1-1.clmp.fp2_repr.R2	0.5%	39%	77 bp	0.0
Zdi-ADup_005-Ex1-10B-lcwgs-1-1.clmp.fp2_repr.R1	0.8%	40%	77 bp	0.7
Zdi-ADup_005-Ex1-10B-lcwgs-1-1.clmp.fp2_repr.R2	0.8%	40%	77 bp	0.7
Zdi-ADup_006-Ex1-10C-lcwgs-1-1.clmp.fp2_repr.R1	1.3%	39%	93 bp	18.2
Zdi-ADup_006-Ex1-10C-lcwgs-1-1.clmp.fp2_repr.R2	1.4%	39%	93 bp	18.2
Zdi-ADup_007-Ex1-10D-lcwgs-1-1.clmp.fp2_repr.R1	2.1%	43%	80 bp	17.2
Zdi-ADup_007-Ex1-10D-lcwgs-1-1.clmp.fp2_repr.R2	2.1%	43%	80 bp	17.2
Zdi-ADup_008-Ex1-10E-lcwgs-1-1.clmp.fp2_repr.R1	1.1%	37%	91 bp	3.0
Zdi-ADup_008-Ex1-10E-lcwgs-1-1.clmp.fp2_repr.R2	1.3%	37%	90 bp	3.0
Zdi-ADup_009-Ex1-10F-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	42%	80 bp	0.8
Zdi-ADup_009-Ex1-10F-lcwgs-1-1.clmp.fp2_repr.R2	0.7%	42%	80 bp	0.8
Zdi-ADup_010-Ex1-10G-lcwgs-1-1.clmp.fp2_repr.R1	1.0%	41%	86 bp	0.2
Zdi-ADup_010-Ex1-10G-lcwgs-1-1.clmp.fp2_repr.R2	1.0%	41%	86 bp	0.2
Zdi-ADup_011-Ex1-10H-lcwgs-1-1.clmp.fp2_repr.R1	1.1%	41%	84 bp	13.5
Zdi-ADup_011-Ex1-10H-lcwgs-1-1.clmp.fp2_repr.R2	1.2%	41%	84 bp	13.5
Zdi-ADup_012-Ex1-11A-lcwgs-1-1.clmp.fp2_repr.R1	2.9%	51%	118 bp	0.2
Zdi-ADup_012-Ex1-11A-lcwgs-1-1.clmp.fp2_repr.R2	3.0%	51%	118 bp	0.2
Zdi-ADup_013-Ex1-12F-lcwgs-1-1.clmp.fp2_repr.R1	1.1%	47%	96 bp	0.9
Zdi-ADup_013-Ex1-12F-lcwgs-1-1.clmp.fp2_repr.R2	1.2%	47%	96 bp	0.9
Zdi-ADup_014-Ex1-11C-lcwgs-1-1.clmp.fp2_repr.R1	2.0%	45%	90 bp	5.5
Zdi-ADup_014-Ex1-11C-lcwgs-1-1.clmp.fp2_repr.R2	2.2%	45%	90 bp	5.5
Zdi-ADup_015-Ex1-11D-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	41%	83 bp	12.1
Zdi-ADup_015-Ex1-11D-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	41%	83 bp	12.1
Zdi-ADup_016-Ex1-11E-lcwgs-1-1.clmp.fp2_repr.R1	1.7%	38%	93 bp	18.7
Zdi-ADup_016-Ex1-11E-lcwgs-1-1.clmp.fp2_repr.R2	1.9%	38%	92 bp	18.7
Zdi-ADup_017-Ex1-11F-lcwgs-1-1.clmp.fp2_repr.R1	1.1%	42%	83 bp	11.4
Zdi-ADup_017-Ex1-11F-lcwgs-1-1.clmp.fp2_repr.R2	1.1%	42%	83 bp	11.4
Zdi-ADup_018-Ex1-11G-lcwgs-1-1.clmp.fp2_repr.R1	1.4%	42%	86 bp	18.1
Zdi-ADup_018-Ex1-11G-lcwgs-1-1.clmp.fp2_repr.R2	1.5%	42%	86 bp	18.1
Zdi-ADup_019-Ex1-11H-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	39%	86 bp	3.5
Zdi-ADup_019-Ex1-11H-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	39%	86 bp	3.5
Zdi-ADup_020-Ex1-12A-lcwgs-1-1.clmp.fp2_repr.R1	0.5%	43%	100 bp	0.0
Zdi-ADup_020-Ex1-12A-lcwgs-1-1.clmp.fp2_repr.R2	0.5%	43%	100 bp	0.0
Zdi-ADup_021-Ex1-12B-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	41%	92 bp	0.1
Zdi-ADup_021-Ex1-12B-lcwgs-1-1.clmp.fp2_repr.R2	0.7%	41%	92 bp	0.1
Zdi-ADup_022-Ex1-12C-lcwgs-1-1.clmp.fp2_repr.R1	1.8%	40%	84 bp	34.5
Zdi-ADup_022-Ex1-12C-lcwgs-1-1.clmp.fp2_repr.R2	1.9%	40%	84 bp	34.5
Zdi-ADup_023-Ex1-12D-lcwgs-1-1.clmp.fp2_repr.R1	1.0%	42%	85 bp	4.7
Zdi-ADup_023-Ex1-12D-lcwgs-1-1.clmp.fp2_repr.R2	1.0%	42%	85 bp	4.7
Zdi-ADup_024-Ex1-12E-lcwgs-1-1.clmp.fp2_repr.R1	1.6%	45%	82 bp	2.8
Zdi-ADup_024-Ex1-12E-lcwgs-1-1.clmp.fp2_repr.R2	1.7%	45%	81 bp	2.8
Zdi-ADup_025-Ex1-2A-lcwgs-1-1.clmp.fp2_repr.R1	0.6%	38%	75 bp	0.1
Zdi-ADup_025-Ex1-2A-lcwgs-1-1.clmp.fp2_repr.R2	0.6%	38%	75 bp	0.1
Zdi-ADup_026-Ex1-12G-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	44%	76 bp	1.0
Zdi-ADup_026-Ex1-12G-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	44%	76 bp	1.0
Zdi-ADup_027-Ex1-12H-lcwgs-1-1.clmp.fp2_repr.R1	1.9%	45%	78 bp	20.5
Zdi-ADup_027-Ex1-12H-lcwgs-1-1.clmp.fp2_repr.R2	1.9%	45%	78 bp	20.5
Zdi-ADup_028-Ex1-9F-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	39%	77 bp	8.3
Zdi-ADup_028-Ex1-9F-lcwgs-1-1.clmp.fp2_repr.R2	0.7%	39%	77 bp	8.3
Zdi-ADup_029-Ex1-1A-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	39%	102 bp	0.0
Zdi-ADup_029-Ex1-1A-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	39%	102 bp	0.0
Zdi-ADup_030-Ex1-1B-lcwgs-1-1.clmp.fp2_repr.R1	1.0%	38%	85 bp	0.1
Zdi-ADup_030-Ex1-1B-lcwgs-1-1.clmp.fp2_repr.R2	1.1%	38%	85 bp	0.1
Zdi-ADup_031-Ex1-1C-lcwgs-1-1.clmp.fp2_repr.R1	1.8%	39%	98 bp	0.2
Zdi-ADup_031-Ex1-1C-lcwgs-1-1.clmp.fp2_repr.R2	1.8%	39%	98 bp	0.2
Zdi-ADup_032-Ex1-1D-lcwgs-1-1.clmp.fp2_repr.R1	2.5%	42%	94 bp	2.0
Zdi-ADup_032-Ex1-1D-lcwgs-1-1.clmp.fp2_repr.R2	2.6%	42%	94 bp	2.0
Zdi-ADup_033-Ex1-1E-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	37%	83 bp	0.3
Zdi-ADup_033-Ex1-1E-lcwgs-1-1.clmp.fp2_repr.R2	0.7%	37%	83 bp	0.3
Zdi-ADup_034-Ex1-1F-lcwgs-1-1.clmp.fp2_repr.R1	0.8%	38%	90 bp	0.3
Zdi-ADup_034-Ex1-1F-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	38%	90 bp	0.3
Zdi-ADup_035-Ex1-1G-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	37%	76 bp	1.1
Zdi-ADup_035-Ex1-1G-lcwgs-1-1.clmp.fp2_repr.R2	0.7%	37%	76 bp	1.1
Zdi-ADup_036-Ex1-1H-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	38%	84 bp	0.3
Zdi-ADup_036-Ex1-1H-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	38%	84 bp	0.3
Zdi-ADup_037-Ex1-3D-lcwgs-1-1.clmp.fp2_repr.R1	0.6%	36%	90 bp	0.2
Zdi-ADup_037-Ex1-3D-lcwgs-1-1.clmp.fp2_repr.R2	0.6%	36%	90 bp	0.2
Zdi-ADup_038-Ex1-2B-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	37%	83 bp	0.1
Zdi-ADup_038-Ex1-2B-lcwgs-1-1.clmp.fp2_repr.R2	0.8%	37%	83 bp	0.1
Zdi-ADup_039-Ex1-2C-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	37%	93 bp	0.2
Zdi-ADup_039-Ex1-2C-lcwgs-1-1.clmp.fp2_repr.R2	0.7%	37%	93 bp	0.2
Zdi-ADup_040-Ex1-2D-lcwgs-1-1.clmp.fp2_repr.R1	0.6%	37%	90 bp	0.3
Zdi-ADup_040-Ex1-2D-lcwgs-1-1.clmp.fp2_repr.R2	0.7%	37%	90 bp	0.3
Zdi-ADup_041-Ex1-2E-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	37%	90 bp	0.1
Zdi-ADup_041-Ex1-2E-lcwgs-1-1.clmp.fp2_repr.R2	0.7%	37%	90 bp	0.1
Zdi-ADup_042-Ex1-2F-lcwgs-1-1.clmp.fp2_repr.R1	1.4%	37%	86 bp	15.1
Zdi-ADup_042-Ex1-2F-lcwgs-1-1.clmp.fp2_repr.R2	1.6%	37%	86 bp	15.1
Zdi-ADup_043-Ex1-2G-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	37%	84 bp	1.1
Zdi-ADup_043-Ex1-2G-lcwgs-1-1.clmp.fp2_repr.R2	0.8%	37%	84 bp	1.1
Zdi-ADup_044-Ex1-2H-lcwgs-1-1.clmp.fp2_repr.R1	1.4%	36%	82 bp	6.6
Zdi-ADup_044-Ex1-2H-lcwgs-1-1.clmp.fp2_repr.R2	1.5%	36%	82 bp	6.6
Zdi-ADup_045-Ex1-3A-lcwgs-1-1.clmp.fp2_repr.R1	0.4%	37%	73 bp	0.3
Zdi-ADup_045-Ex1-3A-lcwgs-1-1.clmp.fp2_repr.R2	0.4%	37%	73 bp	0.3
Zdi-ADup_046-Ex1-3B-lcwgs-1-1.clmp.fp2_repr.R1	0.6%	36%	83 bp	0.1
Zdi-ADup_046-Ex1-3B-lcwgs-1-1.clmp.fp2_repr.R2	0.6%	36%	83 bp	0.1
Zdi-ADup_047-Ex1-3C-lcwgs-1-1.clmp.fp2_repr.R1	2.2%	38%	80 bp	1.5
Zdi-ADup_047-Ex1-3C-lcwgs-1-1.clmp.fp2_repr.R2	2.3%	38%	80 bp	1.5
Zdi-CDup_001-Ex1-5D-lcwgs-1-1.clmp.fp2_repr.R1	1.4%	45%	96 bp	1.2
Zdi-CDup_001-Ex1-5D-lcwgs-1-1.clmp.fp2_repr.R2	1.6%	45%	96 bp	1.2
Zdi-CDup_002-Ex1-5E-lcwgs-1-1.clmp.fp2_repr.R1	1.1%	44%	101 bp	0.1
Zdi-CDup_002-Ex1-5E-lcwgs-1-1.clmp.fp2_repr.R2	1.1%	44%	101 bp	0.1
Zdi-CDup_003-Ex1-5F-lcwgs-1-1.clmp.fp2_repr.R1	1.6%	46%	99 bp	0.7
Zdi-CDup_003-Ex1-5F-lcwgs-1-1.clmp.fp2_repr.R2	1.8%	45%	98 bp	0.7
Zdi-CDup_004-Ex1-5G-lcwgs-1-1.clmp.fp2_repr.R1	1.4%	44%	101 bp	0.1
Zdi-CDup_004-Ex1-5G-lcwgs-1-1.clmp.fp2_repr.R2	1.4%	44%	101 bp	0.1
Zdi-CDup_005-Ex1-5H-lcwgs-1-1.clmp.fp2_repr.R1	2.1%	44%	112 bp	2.2
Zdi-CDup_005-Ex1-5H-lcwgs-1-1.clmp.fp2_repr.R2	2.2%	44%	112 bp	2.2
Zdi-CDup_006-Ex1-6A-lcwgs-1-1.clmp.fp2_repr.R1	2.3%	43%	117 bp	4.8
Zdi-CDup_006-Ex1-6A-lcwgs-1-1.clmp.fp2_repr.R2	2.6%	43%	116 bp	4.8
Zdi-CDup_007-Ex1-6B-lcwgs-1-1.clmp.fp2_repr.R1	1.0%	44%	94 bp	1.2
Zdi-CDup_007-Ex1-6B-lcwgs-1-1.clmp.fp2_repr.R2	1.1%	44%	94 bp	1.2
Zdi-CDup_008-Ex1-6C-lcwgs-1-1.clmp.fp2_repr.R1	1.1%	43%	109 bp	0.5
Zdi-CDup_008-Ex1-6C-lcwgs-1-1.clmp.fp2_repr.R2	1.1%	43%	108 bp	0.5
Zdi-CDup_010-Ex1-6D-lcwgs-1-1.clmp.fp2_repr.R1	1.7%	44%	111 bp	3.6
Zdi-CDup_010-Ex1-6D-lcwgs-1-1.clmp.fp2_repr.R2	1.9%	44%	110 bp	3.6
Zdi-CDup_011-Ex1-6E-lcwgs-1-1.clmp.fp2_repr.R1	1.5%	43%	111 bp	2.6
Zdi-CDup_011-Ex1-6E-lcwgs-1-1.clmp.fp2_repr.R2	1.5%	43%	110 bp	2.6
Zdi-CDup_012-Ex1-6F-lcwgs-1-1.clmp.fp2_repr.R1	1.9%	45%	105 bp	0.6
Zdi-CDup_012-Ex1-6F-lcwgs-1-1.clmp.fp2_repr.R2	2.1%	44%	105 bp	0.6
Zdi-CDup_013-Ex1-6G-lcwgs-1-1.clmp.fp2_repr.R1	1.1%	42%	111 bp	0.3
Zdi-CDup_013-Ex1-6G-lcwgs-1-1.clmp.fp2_repr.R2	1.1%	42%	111 bp	0.3
Zdi-CDup_014-Ex1-6H-lcwgs-1-1.clmp.fp2_repr.R1	1.0%	43%	95 bp	3.5
Zdi-CDup_014-Ex1-6H-lcwgs-1-1.clmp.fp2_repr.R2	1.1%	43%	95 bp	3.5
Zdi-CDup_015-Ex1-7A-lcwgs-1-1.clmp.fp2_repr.R1	0.8%	43%	105 bp	0.3
Zdi-CDup_015-Ex1-7A-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	43%	105 bp	0.3
Zdi-CDup_016-Ex1-7B-lcwgs-1-1.clmp.fp2_repr.R1	1.2%	44%	94 bp	2.6
Zdi-CDup_016-Ex1-7B-lcwgs-1-1.clmp.fp2_repr.R2	1.3%	44%	94 bp	2.6
Zdi-CDup_017-Ex1-7C-lcwgs-1-1.clmp.fp2_repr.R1	0.8%	44%	95 bp	0.7
Zdi-CDup_017-Ex1-7C-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	44%	95 bp	0.7
Zdi-CDup_018-Ex1-7D-lcwgs-1-1.clmp.fp2_repr.R1	2.1%	46%	106 bp	2.4
Zdi-CDup_018-Ex1-7D-lcwgs-1-1.clmp.fp2_repr.R2	2.4%	46%	105 bp	2.4
Zdi-CDup_019-Ex1-7E-lcwgs-1-1.clmp.fp2_repr.R1	1.3%	43%	102 bp	4.5
Zdi-CDup_019-Ex1-7E-lcwgs-1-1.clmp.fp2_repr.R2	1.4%	43%	102 bp	4.5
Zdi-CDup_020-Ex1-7F-lcwgs-1-1.clmp.fp2_repr.R1	1.3%	43%	97 bp	0.1
Zdi-CDup_020-Ex1-7F-lcwgs-1-1.clmp.fp2_repr.R2	1.3%	43%	97 bp	0.1
Zdi-CDup_021-Ex1-7G-lcwgs-1-1.clmp.fp2_repr.R1	1.2%	43%	101 bp	5.0
Zdi-CDup_021-Ex1-7G-lcwgs-1-1.clmp.fp2_repr.R2	1.4%	43%	101 bp	5.0
Zdi-CDup_022-Ex1-7H-lcwgs-1-1.clmp.fp2_repr.R1	0.8%	42%	95 bp	0.7
Zdi-CDup_022-Ex1-7H-lcwgs-1-1.clmp.fp2_repr.R2	0.8%	42%	95 bp	0.7
Zdi-CDup_023-Ex1-8A-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	43%	102 bp	0.1
Zdi-CDup_023-Ex1-8A-lcwgs-1-1.clmp.fp2_repr.R2	0.8%	43%	102 bp	0.1
Zdi-CDup_024-Ex1-8B-lcwgs-1-1.clmp.fp2_repr.R1	1.3%	44%	102 bp	0.0
Zdi-CDup_024-Ex1-8B-lcwgs-1-1.clmp.fp2_repr.R2	1.3%	44%	102 bp	0.0
Zdi-CDup_025-Ex1-8C-lcwgs-1-1.clmp.fp2_repr.R1	1.0%	43%	95 bp	0.1
Zdi-CDup_025-Ex1-8C-lcwgs-1-1.clmp.fp2_repr.R2	1.0%	43%	95 bp	0.1
Zdi-CDup_026-Ex1-8D-lcwgs-1-1.clmp.fp2_repr.R1	1.0%	44%	96 bp	0.5
Zdi-CDup_026-Ex1-8D-lcwgs-1-1.clmp.fp2_repr.R2	1.0%	44%	96 bp	0.5
Zdi-CDup_027-Ex1-8E-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	43%	95 bp	0.0
Zdi-CDup_027-Ex1-8E-lcwgs-1-1.clmp.fp2_repr.R2	0.8%	43%	95 bp	0.0
Zdi-CDup_028-Ex1-8F-lcwgs-1-1.clmp.fp2_repr.R1	1.9%	44%	107 bp	0.1
Zdi-CDup_028-Ex1-8F-lcwgs-1-1.clmp.fp2_repr.R2	1.9%	44%	107 bp	0.1
Zdi-CDup_029-Ex1-8G-lcwgs-1-1.clmp.fp2_repr.R1	1.5%	42%	110 bp	0.1
Zdi-CDup_029-Ex1-8G-lcwgs-1-1.clmp.fp2_repr.R2	1.5%	42%	110 bp	0.1
Zdi-CDup_030-Ex1-8H-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	43%	100 bp	0.0
Zdi-CDup_030-Ex1-8H-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	43%	99 bp	0.0
Zdi-CDup_031-Ex1-9A-lcwgs-1-1.clmp.fp2_repr.R1	1.5%	43%	102 bp	2.7
Zdi-CDup_031-Ex1-9A-lcwgs-1-1.clmp.fp2_repr.R2	1.7%	43%	101 bp	2.7
Zdi-CDup_032-Ex1-9B-lcwgs-1-1.clmp.fp2_repr.R1	1.7%	44%	95 bp	0.2
Zdi-CDup_032-Ex1-9B-lcwgs-1-1.clmp.fp2_repr.R2	1.8%	44%	95 bp	0.2
Zdi-CDup_033-Ex1-9C-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	45%	91 bp	0.9
Zdi-CDup_033-Ex1-9C-lcwgs-1-1.clmp.fp2_repr.R2	1.0%	45%	90 bp	0.9
Zdi-CDup_034-Ex1-9D-lcwgs-1-1.clmp.fp2_repr.R1	1.2%	43%	98 bp	2.2
Zdi-CDup_034-Ex1-9D-lcwgs-1-1.clmp.fp2_repr.R2	1.3%	43%	97 bp	2.2
Zdi-CDup_035-Ex1-9E-lcwgs-1-1.clmp.fp2_repr.R1	1.0%	44%	98 bp	0.4
Zdi-CDup_035-Ex1-9E-lcwgs-1-1.clmp.fp2_repr.R2	1.0%	44%	98 bp	0.4
Zdi-CDup_036-Ex1-9F-lcwgs-1-1.clmp.fp2_repr.R1	1.3%	44%	97 bp	0.1
Zdi-CDup_036-Ex1-9F-lcwgs-1-1.clmp.fp2_repr.R2	1.3%	44%	97 bp	0.1
Zdi-CDup_037-Ex1-9G-lcwgs-1-1.clmp.fp2_repr.R1	1.2%	43%	101 bp	0.4
Zdi-CDup_037-Ex1-9G-lcwgs-1-1.clmp.fp2_repr.R2	1.3%	43%	101 bp	0.4
Zdi-CDup_038-Ex1-9H-lcwgs-1-1.clmp.fp2_repr.R1	1.6%	44%	93 bp	0.2
Zdi-CDup_038-Ex1-9H-lcwgs-1-1.clmp.fp2_repr.R2	1.7%	44%	93 bp	0.2
Zdi-CDup_039-Ex1-10A-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	44%	104 bp	0.2
Zdi-CDup_039-Ex1-10A-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	44%	104 bp	0.2
Zdi-CDup_040-Ex1-10B-lcwgs-1-1.clmp.fp2_repr.R1	0.6%	43%	91 bp	0.2
Zdi-CDup_040-Ex1-10B-lcwgs-1-1.clmp.fp2_repr.R2	0.7%	43%	90 bp	0.2
Zdi-CDup_041-Ex1-10C-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	44%	88 bp	0.5
Zdi-CDup_041-Ex1-10C-lcwgs-1-1.clmp.fp2_repr.R2	0.7%	44%	88 bp	0.5
Zdi-CDup_042-Ex1-10D-lcwgs-1-1.clmp.fp2_repr.R1	1.3%	44%	100 bp	2.4
Zdi-CDup_042-Ex1-10D-lcwgs-1-1.clmp.fp2_repr.R2	1.5%	44%	100 bp	2.4
Zdi-CDup_043-Ex1-10E-lcwgs-1-1.clmp.fp2_repr.R1	2.6%	45%	112 bp	4.4
Zdi-CDup_043-Ex1-10E-lcwgs-1-1.clmp.fp2_repr.R2	3.0%	45%	112 bp	4.4
Zdi-CDup_044-Ex1-10F-lcwgs-1-1.clmp.fp2_repr.R1	1.1%	44%	92 bp	0.1
Zdi-CDup_044-Ex1-10F-lcwgs-1-1.clmp.fp2_repr.R2	1.1%	44%	92 bp	0.1
Zdi-CDup_045-Ex1-10G-lcwgs-1-1.clmp.fp2_repr.R1	0.8%	43%	94 bp	0.8
Zdi-CDup_045-Ex1-10G-lcwgs-1-1.clmp.fp2_repr.R2	0.8%	43%	94 bp	0.8
Zdi-CDup_046-Ex1-10H-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	44%	95 bp	0.4
Zdi-CDup_046-Ex1-10H-lcwgs-1-1.clmp.fp2_repr.R2	0.8%	44%	95 bp	0.4
Zdi-CDup_047-Ex1-11A-lcwgs-1-1.clmp.fp2_repr.R1	1.3%	43%	89 bp	7.0
Zdi-CDup_047-Ex1-11A-lcwgs-1-1.clmp.fp2_repr.R2	1.5%	43%	88 bp	7.0
Zdi-CDup_048-Ex1-11B-lcwgs-1-1.clmp.fp2_repr.R1	1.1%	44%	91 bp	0.1
Zdi-CDup_048-Ex1-11B-lcwgs-1-1.clmp.fp2_repr.R2	1.1%	44%	90 bp	0.1
Zdi-CDup_049-Ex1-11C-lcwgs-1-1.clmp.fp2_repr.R1	1.2%	44%	91 bp	0.2
Zdi-CDup_049-Ex1-11C-lcwgs-1-1.clmp.fp2_repr.R2	1.3%	44%	91 bp	0.2
Zdi-CDup_050-Ex1-11D-lcwgs-1-1.clmp.fp2_repr.R1	0.7%	44%	91 bp	0.2
Zdi-CDup_050-Ex1-11D-lcwgs-1-1.clmp.fp2_repr.R2	0.8%	44%	91 bp	0.2
Zdi-CDup_051-Ex1-11E-lcwgs-1-1.clmp.fp2_repr.R1	1.4%	44%	96 bp	0.2
Zdi-CDup_051-Ex1-11E-lcwgs-1-1.clmp.fp2_repr.R2	1.5%	44%	96 bp	0.2
Zdi-CDup_053-Ex1-11F-lcwgs-1-1.clmp.fp2_repr.R1	0.8%	44%	93 bp	0.1
Zdi-CDup_053-Ex1-11F-lcwgs-1-1.clmp.fp2_repr.R2	0.8%	44%	93 bp	0.1
Zdi-CDup_054-Ex1-11G-lcwgs-1-1.clmp.fp2_repr.R1	0.5%	45%	79 bp	0.4
Zdi-CDup_054-Ex1-11G-lcwgs-1-1.clmp.fp2_repr.R2	0.6%	45%	78 bp	0.4
Zdi-CDup_055-Ex1-11H-lcwgs-1-1.clmp.fp2_repr.R1	0.8%	44%	95 bp	0.1
Zdi-CDup_055-Ex1-11H-lcwgs-1-1.clmp.fp2_repr.R2	0.7%	44%	95 bp	0.1
Zdi-CDup_056-Ex1-12A-lcwgs-1-1.clmp.fp2_repr.R1	2.0%	43%	121 bp	4.2
Zdi-CDup_056-Ex1-12A-lcwgs-1-1.clmp.fp2_repr.R2	2.3%	43%	121 bp	4.2
Zdi-CDup_057-Ex1-12B-lcwgs-1-1.clmp.fp2_repr.R1	1.4%	44%	105 bp	0.8
Zdi-CDup_057-Ex1-12B-lcwgs-1-1.clmp.fp2_repr.R2	1.5%	44%	105 bp	0.8
Zdi-CDup_058-Ex1-12C-lcwgs-1-1.clmp.fp2_repr.R1	0.9%	44%	90 bp	3.8
Zdi-CDup_058-Ex1-12C-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	44%	90 bp	3.8
Zdi-CDup_059-Ex1-12D-lcwgs-1-1.clmp.fp2_repr.R1	1.5%	43%	118 bp	0.6
Zdi-CDup_059-Ex1-12D-lcwgs-1-1.clmp.fp2_repr.R2	1.6%	43%	118 bp	0.6
Zdi-CDup_060-Ex1-12E-lcwgs-1-1.clmp.fp2_repr.R1	1.0%	43%	102 bp	0.1
Zdi-CDup_060-Ex1-12E-lcwgs-1-1.clmp.fp2_repr.R2	1.0%	43%	102 bp	0.1
Zdi-CDup_061-Ex1-12F-lcwgs-1-1.clmp.fp2_repr.R1	0.8%	44%	84 bp	1.5
Zdi-CDup_061-Ex1-12F-lcwgs-1-1.clmp.fp2_repr.R2	0.9%	44%	84 bp	1.5
Zdi-CDup_062-Ex1-12G-lcwgs-1-1.clmp.fp2_repr.R1	1.2%	43%	96 bp	0.2
Zdi-CDup_062-Ex1-12G-lcwgs-1-1.clmp.fp2_repr.R2	1.2%	43%	96 bp	0.2
Zdi-CDup_064-Ex1-5A-lcwgs-1-1.clmp.fp2_repr.R1	1.6%	42%	122 bp	1.4
Zdi-CDup_064-Ex1-5A-lcwgs-1-1.clmp.fp2_repr.R2	1.8%	41%	122 bp	1.4
Zdi-CDup_065-Ex1-5B-lcwgs-1-1.clmp.fp2_repr.R1	1.1%	42%	104 bp	0.3
Zdi-CDup_065-Ex1-5B-lcwgs-1-1.clmp.fp2_repr.R2	1.2%	42%	104 bp	0.3
Zdi-CDup_066-Ex1-5C-lcwgs-1-1.clmp.fp2_repr.R1	2.2%	48%	96 bp	2.4
Zdi-CDup_066-Ex1-5C-lcwgs-1-1.clmp.fp2_repr.R2	2.4%	48%	96 bp	2.4
Zdi-CDup_071-Ex1-12H-lcwgs-1-1.clmp.fp2_repr.R1	1.1%	43%	104 bp	0.3
Zdi-CDup_071-Ex1-12H-lcwgs-1-1.clmp.fp2_repr.R2	1.2%	43%	104 bp	0.3

```

</p>
</details>

---

</details>


<details><summary>14. Clean Up</summary>
<p>

## 14. Clean Up
I had a file called "logs" that I had to rename to "logs.out" in order for the following code to work
```
[hpc-0356@wahab-01 1st_sequencing_run]$ mv logs logs.out

[hpc-0356@wahab-01 1st_sequencing_run]$ mkdir logs
[hpc-0356@wahab-01 1st_sequencing_run]$ mv *out logs/
```

---

</details>

<details><summary>17. Generate Number of Mapped Reads</summary>
<p>
	
## 17. Generate Number of Mapped Reads

This step was completed after steps 2-5 had been completed outside of 1. fq.gz pre-processing

<details><summary>Issues that needed to be resolved beforehand:</summary>
<p>

My `config.6.lcwgs` file needed to be edited
</p>
	
```
[hpc-0356@wahab-01 mkBAM_ddocent]$ nano config.6.lcwgs

# within file:
# change Cutoff1 and Cutoff2 to "genbank" and "Zdi"
----------mkREF: Settings for de novo assembly of the reference genome----------------------------------------->
PE              Type of reads for assembly (PE, SE, OL, RPE)                                    PE=ddRAD & ezRA>
0.9             cdhit Clustering_Similarity_Pct (0-1)                                                   Use cdh>
genbank         Cutoff1 (integer)                                                                              >
Zdi             Cutoff2 (integer)                                                                              >
0.05    rainbow merge -r <percentile> (decimal 0-1)                                             Percentile-base>
0.95    rainbow merge -R <percentile> (decimal 0-1)                                             Percentile-base>
--------------------------------------------------------------------------------------------------------------->
```

And then we realized my reference genome `reference.genbank.Zdi.fasta` needed to be unzipped:
```
[hpc-0356@wahab-01 mkBAM_ddocent]$ mv reference.genbank.Zdi.fasta reference.genbank.Zdi.fasta.gz
[hpc-0356@wahab-01 mkBAM_ddocent]$ gunzip reference.genbank.Zdi.fasta.gz
[hpc-0356@wahab-01 mkBAM_ddocent]$ less reference.genbank.Zdi.fasta
```

And I needed to edit the `dDocentHPC.sbatch` file for it to work later:
```
[hpc-0356@wahab-01 mkBAM_ddocent]$ cp ../dDocentHPC/dDocentHPC.sbatch .
[hpc-0356@wahab-01 mkBAM_ddocent]$ nano dDocentHPC.sbatch

# within file:
# change where the "#" is

enable_lmod
# module load container_env ddocent/2.7.8
module load container_env ddocent/2.9.4
```

Now I was able to rereun these:
```
[hpc-0356@wahab-01 mkBAM_ddocent]$ sbatch dDocentHPC.sbatch mkBAM config.6.lcwgs

[hpc-0356@wahab-01 mkBAM_ddocent]$ sbatch dDocentHPC.sbatch fltrBAM config.6.lcwgs
```

But now this wasn't working because `mkBAM` should have been `mkBAM_ddocent`:
```
# not working
# [hpc-0356@wahab-01 mkBAM_ddocent]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/mappedReadStats.sbatch mkBAM mkBAM/coverageMappedReads
```

And this incorrect command made an mkBAM folder with empty files, so I had to edit the code and remove the useless directory.
```
[hpc-0356@wahab-01 mkBAM_ddocent]$ cd ..
[hpc-0356@wahab-01 1st_sequencing_run]$ rm -r mkBAM
```

</details>

Once the issues were resolved, this was run to generate the number of mapped reads:
```
[hpc-0356@wahab-01 1st_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/mappedReadStats.sbatch mkBAM_ddocent mkBAM_ddocent/coverageMappedReads
```

### Results 
* Albatross samples have a lower read length on average: 67-93; Contemporary: 87-122
* Albatross samples have a higher percent of positions with coverage: 0.05-90%; Contemporary: 0.24-46%
	* Albatross was more variable; with a lot of very high and a lot of very low

<details><summary>Table:</summary>
	
| mkBAM_ddocent/FILENAME-lcwgs-1-1.clmp.fp2_repr.genbank.Zdi-RG.bam | numreads | meanreadlength	| meandepth_wcvg | numpos | numpos_wcvg	| meandepth | pctpos_wcvg |	
|-------|-------|-------|-------|-------|-------|-------|-------|
|	Zdi-ADup_012-Ex1-11A	|	14696	|	84.1579	|	1.02561	|	689690477	|	615935	        |	0.000915931	|	0.089306|	
|	Zdi-ADup_004-Ex1-10A 	|	34658	|	73.4785	|	1.03402	|	689690477	|	1238205        	|	0.00185638	|	0.179531|	
|	Zdi-ADup_020-Ex1-12A 	|	10375	|	78.9044	|	1.03822	|	689690477	|	392067	        |	0.000590195	|	0.0568468|	
|	Zdi-ADup_010-Ex1-10G 	|	297879	|	81.5011	|	1.05633	|	689690477	|	11554720        |	0.0176972	|	1.67535 |	
|	Zdi-ADup_013-Ex1-12F 	|	711137	|	82.6016	|	1.08613	|	689690477	|	27351916        |	0.043074	|	3.96582 |	
|	Zdi-ADup_012-Ex1-11A 	|	917248	|	77.3223	|	1.09074	|	689690477	|	31804698        |	0.0502989	|	4.61145 |	
|	Zdi-ADup_009-Ex1-10F 	|	1458797	|	79.2911	|	1.09788	|	689690477	|	52996769        |	0.0843626	|	7.68414 |	
|	Zdi-ADup_021-Ex1-12B 	|	108537	|	85.8067	|	1.04859	|	689690477	|	4481569	        |	0.00681368	|	0.649794|	
|	Zdi-ADup_024-Ex1-12E 	|	484286	|	75.1152	|	1.08434	|	689690477	|	16267172        |	0.0255755	|	2.35862 |	
|	Zdi-ADup_025-Ex1-2A 	|	180191	|	67.3586	|	1.04073	|	689690477	|	5821296        	|	0.00878423	|	0.844045|	
|	Zdi-ADup_026-Ex1-12G 	|	1752885	|	73.4792	|	1.13185	|	689690477	|	56224919        |	0.0922706	|	8.1522  |	
|	Zdi-ADup_008-Ex1-10E 	|	5342219	|	89.0223	|	1.31656	|	689690477	|	183145787       |	0.34961 	|	26.5548 |	
|	Zdi-ADup_029-Ex1-1A 	|	12345	|	72.4896	|	1.0525	|	689690477	|	427981	        |	0.000653119	|	0.0620541|	
|	Zdi-ADup_030-Ex1-1B 	|	120654	|	70.3415	|	1.07239	|	689690477	|	3896754	        |	0.00605901	|	0.565   |	
|	Zdi-ADup_019-Ex1-11H 	|	6520887	|	85.3174	|	1.29428	|	689690477	|	217177151       |	0.407557	|	31.4891	|	
|	Zdi-ADup_031-Ex1-1C 	|	83379	|	73.2353	|	1.1244	|	689690477	|	2609895        	|	0.0042549	|	0.378415|	
|	Zdi-ADup_033-Ex1-1E 	|	348345	|	75.944	|	1.04554	|	689690477	|	12676320        |	0.0192167	|	1.83797	|	
|	Zdi-ADup_014-Ex1-11C 	|	8922231	|	87.9518	|	1.67287	|	689690477	|	239397085       |	0.580667	|	34.7108	|	
|	Zdi-ADup_034-Ex1-1F 	|	321219	|	78.9679	|	1.04204	|	689690477	|	12230047        |	0.0184781	|	1.77327	|	
|	Zdi-ADup_036-Ex1-1H 	|	61249	|	74.6792	|	1.06256	|	689690477	|	2107514 	|	0.00324691	|	0.305574|	
|	Zdi-ADup_037-Ex1-3D 	|	23278	|	76.9498	|	1.10292	|	689690477	|	793745  	|	0.00126932	|	0.115087|	
|	Zdi-ADup_035-Ex1-1G 	|	1871917	|	72.7548	|	1.10687	|	689690477	|	61244940        |	0.0982907	|	8.88006	|	
|	Zdi-ADup_038-Ex1-2B 	|	148805	|	74.7485	|	1.0401	|	689690477	|	5326487        	|	0.0080327	|	0.772301|	
|	Zdi-ADup_039-Ex1-2C 	|	177735	|	81.1506	|	1.04528	|	689690477	|	6946705        	|	0.0105283	|	1.00722	|	
|	Zdi-ADup_023-Ex1-12D 	|	8480718	|	83.8814	|	1.42799	|	689690477	|	250886423       |	0.519455	|	36.3767	|	
|	Zdi-ADup_032-Ex1-1D 	|	3159396	|	90.9115	|	1.24029	|	689690477	|	117586388       |	0.211459	|	17.0492	|	
|	Zdi-ADup_040-Ex1-2D 	|	212386	|	80.3323	|	1.04632	|	689690477	|	8178254        	|	0.0124071	|	1.18579	|	
|	Zdi-ADup_041-Ex1-2E 	|	108499	|	80.7839	|	1.03869	|	689690477	|	4234576        	|	0.00637737	|	0.613982|	
|	Zdi-ADup_045-Ex1-3A 	|	390446	|	68.0604	|	1.03514	|	689690477	|	12799818        |	0.0192109	|	1.85588	|	
|	Zdi-ADup_046-Ex1-3B 	|	81861	|	69.5535	|	1.04608	|	689690477	|	2698100        	|	0.00409231	|	0.391204|	
|	Zdi-ADup_043-Ex1-2G 	|	1908823	|	82.5176	|	1.11171	|	689690477	|	71408825        |	0.115104	|	10.3537	|	
|	Zdi-CDup_002-Ex1-5E 	|	205540	|	100.827	|	1.04169	|	689690477	|	10910980        |	0.0164797	|	1.58201	|	
|	Zdi-ADup_047-Ex1-3C 	|	2331916	|	77.7058	|	1.20373	|	689690477	|	74671561        |	0.130326	|	10.8268	|	
|	Zdi-CDup_001-Ex1-5D 	|	1805557	|	95.7294	|	1.16146	|	689690477	|	80426346        |	0.13544 	|	11.6612	|	
|	Zdi-CDup_004-Ex1-5G 	|	203913	|	100.762	|	1.04951	|	689690477	|	10754430	|	0.0163651	|	1.55931	|	
|	Zdi-CDup_003-Ex1-5F 	|	1037805	|	98.7457	|	1.13335	|	689690477	|	48972011	|	0.0804744	|	7.10058	|	
|	Zdi-CDup_008-Ex1-6C 	|	643811	|	103.802	|	1.0895	|	689690477	|	34692189	|	0.054803	|	5.03011	|	
|	Zdi-ADup_028-Ex1-9F 	|	15438270|	76.901	|	1.62155	|	689690477	|	368438201	|	0.866245	|	53.4208	|	
|	Zdi-ADup_017-Ex1-11F 	|	21085065|	83.0524	|	2.0066	|	689690477	|	439673157	|	1.27919 	|	63.7493	|	
|	Zdi-CDup_007-Ex1-6B 	|	1825651	|	92.5387	|	1.14621	|	689690477	|	77439368	|	0.128698	|	11.2281	|	
|	Zdi-ADup_015-Ex1-11D 	|	22444710|	82.8071	|	1.99604	|	689690477	|	472382152	|	1.36713 	|	68.4919	|	
|	Zdi-CDup_005-Ex1-5H 	|	3400349	|        111.89	|	1.31817	|	689690477	|	161692172	|	0.309034	|	23.4442	|	
|	Zdi-ADup_044-Ex1-2H 	|	11785535|	80.5433	|	1.59258	|	689690477	|	298107780	|	0.688367	|	43.2234	|	
|	Zdi-CDup_012-Ex1-6F 	|	799308	|	102.448	|	1.11366	|	689690477	|	39814886	|	0.0642901	|	5.77286	|	
|	Zdi-CDup_013-Ex1-6G 	|	360383	|	104.583	|	1.05828	|	689690477	|	19922455	|	0.0305696	|	2.88861	|	
|	Zdi-ADup_011-Ex1-10H 	|	25018382|	83.1329	|	2.17179	|	689690477	|	485196510	|	1.52785 	|	70.3499	|	
|	Zdi-ADup_002-Ex1-9G 	|	25558923|	82.5759	|	2.16835	|	689690477	|	491630730	|	1.54566 	|	71.2828	|	
|	Zdi-CDup_015-Ex1-7A 	|	429605	|	103.273	|	1.06191	|	689690477	|	23375747	|	0.0359914	|	3.38931	|	
|	Zdi-ADup_001-Ex1-11B 	|	25518643|	93.0517	|	2.41773	|	689690477	|	503571861	|	1.76529 	|	73.0142	|	
|	Zdi-CDup_010-Ex1-6D 	|	5322710	|	109.73	|	1.46347	|	689690477	|	232757908	|	0.493894	|	33.7482	|	
|	Zdi-CDup_017-Ex1-7C 	|	1053568	|	94.2754	|	1.09729	|	689690477	|	48274846	|	0.0768048	|	6.99949	|	
|	Zdi-CDup_020-Ex1-7F 	|	206157	|	95.069	|	1.04477	|	689690477	|	10087097	|	0.0152803	|	1.46255	|	
|	Zdi-ADup_003-Ex1-9H 	|	28616037|	81.9679	|	2.294	|	689690477	|	516876455	|	1.7192  	|	74.9432	|	
|	Zdi-ADup_007-Ex1-10D 	|	29417478|	79.2359	|	2.51119	|	689690477	|	456560383	|	1.66235 	|	66.1979	|	
|	Zdi-CDup_011-Ex1-6E 	|	4040512	|	110.031	|	1.3178	|	689690477	|	194649526	|	0.371919	|	28.2227	|	
|	Zdi-CDup_006-Ex1-6A 	|	7519600	|	116.278	|	1.60301	|	689690477	|	315070423	|	0.732301	|	45.6829	|	
|	Zdi-CDup_023-Ex1-8A 	|	72820	|	100.694	|	1.02926	|	689690477	|	3929444 	|	0.00586411  	|	0.56974	|	
|	Zdi-CDup_024-Ex1-8B 	|	54052	|	101.201	|	1.04007	|	689690477	|	2918540 	|	0.00440123	|	0.423167|	
|	Zdi-CDup_022-Ex1-7H 	|	1031039	|	94.876	|	1.08308	|	689690477	|	48099991        |	0.0755355	|	6.97414	|	
|	Zdi-CDup_025-Ex1-8C 	|	134225	|	94.7148	|	1.03732	|	689690477	|	6584912 	|	0.00990395	|	0.954763|	
|	Zdi-CDup_027-Ex1-8E 	|	72305	|	93.7512	|	1.02519	|	689690477	|	3582483 	|	0.00532518	|	0.519433|	
|	Zdi-CDup_014-Ex1-6H 	|	5470528	|	94.9394	|	1.33033	|	689690477	|	207745589	|	0.400716	|	30.1216	|	
|	Zdi-ADup_027-Ex1-12H 	|	35390906|	76.8154	|	2.87938	|	689690477	|	453753046	|	1.89437 	|	65.7908	|	
|	Zdi-ADup_006-Ex1-10C 	|	31265867|	89.787	|	2.66112	|	689690477	|	541209189	|	2.08822 	|	78.4713	|	
|	Zdi-CDup_016-Ex1-7B 	|	4074651	|	93.8132	|	1.27298	|	689690477	|	158896843	|	0.29328 	|	23.0389	|	
|	Zdi-CDup_028-Ex1-8F 	|	183893	|	106.742	|	1.05644	|	689690477	|	10582082	|	0.0162092	|	1.53432	|	
|	Zdi-CDup_018-Ex1-7D 	|	3470285	|	105.3	|	1.32153	|	689690477	|	155975841	|	0.298868	|	22.6153	|	
|	Zdi-ADup_018-Ex1-11G 	|	33486104|	85.6873	|	2.74516	|	689690477	|	531395437	|	2.1151  	|	77.0484	|	
|	Zdi-CDup_026-Ex1-8D 	|	813569	|	96.2588	|	1.08558	|	689690477	|	39542470	|	0.0622403	|	5.73336	|	
|	Zdi-CDup_029-Ex1-8G 	|	160085	|	110.231	|	1.04461	|	689690477	|	9617082 	|	0.0145661	|	1.39441	|	
|	Zdi-CDup_030-Ex1-8H 	|	32393	|	97.6132	|	1.02202	|	689690477	|	1669063 	|	0.00247331	|	0.242002|	
|	Zdi-ADup_016-Ex1-11E 	|	34232755|	91.4759	|	2.8904	|	689690477	|	556225761	|	2.33107 	|	80.6486	|	
|	Zdi-CDup_032-Ex1-9B 	|	271462	|	95.1846	|	1.05119	|	689690477	|	13313758	|	0.0202921	|	1.9304	|	
|	Zdi-CDup_036-Ex1-9F 	|	180101	|	97.1545	|	1.04342	|	689690477	|	9203258 	|	0.0139234	|	1.3344	|	
|	Zdi-CDup_038-Ex1-9H 	|	277001	|	93.2062	|	1.04803	|	689690477	|	13204413	|	0.020065	|	1.91454	|	
|	Zdi-CDup_039-Ex1-10A 	|	337639	|	104.027	|	1.05675	|	689690477	|	18554109	|	0.0284288	|	2.69021	|	
|	Zdi-CDup_035-Ex1-9E 	|	603418	|	98.0391	|	1.0742	|	689690477	|	30008739	|	0.0467389	|	4.35104	|	
|	Zdi-CDup_040-Ex1-10B 	|	317639	|	91.0025	|	1.04156	|	689690477	|	14712723	|	0.0222189	|	2.13324	|	
|	Zdi-CDup_044-Ex1-10F 	|	173812	|	92.443	|	1.04042	|	689690477	|	8254437 	|	0.0124521	|	1.19683	|	
|	Zdi-CDup_037-Ex1-9G 	|	650429	|	100.828	|	1.07827	|	689690477	|	33354772	|	0.0521472	|	4.83619	|	
|	Zdi-CDup_033-Ex1-9C 	|	1460868	|	90.7144	|	1.12286	|	689690477	|	62399351	|	0.10159 	|	9.04744	|	
|	Zdi-ADup_042-Ex1-2F 	|	28315200|	85.5221	|	2.43587	|	689690477	|	503209234	|	1.77725 	|	72.9616	|	
|	Zdi-CDup_041-Ex1-10C 	|	754787	|	87.9897	|	1.06981	|	689690477	|	32526171	|	0.0504528	|	4.71605	|	
|	Zdi-CDup_019-Ex1-7E 	|	7193176	|	101.764	|	1.47857	|	689690477	|	273245880	|	0.585789	|	39.6186	|	
|	Zdi-CDup_045-Ex1-10G 	|	1244036	|	94.4726	|	1.09913	|	689690477	|	57612830	|	0.0918151	|	8.35343	|	
|	Zdi-CDup_046-Ex1-10H 	|	626075	|	95.3274	|	1.06766	|	689690477	|	29917963	|	0.0463138	|	4.33788	|	
|	Zdi-CDup_048-Ex1-11B 	|	203197	|	90.8975	|	1.03815	|	689690477	|	9416985 	|	0.0141748	|	1.36539	|	
|	Zdi-CDup_049-Ex1-11C 	|	259601	|	91.3445	|	1.03956	|	689690477	|	12061406	|	0.01818 	|	1.74881	|	
|	Zdi-CDup_053-Ex1-11F 	|	82328	|	93.1639	|	1.02813	|	689690477	|	3974815 	|	0.00592531	|	0.576319|	
|	Zdi-CDup_051-Ex1-11E 	|	254355	|	96.2715	|	1.04936	|	689690477	|	12651983	|	0.0192499	|	1.83444	|	
|	Zdi-CDup_055-Ex1-11H 	|	82748	|	94.995	|	1.02786	|	689690477	|	4097716 	|	0.00610691	|	0.594138|	
|	Zdi-CDup_050-Ex1-11D 	|	361076	|	90.972	|	1.05002	|	689690477	|	16670217	|	0.0253796	|	2.41706	|	
|	Zdi-CDup_054-Ex1-11G 	|	674330	|	78.8493	|	1.05618	|	689690477	|	25555931	|	0.0391359	|	3.70542	|	
|	Zdi-CDup_034-Ex1-9D 	|	3570950	|	97.7348	|	1.23909	|	689690477	|	154456254	|	0.277494	|	22.395	|	
|	Zdi-CDup_031-Ex1-9A 	|	4251937	|	101.584	|	1.29386	|	689690477	|	183070263	|	0.34344 	|	26.5438	|	
|	Zdi-CDup_021-Ex1-7G 	|	8038124	|	100.997	|	1.50955	|	689690477	|	296558592	|	0.649088	|	42.9988	|	
|	Zdi-CDup_060-Ex1-12E 	|	207507	|	102.237	|	1.04014	|	689690477	|	11378274	|	0.0171599	|	1.64977	|	
|	Zdi-CDup_057-Ex1-12B 	|	1212699	|	105.712	|	1.13053	|	689690477	|	65210167	|	0.106892	|	9.45499	|	
|	Zdi-CDup_062-Ex1-12G 	|	258149	|	95.9044	|	1.04108	|	689690477	|	12935570	|	0.0195261	|	1.87556	|	
|	Zdi-CDup_042-Ex1-10D 	|	3787109	|	100.05	|	1.26688	|	689690477	|	164652211	|	0.302447	|	23.8733	|	
|	Zdi-CDup_065-Ex1-5B 	|	445917	|	104.785	|	1.06675	|	689690477	|	24242114	|	0.0374955	|	3.51493	|	
|	Zdi-CDup_059-Ex1-12D 	|	970324	|	118.439	|	1.12862	|	689690477	|	61356753	|	0.100405	|	8.89627	|	
|	Zdi-CDup_071-Ex1-12H 	|	436718	|	104.872	|	1.06987	|	689690477	|	24228324	|	0.0375838	|	3.51293	|	
|	Zdi-CDup_061-Ex1-12F 	|	2338243	|	84.28	|	1.14141	|	689690477	|	89632604	|	0.148338	|	12.9961	|	
|	Zdi-CDup_064-Ex1-5A 	|	2267551	|	122.015	|	1.21124	|	689690477	|	135476736	|	0.237925	|	19.6431	|	
|	Zdi-CDup_043-Ex1-10E 	|	6793733	|	111.933	|	1.58988	|	689690477	|	277042689	|	0.638641	|	40.1691	|	
|	Zdi-CDup_066-Ex1-5C 	|	3465667	|	95.36	|	1.36195	|	689690477	|	130013444	|	0.256741	|	18.851	|	
|	Zdi-CDup_058-Ex1-12C 	|	6209148	|	90.0675	|	1.34326	|	689690477	|	219124920	|	0.426774	|	31.7715	|	
|	Zdi-CDup_047-Ex1-11A 	|	11184280|	88.3564	|	1.59027	|	689690477	|	321835353	|	0.742079	|	46.6637	|	
|	Zdi-CDup_056-Ex1-12A 	|	6705450	|	121.363	|	1.60323	|	689690477	|	314640604	|	0.731402	|	45.6206	|	
|	Zdi-ADup_022-Ex1-12C 	|	63742812|	83.8967	|	4.37552	|	689690477	|	620052734	|	3.93373 	|	89.903	|	


</details>

</details>

---
</details>


<details><summary>2. Get your reference genome</summary>

## 2. Get your reference genome

Make a new directory `refGenome` and `cd` into it
```
[hpc-0356@wahab-01 1st_sequencing_run]$ mkdir refGenome
[hpc-0356@wahab-01 1st_sequencing_run]$ cd refGenome/
```

Download the [genome from NCBI](https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/028/564/865/GCA_028564865.1_ASM2856486v1/)

```
[hpc-0356@wahab-01 refGenome]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/028/564/865/GCA_028564865.1_ASM2856486v1/GCA_028564865.1_ASM2856486v1_genomic.fna.gz
```

***Skip remainder of step 2, along with step 3: Curate the reference genome, because there aren't any scaffolds identified as mtDNA.***

---

</details>

<details><summary>4. Map your reads to your reference genome</summary>

## 4. Map your reads to your reference genome

```
[hpc-0356@wahab-01 1st_sequencing_run]$ git clone https://github.com/cbirdlab/dDocentHPC
[hpc-0356@wahab-01 1st_sequencing_run]$ mkdir mkBAM_ddocent
[hpc-0356@wahab-01 1st_sequencing_run]$ rsync fq_fp1_clmp_fp2_fqscrn_rprd/*fq.gz mkBAM_ddocent
```

Copy reference genome to mkBAM_ddocent folder
```
[hpc-0356@wahab-01 1st_sequencing_run]$ cp refGenome/GCA_028564865.1_ASM2856486v1_genomic.fna.gz mkBAM_ddocent/reference.genbank.Zdi.fasta

[hpc-0356@wahab-01 1st_sequencing_run]$ cd mkBAM_ddocent/
[hpc-0356@wahab-01 mkBAM_ddocent]$ cp ../dDocentHPC/configs/config.6.lcwgs .
[hpc-0356@wahab-01 mkBAM_ddocent]$ cp ../dDocentHPC/dDocentHPC.sbatch .
[hpc-0356@wahab-01 mkBAM_ddocent]$ sbatch dDocentHPC.sbatch mkBAM config.6.lcwgs
```

---

</details>

<details><summary>5. Filter the binary alignment maps</summary>

## 5. Filter the binary alignment maps

```
[hpc-0356@wahab-01 mkBAM_ddocent]$ sbatch dDocentHPC.sbatch fltrBAM config.6.lcwgs
```

---

</details>

<details><summary>6. Summarize Read Mapping Performance / Merge Runs</summary>

## 6. Summarize Read Mapping Performance / Merge Runs

