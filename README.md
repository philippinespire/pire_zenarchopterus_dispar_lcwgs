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
Results:
```
Potential issues:  
  * % duplication - 
	* Alb: 9.3-40.4%, Contemp: 12.9-90.3%
  * GC content - 
	* Alb: 46-65%, Contemp: 46-93%
  * number of reads - 
	* Alb: 0.014-54.7 mil, Contemp: 0.038-9.8 mil
```
<details><summary>Output:</summary>
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
</details>

<details><summary>8. First trim</summary>
<p>

  
</p>
