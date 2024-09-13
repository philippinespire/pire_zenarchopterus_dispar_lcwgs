<img src="https://lifg.australian.museum/Image/9uTxr6do.jpeg?version=full" alt="Zdi" width="300"/>

# _Zenarchopterus dispar_ lcWGS 

## 2nd sequencing run

Analysis of low-coverage whole genome sequencing data for Zdi 2nd_sequencing_run.

fq.gz processing done by Gianna Mazzei (started September 7 2024).

---
	
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
</details>

<details><summary>7. Check the quality of raw data (*)</summary>

## 7. Check the quality of raw data (*)

Executed `Multi_FASTQC.sh` 

```
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh "fq_raw" "fqc_raw_report"  "fq.gz"
Submitted batch job 3471540
```

### MultiQC output (fq_raw/fqc_raw_report.html):
* very high number of reads for `Zdi-ADup_021`: 634.1 mil
* Overall, Contemporary samples have higher percentages of duplicate reads than Albatross
* Sequence Quality Histograms: about half have a warning, other half passing
* Per Base Sequence Content: 186/192 samples failing; Contemparary samples have very high %G
* Per Sequence GC Content: 127/192 failing; big spikes at 80 and 100% GC
* Sequence Duplication Levels: 33/192 failed, all Contemporary; 36/192 warning
* Overrepresented sequences: 181/192 failing
* Adapter Content: 190/192 failing

```  
‣ % duplication - 
    • Alb: 3.6 - 37.8%
    • Contemp: 10.7 - 84.5%
‣ GC content - 
    • Alb: 43 - 57%
    • Contemp: 44 - 88%
‣ number of reads - 
    • Alb: 0.0 - 70.4 mil; 634.1 mil [Zdi-ADup_021-Ex1-12B-lcwgs-1-2.1 & 2]
    • Contemp: 2.3 - 66.4 mil
```
---
</details>

<details><summary>8. First trim (*)</summary>

## 8. First trim (*)
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFASTP_1st_trim.sbatch fq_raw fq_fp1
Submitted batch job 3472406
```
### Review the FastQC output (fq_fp1/1st_fastp_report.html):
After 1st trim:
* Insert Size Distribution: spike around insert size 0
* Sequence Quality: both reads 1 and 2 tightened up after filtering; both dip in quality between read positions 125 to 150
* GC Content: looks much better after filtering; `Zdi-ADup_012` sitting close to 10% higher than all other reads after filtering
* `Zdi-ADup_021` (not to be confused with Zdi-ADup_012) still has a very high number of reads
```  
‣ % duplication - 
    • Alb: 0.4 - 32.1%
    • Contemp: 0.7 - 6.5%
‣ GC content -
    • Alb: 36.7 - 48.0%; 55.8%: [Zdi-ADup_012-Ex1-11A-lcwgs-1-2]
    • Contemp: 42.1 - 48.0%
‣ passing filter - 
    • Alb: 88.7 - 98.2%
    • Contemp: 16.2 - 95.2%
‣ % adapter - 
    • Alb: 83.5 - 98.9%
    • Contemp: 40.5 - 74.6%
‣ number of reads - 
    • Alb: 0.009 - 140.7 mil; 1.2 bil: [Zdi-ADup_021-Ex1-12B-lcwgs-1-2]
    • Contemp: 4.5 - 132.7 mil
```

---
</details>

<details><summary>9. Remove duplicates with clumpify (*)</summary>

## 9. Remove duplicates with clumpify (*)

### 9a. Remove duplicates
 ```
[hpc-0356@wahab-01 2nd_sequencing_run]$ bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runCLUMPIFY_r1r2_array.bash fq_fp1 fq_fp1_clmp /scratch/hpc-0356 20
Submitted batch job 3472487
```
### 9c. Check duplicate removal success

```
[hpc-0356@wahab-01 2nd_sequencing_run]$ salloc
[hpc-0356@d6-w6420b-05 2nd_sequencing_run]$ enable_lmod
[hpc-0356@d6-w6420b-05 2nd_sequencing_run]$ module load container_env R/4.3 
[hpc-0356@d4-w6420b-05 2nd_sequencing_run]$ crun R < /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/checkClumpify_EG.R --no-save

Clumpify Successfully worked on all samples

[hpc-0356@d6-w6420b-05 2nd_sequencing_run]$ exit
```

### 9d. Clean the scratch drive

```
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/cleanSCRATCH.sbatch /scratch/hpc-0356 "*clumpify*temp*"
Submitted batch job 3472649
```

### 9e. Generate metadata on deduplicated FASTQ files (*)

```
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh "fq_fp1_clmp" "fqc_clmp_report"  "fq.gz"
Submitted batch job 3472650
```

**Results** (fq_fp1_clmp/fqc_clmp_report.html): 
* %GC lower on average for Albatross samples -> `Zdi-ADup_012` still higher than the rest
* Length:
	* Albatross: `Zdi-ADup_012` 25 bp longer than the next longest
	* Contemporary: `Zdi-CDup_054` 20 bp shorter than the next shortest
* `Zdi-ADup_021` still very high number of reads: 273.2 mil
* Per Base Sequence Content: 104/192 passing; 84/192 warning; 4/192 failed
* Per Sequence GC Content: 120/192 passing; 67/192 warning; 5/192 failed
	* All peak between 35-50% except for `Zdi-ADup_012` -> peak ~67%
* No samples found with any adapter contamination > 0.1%

```
‣ % duplication - 
    • Alb: 0.0 - 7.0%
    • Contemp: 0.8 - 5.0%
‣ GC content - 
    • Alb: 36 - 47%; 56%: [Zdi-ADup_012-Ex1-11A-lcwgs-1-2.clmp.r1 & r2]
    • Contemp: 41 - 47%
‣ length - 
    • Alb: 64 - 98 bp; 123 bp: [Zdi-ADup_012-Ex1-11A-lcwgs-1-2.clmp.r1 & r2]
    • Contemp: 82 bp: [Zdi-CDup_054-Ex1-11G-lcwgs-1-2.clmp.r1 & r2]; 102 - 136 bp
‣ number of reads -
    • Alb: 0.0 - 49.2 mil; 273.2 mil: [Zdi-ADup_021-Ex1-12B-lcwgs-1-2.clmp.r1 & r2]
    • Contemp: 1.0 - 25.8 mil
```
---

</details>

<details><summary>10. Second trim (*)</summary>
<p>

```
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFASTP_2.sbatch fq_fp1_clmp fq_fp1_clmp_fp2 33
Submitted batch job 3481739
```

### Review the FastQC output (fq_fp1_clmp_fp2/2nd_fastp_report.html):
After 2nd trim:
* All samples above 98% PF
* Adapter content way down from 1st trim
* shorter reads for historical samples, longer reads for contemporary: evidenced by seaprate peaks in Insert Size Distribution graph
* Sequence Quality: samples tighten up after filtering, but both read 1 and read 2 both dip a little in sequence quality towards the end of the reads
* GC Content graph does dont change much after filtering
	* `Zdi-ADup_012` still has higher GC content than the other samples; ~56%
* N Content variability was corrected after filtering
```
‣ % duplication -
    • Alb: 0.0 - 7.0%
    • Contemp: 0.2 - 2.3%
‣ GC content -
    • Alb: 36.4 - 46.9%; 56.1%: [Zdi-ADup_012-Ex1-11A-lcwgs-1-2.clmp.r1r2_fastp]
    • Contemp: 41.8 - 47.1%
‣ passing filter -
    • Alb: 98.1 - 99.3%
    • Contemp: 98.5 - 99.0%
‣ % adapter -
    • Alb: 0.5 - 1.4%
    • Contemp: 0.4 - 1.1%
‣ number of reads -
    • Alb: 0.008 - 546.4 mil
    • Contemp: 1.9 - 51.7 mil
```

</p>

---
</details>

<details><summary>11. Decontaminate files (*)</summary>
<p>

## 11. Decontaminate files (*)

<details><summary>11a. Run fastq_screen</summary>

### 11a. Run fastq_screen

JOBID: 3487705
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ bash
[hpc-0356@wahab-01 2nd_sequencing_run]$ fqScrnPATH=/home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFQSCRN_6.bash
indir=fq_fp1_clmp_fp2
[hpc-0356@wahab-01 2nd_sequencing_run]$ outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
nodes=20
[hpc-0356@wahab-01 2nd_sequencing_run]$ bash $fqScrnPATH $indir $outdir $nodes
```
---
</details>

<details><summary>11b. Check for Errors</summary>

### 11b. Check for Errors
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ bash
[hpc-0356@wahab-01 2nd_sequencing_run]$ outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/validateFQ.sbatch $outdir "*filter.fastq.gz"
Submitted batch job 3489334

# when complete check the $outdir/fqValidateReport.txt file
less -S $outdir/fqValidationReport.txt file
```
How many files we should have, based on the indir:
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ indir=fq_fp1_clmp_fp2
[hpc-0356@wahab-01 2nd_sequencing_run]$ ls $indir/*r1.fq.gz | wc -l
                                        ls $indir/*r2.fq.gz | wc -l
96
96
```

Now, let's check that all 5 files were created for each fqgz file:
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
[hpc-0356@wahab-01 2nd_sequencing_run]$ ls $outdir/*r1.tagged.fastq.gz | wc -l
					ls $outdir/*r2.tagged.fastq.gz | wc -l
					ls $outdir/*r1.tagged_filter.fastq.gz | wc -l
					ls $outdir/*r2.tagged_filter.fastq.gz | wc -l 
					ls $outdir/*r1_screen.txt | wc -l
					ls $outdir/*r2_screen.txt | wc -l
					ls $outdir/*r1_screen.png | wc -l
					ls $outdir/*r2_screen.png | wc -l
					ls $outdir/*r1_screen.html | wc -l
					ls $outdir/*r2_screen.html | wc -l
104
104
103
104
111
111
101
103
101
103
```
Hmm. This shouldn't be above 96.

After checking my scratch it seems there were some old Pbb files that didn't get removed.
```
cd /scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
[hpc-0356@wahab-01 fq_fp1_clmp_fp2_fqscrn]$ rm Pbb*
```
Now recheck that all 5 files were created for each fqgz file:
```
cd /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/2nd_sequencing_run
[hpc-0356@wahab-01 2nd_sequencing_run]$ outdir=/scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
[hpc-0356@wahab-01 2nd_sequencing_run]$ ls $outdir/*r1.tagged.fastq.gz | wc -l
					ls $outdir/*r2.tagged.fastq.gz | wc -l
					ls $outdir/*r1.tagged_filter.fastq.gz | wc -l
					ls $outdir/*r2.tagged_filter.fastq.gz | wc -l 
					ls $outdir/*r1_screen.txt | wc -l
					ls $outdir/*r2_screen.txt | wc -l
					ls $outdir/*r1_screen.png | wc -l
					ls $outdir/*r2_screen.png | wc -l
					ls $outdir/*r1_screen.html | wc -l
					ls $outdir/*r2_screen.html | wc -l
96
96
96
96
96
96
96
96
96
96
```
Yay they are all there!

I'm gonna rerun `validateFQ.sbatch` since the previous one included those Pbb files.
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ cd /scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn
[hpc-0356@wahab-01 fq_fp1_clmp_fp2_fqscrn]$ rm fqValidationReport.txt

[hpc-0356@wahab-01 fq_fp1_clmp_fp2_fqscrn]$ cd /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/2nd_sequencing_run
[hpc-0356@wahab-01 2nd_sequencing_run]$ bash
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/validateFQ.sbatch $outdir "*filter.fastq.gz"
Submitted batch job 3489794

# when complete check the $outdir/fqValidateReport.txt file
less -S $outdir/fqValidationReport.txt file
```

**Since fqscreen worked properly, there are no files that need to be rerun!**
