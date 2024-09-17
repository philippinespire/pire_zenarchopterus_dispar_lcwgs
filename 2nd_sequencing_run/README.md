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

---

</details>

<details><summary>11e. Move output files</summary>
	
### 11e. Move output files

The recommended instructions using `screen mv` have not been working for me so I did this:
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ mkdir fq_fp1_clmp_fp2_fqscrn

[hpc-0356@wahab-01 2nd_sequencing_run]$ mv /scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn/Zdi* /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/2nd_sequencing_run/fq_fp1_clmp_fp2_fqscrn

[hpc-0356@wahab-01 2nd_sequencing_run]$ mv /scratch/hpc-0356/fq_fp1_clmp_fp2_fqscrn/fqValidationReport.txt /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/2nd_sequencing_run/fq_fp1_clmp_fp2_fqscrn
```
---
</details>

<details><summary>11f. Run MultiQC (*)</summary>
	
### 11f. Run MultiQC (*)

```
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runMULTIQC.sbatch fq_fp1_clmp_fp2_fqscrn fastq_screen_report
Submitted batch job 3495843
```

#### Review the MultiQC output (fq_fp1_clmp_fp2_fqscrn/fastq_screen_report.html):
* `Zdi-ADup_012`has high bacterial content: 22.6%
  * This is the sample that has consistently had high GC content
* Contemporary samples all pretty consistent
* Albatross shows more variation; varying levels of bacterial and human contamination, albeit human is less notable

```
‣ multiple genomes -
    • Alb: 1.4 - 9.2%
    • Contemp: 2.5 - 5.3%
‣ no hits -
    • Alb: 66.2 - 97.5%
    • Contemp: 93.4 - 96.5%
‣ bacteria -
    • Alb: 0.2 - 22.6%
    • Contemp: 0.1 - 0.6%
‣ human -
    • Alb: 0.1 - 2.9%
    • Contemp: 0.1 - 0.2%
```

</details>

---

</details>

<details><summary>12. Repair FASTQ Files Messed Up by FASTQ_SCREEN (*)</summary>
<p>

## 12. Repair FASTQ Files Messed Up by FASTQ_SCREEN (*)

#### Execute `runREPAIR.sbatch`

Next we need to re-pair our reads. `runREPAIR.sbatch` matches up forward (r1) and reverse (r2) reads so that the `*1.fq.gz` and `*2.fq.gz` files have reads in the same order
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runREPAIR.sbatch fq_fp1_clmp_fp2_fqscrn fq_fp1_clmp_fp2_fqscrn_rprd 5
Submitted batch job 3495856
```
#### Confirm that the paired end fq.gz files are complete and formatted correctly:

Start by running the script:
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ bash
[hpc-0356@wahab-01 2nd_sequencing_run]$ SCRIPT=/home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/validateFQPE.sbatch 
                                        DIR=fq_fp1_clmp_fp2_fqscrn_rprd
                                        fqPATTERN="*fq.gz"
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch $SCRIPT $DIR $fqPATTERN
Submitted batch job 3495915
```
Check the SLURM `out` file and `fqValidationReport.txt` to determine if all of the fqgz files are valid
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ cat valiate_FQ_-3495915.out
PAIRED END FASTQ VALIDATION REPORT

Directory: fq_fp1_clmp_fp2_fqscrn_rprd
File Pattern: *fq.gz
File extensions found: .R1.fq.gz .R2.fq.gz

Number of paired end fq files evaluated: 96
Number of paired end fq files validated: 96
```
#### Run `Multi_FASTQC`
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh "./fq_fp1_clmp_fp2_fqscrn_rprd" "fqc_rprd_report" "fq.gz"
Submitted batch job 3496068
```

#### Review MultiQC output (fq_fp1_clmp_fp2_fqscrn_rprd/fqc_rprd_report.html):
*

```
‣ % duplication -
    • Alb: 
    • Contemp: 
‣ GC content -
    • Alb: 
    • Contemp: 
‣ length -
    • Alb: 
    • Contemp: 
‣ number of reads -
    • Alb: 
    • Contemp: 
```

---

</details>

<details><summary> → Overview: Compare MultiQC Report Results (*)</summary>

### Compare MultiQC Report Results:

<table>
	
<tr>
<td> Raw Data - Step 7 </td> <td> 1st Trim - Step 8 (combined reads) </td> <td> Deduplication/Clumpify - Step 9 </td>  <td> 2nd Trim - Step 10 (combined reads) </td> <td> Re-pairing - Step 12 </td>  
</tr>
<tr>
<td>

```
‣ % duplication - 
    • Alb: 3.6 - 37.8%
    • Contemp: 10.7 - 84.5%
‣ GC content - 
    • Alb: 43 - 57%
    • Contemp: 44 - 88%
‣ number of reads - 
    • Alb: 0.0 - 634.1 mil
    • Contemp: 2.3 - 66.4 mil
```
</td>
<td>

```
‣ % duplication - 
    • Alb: 0.4 - 32.1%
    • Contemp: 0.7 - 6.5%
‣ GC content -
    • Alb: 36.7 - 55.8%
    • Contemp: 42.1 - 48.0%
‣ passing filter - 
    • Alb: 88.7 - 98.2%
    • Contemp: 16.2 - 95.2%
‣ % adapter - 
    • Alb: 83.5 - 98.9%
    • Contemp: 40.5 - 74.6%
‣ number of reads - 
    • Alb: 0.009 - 1.2 bil
    • Contemp: 4.5 - 132.7 mil
```
</td>
<td>

```
‣ % duplication - 
    • Alb: 0.0 - 7.0%
    • Contemp: 0.8 - 5.0%
‣ GC content - 
    • Alb: 36 - 56%
    • Contemp: 41 - 47%
‣ length - 
    • Alb: 64 - 123 bp
    • Contemp: 82 - 136 bp
‣ number of reads -
    • Alb: 0.0 - 273.2 mil
    • Contemp: 1.0 - 25.8 mil
```
</td>
<td>

```
‣ % duplication -
    • Alb: 0.0 - 7.0%
    • Contemp: 0.2 - 2.3%
‣ GC content -
    • Alb: 36.4 - 56.1%
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
</td>
<td>

```
repair
```
</td>
</tr>
</table>

---

</details>


<details><summary>14. Clean Up</summary>
<p>

## 14. Clean Up

Move any .out files into the logs dir
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ mkdir logs
[hpc-0356@wahab-01 2nd_sequencing_run]$ mv *out logs/
```

---

</details>

<details><summary>15. Map Repaired `fq.gz` to Reference Genome</summary>
<p>

## 15. Map Repaired `fq.gz` to Reference Genome

The following steps 15 & 16 are from the [pire_lcwgs_data_processing repo](https://github.com/philippinespire/pire_lcwgs_data_processing).

### Get your reference genome

Make a new directory `refGenome`:
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ mkdir refGenome
```
I already downloaded the reference genome from NCBI for the 1st sequencing run, so I will copy it from there:
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ cp ../1st_sequencing_run/mkBAM_ddocent/reference.genbank.Zdi.fasta refGenome
```

### Map your reads to your reference genome
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ git clone https://github.com/cbirdlab/dDocentHPC
[hpc-0356@wahab-01 2nd_sequencing_run]$ mkdir mkBAM_ddocent
[hpc-0356@wahab-01 2nd_sequencing_run]$ rsync fq_fp1_clmp_fp2_fqscrn_rprd/*fq.gz mkBAM_ddocent
```

Copy reference genome to mkBAM_ddocent folder
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ cp refGenome/reference.genbank.Zdi.fasta mkBAM_ddocent

[hpc-0356@wahab-01 2nd_sequencing_run]$ cd mkBAM_ddocent/
[hpc-0356@wahab-01 mkBAM_ddocent]$ cp ../dDocentHPC/configs/config.6.lcwgs .
[hpc-0356@wahab-01 mkBAM_ddocent]$ cp ../dDocentHPC/dDocentHPC.sbatch .
```
Before moving forward, I needed to edit the `config.6.lcwgs` file to suit this species:
```
[hpc-0356@wahab-01 mkBAM_ddocent]$ nano config.6.lcwgs

# within file:
# change Cutoff1 and Cutoff2 to "genbank" and "Zdi"

----------mkREF: Settings for de novo assembly of the reference genome----------------------------------------->
PE              Type of reads for assembly (PE, SE, OL, RPE)                                    PE=ddRAD & ezRA>
0.9             cdhit Clustering_Similarity_Pct (0-1)                                                   Use cdh>
genbank      	Cutoff1 (integer)                                                                              >
Zdi             Cutoff2 (integer)                                                                              >
0.05    rainbow merge -r <percentile> (decimal 0-1)                                             Percentile-base>
0.95    rainbow merge -R <percentile> (decimal 0-1)                                             Percentile-base>
--------------------------------------------------------------------------------------------------------------->
```
Then, I needed to alter the `dDocentHPC.sbatch` file to load the newer version:
```
[hpc-0356@wahab-01 mkBAM_ddocent]$ nano dDocentHPC.sbatch

# within file:
# change where the "#" is

enable_lmod
# module load container_env ddocent/2.7.8
module load container_env ddocent/2.9.4
```
Now, I am able to map reads.

Execute `dDocentHPC.sbatch mkBAM config.6.lcwgs` which aligns reads (in FASTQ format) to a reference genome and creates BAM files (Binary Alignment Map files) which store the resulting alignments in a compressed, binary format.
```
[hpc-0356@wahab-01 mkBAM_ddocent]$ sbatch dDocentHPC.sbatch mkBAM config.6.lcwgs
Submitted batch job 3496436
```
---

</details>

<details><summary>16. Filter BAM Files</summary>
	
## 16. Filter BAM Files

Filtering BAM files ensures data quality, reduces noise, improves analysis accuracy, and prepares data for downstream genomic analyses.
```
[hpc-0356@wahab-01 mkBAM_ddocent]$ sbatch dDocentHPC.sbatch fltrBAM config.6.lcwgs
Submitted batch job 3497233
```
---

</details>


<details><summary>17. Generate Number of Mapped Reads</summary>

## 17. Generate Number of Mapped Reads
```
[hpc-0356@wahab-01 2nd_sequencing_run]$  sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/mappedReadStats.sbatch mkBAM_ddocent mkBAM_ddocent/coverageMappedReads
Submitted batch job 3498437
```

#### Review Output (coverageMappedReads/out__ReadStats.tsv):
*

```
‣ numreads:
    • Alb: 
    • Contemp: 

‣ meanreadlength:
    • Alb: 
    • Contemp: 

‣ meandepth_wcvg:
    • Alb: 
    • Contemp: 

‣ numpos:
    • 

‣ numpos_wcvg:
    • Alb: 
    • Contemp: 

‣ meandepth:
    • Alb: 
    • Contemp: 

‣ pctpos_wcvg:
    • Alb: 
    • Contemp: 
```
---

</details>

<details><summary>18. Extract mitochondrial genomes from read data</summary>

## 18. Extract mitochondrial genomes from read data

If there are potential cryptic species in the data, we should try to extract mitochondrial genes from the read data to get an idea of species IDs. You use MitoZ to do so.

For this next step, typically you'd copy over the runMitoZ bash and sbatch scripts from `/home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/` to your sequencing project directory, but these files are outdated and need to be edited every time. This has caused some errors in the past, so I'm just going to copy the edited versions of these files over from a species I previously successfully ran.

```
[hpc-0356@wahab-01 pire_zenarchopterus_dispar_lcwgs]$ cp /archive/carpenterlab/pire/pire_stethojulis_interrupta_lcwgs/1st_sequencing_run/runMitoZ* 2nd_sequencing_run
```
Now, execute the runMitoZ script:
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ bash runMitoZ_array.bash /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/2nd_sequencing_run/fq_fp1_clmp_fp2 32
Submitted batch job 3497258
```
For the next script to work, I need my MitoZ output files to be in my `fq_fp1_clmp_fp2` directory.
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ mv MitoZ*.out fq_fp1_clmp_fp2/
```
Then, after copying it, I was able to run the `process_MitoZ_outputs.sh` script
```
[hpc-0356@wahab-01 2nd_sequencing_run]$ cd fq_fp1_clmp_fp2
[hpc-0356@wahab-01 fq_fp1_clmp_fp2]$ cp /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/process_MitoZ_outputs.sh .

[hpc-0356@wahab-01 fq_fp1_clmp_fp2]$ sh process_MitoZ_outputs.sh
```
Now, we can see which individuals MitoZ worked for:
* 5 Albatross individuals passed MitoZ
* All contemporary samples, except one, passed

<details><summary>Individuals that succeeded/failed:</summary>
<p>
		
**Individuals that succeeded:**
```
[hpc-0356@wahab-01 fq_fp1_clmp_fp2]$ cat MitoZ_success.txt
Zdi-ADup_012-Ex1-11A-lcwgs-1-2
Zdi-ADup_037-Ex1-3D-lcwgs-1-2
Zdi-ADup_039-Ex1-2C-lcwgs-1-2
Zdi-ADup_040-Ex1-2D-lcwgs-1-2
Zdi-ADup_041-Ex1-2E-lcwgs-1-2
Zdi-CDup_001-Ex1-5D-lcwgs-1-2
Zdi-CDup_002-Ex1-5E-lcwgs-1-2
Zdi-CDup_003-Ex1-5F-lcwgs-1-2
Zdi-CDup_004-Ex1-5G-lcwgs-1-2
Zdi-CDup_005-Ex1-5H-lcwgs-1-2
Zdi-CDup_006-Ex1-6A-lcwgs-1-2
Zdi-CDup_007-Ex1-6B-lcwgs-1-2
Zdi-CDup_008-Ex1-6C-lcwgs-1-2
Zdi-CDup_010-Ex1-6D-lcwgs-1-2
Zdi-CDup_011-Ex1-6E-lcwgs-1-2
Zdi-CDup_012-Ex1-6F-lcwgs-1-2
Zdi-CDup_013-Ex1-6G-lcwgs-1-2
Zdi-CDup_014-Ex1-6H-lcwgs-1-2
Zdi-CDup_015-Ex1-7A-lcwgs-1-2
Zdi-CDup_016-Ex1-7B-lcwgs-1-2
Zdi-CDup_017-Ex1-7C-lcwgs-1-2
Zdi-CDup_018-Ex1-7D-lcwgs-1-2
Zdi-CDup_021-Ex1-7G-lcwgs-1-2
Zdi-CDup_022-Ex1-7H-lcwgs-1-2
Zdi-CDup_026-Ex1-8D-lcwgs-1-2
Zdi-CDup_031-Ex1-9A-lcwgs-1-2
Zdi-CDup_033-Ex1-9C-lcwgs-1-2
Zdi-CDup_034-Ex1-9D-lcwgs-1-2
Zdi-CDup_035-Ex1-9E-lcwgs-1-2
Zdi-CDup_037-Ex1-9G-lcwgs-1-2
Zdi-CDup_038-Ex1-9H-lcwgs-1-2
Zdi-CDup_039-Ex1-10A-lcwgs-1-2
Zdi-CDup_040-Ex1-10B-lcwgs-1-2
Zdi-CDup_041-Ex1-10C-lcwgs-1-2
Zdi-CDup_042-Ex1-10D-lcwgs-1-2
Zdi-CDup_043-Ex1-10E-lcwgs-1-2
Zdi-CDup_045-Ex1-10G-lcwgs-1-2
Zdi-CDup_046-Ex1-10H-lcwgs-1-2
Zdi-CDup_047-Ex1-11A-lcwgs-1-2
Zdi-CDup_050-Ex1-11D-lcwgs-1-2
Zdi-CDup_051-Ex1-11E-lcwgs-1-2
Zdi-CDup_054-Ex1-11G-lcwgs-1-2
Zdi-CDup_056-Ex1-12A-lcwgs-1-2
Zdi-CDup_057-Ex1-12B-lcwgs-1-2
Zdi-CDup_058-Ex1-12C-lcwgs-1-2
Zdi-CDup_059-Ex1-12D-lcwgs-1-2
Zdi-CDup_060-Ex1-12E-lcwgs-1-2
Zdi-CDup_061-Ex1-12F-lcwgs-1-2
Zdi-CDup_062-Ex1-12G-lcwgs-1-2
Zdi-CDup_064-Ex1-5A-lcwgs-1-2
Zdi-CDup_065-Ex1-5B-lcwgs-1-2
Zdi-CDup_066-Ex1-5C-lcwgs-1-2
Zdi-CDup_071-Ex1-12H-lcwgs-1-2
```

**Individuals that failed:**
```
[hpc-0356@wahab-01 fq_fp1_clmp_fp2]$ cat MitoZ_failure_lowdepth.txt
Zdi-ADup_001-Ex1-11B-lcwgs-1-2
Zdi-ADup_003-Ex1-9H-lcwgs-1-2
Zdi-ADup_004-Ex1-10A-lcwgs-1-2
Zdi-ADup_005-Ex1-10B-lcwgs-1-2
Zdi-ADup_006-Ex1-10C-lcwgs-1-2
Zdi-ADup_007-Ex1-10D-lcwgs-1-2
Zdi-ADup_009-Ex1-10F-lcwgs-1-2
Zdi-ADup_010-Ex1-10G-lcwgs-1-2
Zdi-ADup_011-Ex1-10H-lcwgs-1-2
Zdi-ADup_013-Ex1-12F-lcwgs-1-2
Zdi-ADup_014-Ex1-11C-lcwgs-1-2
Zdi-ADup_016-Ex1-11E-lcwgs-1-2
Zdi-ADup_017-Ex1-11F-lcwgs-1-2
Zdi-ADup_018-Ex1-11G-lcwgs-1-2
Zdi-ADup_019-Ex1-11H-lcwgs-1-2
Zdi-ADup_020-Ex1-12A-lcwgs-1-2
Zdi-ADup_022-Ex1-12C-lcwgs-1-2
Zdi-ADup_023-Ex1-12D-lcwgs-1-2
Zdi-ADup_024-Ex1-12E-lcwgs-1-2
Zdi-ADup_025-Ex1-2A-lcwgs-1-2
Zdi-ADup_026-Ex1-12G-lcwgs-1-2
Zdi-ADup_027-Ex1-12H-lcwgs-1-2
Zdi-ADup_028-Ex1-9F-lcwgs-1-2
Zdi-ADup_029-Ex1-1A-lcwgs-1-2
Zdi-ADup_030-Ex1-1B-lcwgs-1-2
Zdi-ADup_031-Ex1-1C-lcwgs-1-2
Zdi-ADup_032-Ex1-1D-lcwgs-1-2
Zdi-ADup_033-Ex1-1E-lcwgs-1-2
Zdi-ADup_034-Ex1-1F-lcwgs-1-2
Zdi-ADup_035-Ex1-1G-lcwgs-1-2
Zdi-ADup_036-Ex1-1H-lcwgs-1-2
Zdi-ADup_038-Ex1-2B-lcwgs-1-2
Zdi-ADup_042-Ex1-2F-lcwgs-1-2
Zdi-ADup_043-Ex1-2G-lcwgs-1-2
Zdi-ADup_044-Ex1-2H-lcwgs-1-2
Zdi-ADup_045-Ex1-3A-lcwgs-1-2
Zdi-ADup_046-Ex1-3B-lcwgs-1-2
Zdi-ADup_047-Ex1-3C-lcwgs-1-2
Zdi-CDup_019-Ex1-7E-lcwgs-1-2
```
</p>
</details>

The FASTA formatted sequences were then uploaded to [BOLD](https://www.boldsystems.org/index.php) to identify species matches.
* COI sequences were able to be recovered for some of the samples that passed MitoZ (sequences in `MitoZ_output.fasta`). 



### Results:
_**There seems to be contamination/misidentification of multiple individuals.**_

| Query ID |	Best ID |	Search DB |	Top %	| Low % |
| ----- | -----|------|------|-----|
|	Zdi-ADup_012-Ex1-11A-lcwgs-1-2	|	Chromis viridis	|	COI SPECIES DATABASE	|	99.85	|	92.98	|
|	Zdi-ADup_037-Ex1-3D-lcwgs-1-2	|	No match	|	COI SPECIES DATABASE	|		|		|
|	Zdi-ADup_040-Ex1-2D-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	99.71	|	85.19	|
|	Zdi-CDup_002-Ex1-5E-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_003-Ex1-5F-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.04	|	83.96	|
|	Zdi-CDup_004-Ex1-5G-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_005-Ex1-5H-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.04	|	83.96	|
|	Zdi-CDup_006-Ex1-6A-lcwgs-1-2	|	Sphaeramia nematoptera	|	COI SPECIES DATABASE	|	100	|	85.83	|
|	Zdi-CDup_007-Ex1-6B-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.04	|	83.96	|
|	Zdi-CDup_008-Ex1-6C-lcwgs-1-2	|	Sphaeramia nematoptera	|	COI SPECIES DATABASE	|	100	|	85.83	|
|	Zdi-CDup_010-Ex1-6D-lcwgs-1-2	|	Sphaeramia nematoptera	|	COI SPECIES DATABASE	|	100	|	85.83	|
|	Zdi-CDup_011-Ex1-6E-lcwgs-1-2	|	Sphaeramia nematoptera	|	COI SPECIES DATABASE	|	100	|	85.83	|
|	Zdi-CDup_012-Ex1-6F-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_013-Ex1-6G-lcwgs-1-2	|	Sphaeramia nematoptera	|	COI SPECIES DATABASE	|	100	|	85.83	|
|	Zdi-CDup_014-Ex1-6H-lcwgs-1-2	|	Sphaeramia nematoptera	|	COI SPECIES DATABASE	|	100	|	85.83	|
|	Zdi-CDup_015-Ex1-7A-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_016-Ex1-7B-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_017-Ex1-7C-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_018-Ex1-7D-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_021-Ex1-7G-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_022-Ex1-7H-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_026-Ex1-8D-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_031-Ex1-9A-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.04	|	83.96	|
|	Zdi-CDup_033-Ex1-9C-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_034-Ex1-9D-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_035-Ex1-9E-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_037-Ex1-9G-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_038-Ex1-9H-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_039-Ex1-10A-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_040-Ex1-10B-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_041-Ex1-10C-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_043-Ex1-10E-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_045-Ex1-10G-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_046-Ex1-10H-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_047-Ex1-11A-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.04	|	84.11	|
|	Zdi-CDup_050-Ex1-11D-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_051-Ex1-11E-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_054-Ex1-11G-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_056-Ex1-12A-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_057-Ex1-12B-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_058-Ex1-12C-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_060-Ex1-12E-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_061-Ex1-12F-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_062-Ex1-12G-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_064-Ex1-5A-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.19	|	84.11	|
|	Zdi-CDup_065-Ex1-5B-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_066-Ex1-5C-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|
|	Zdi-CDup_071-Ex1-12H-lcwgs-1-2	|	Zenarchopterus dispar	|	COI SPECIES DATABASE	|	97.33	|	84.27	|

For the 2 other Albatross samples that passed MitoZ, but did not produce a COI sequence, I assessed the ND4 sequence. I also tried `Zdi-ADup_037` again since it was No Match on BOLD.
* Zdi-ADup_039-Ex1-2C-lcwgs-1-2
* Zdi-ADup_041-Ex1-2E-lcwgs-1-2
* Zdi-ADup_037-Ex1-3D-lcwgs-1-2

<details><summary>This sequence can be found within the individual's cds file.</summary>

```
[hpc-0356@wahab-01 fq_fp1_clmp_fp2]$ cd Zdi-ADup_039-Ex1-2C-lcwgs-1-2_MitoZ/Zdi-ADup_039-Ex1-2C-lcwgs-1-2.result
[hpc-0356@wahab-01 Zdi-ADup_039-Ex1-2C-lcwgs-1-2.result]$ cat Zdi-ADup_039-Ex1-2C-lcwgs-1-2.cds
>C346566;ND4;len=1272;[<1:1272](-)
ATGTTAAAAATTCTTATCCCAACTATAATACTGTTCCCAACTACACTAATAACACCCTACAAAAAATTATGATCAACAACCCTTCTCCACAGCCTACTTATCGCCTTCCTAAGCCTCATATGATTAAAAACAAACGAAGAAACGGGCTGAACATGCCTCAACCACTATATAGCAATTGATCCCCTATCAACACCCCTTTTAATCCTTACATGCTGGCTTCTCCCGCTAATAATTATTGCAAGCCAAAACCATATAATAATAGAGCCCATTAACCGACAACGAGTTTATATTTTACTCTTAATTTCCCTACAAATATTCCTAATCTTTGCTTTCAGCGCTACCGAAATAATTATATTCTATATCATATTTGAATCCACCTTAATCCCCACTTTATTTATCATCACACGATGAGGTAACCAAACAGAACGCTTAAATGCAGGAACATACTTCCTATTTTATACACTAGCAGGTTCTTTACCACTATTAATTGCCCTTTTTCTCCTACACAATTCAAATGGAACTCTTTCTCTCTTGACTTTACAATACACTAAAACCAACATACCTATAACCTACGCTAATAAATTCTGATGAACAGGTTGCCTCCTAGCATTTCTAGTTAAAATACCACTCTATGGTACCCACCTTTGACTACCCAAAGCTCACGTAGAAGCTCCTATTGCAGGCTCCATAATTTTAGCCGCAGTTTTACTCAAGCTAGGAGGATATGGTATAATTCGAATTTCACCAATACTAGAGCCACTAACCAAAGAGCTAAGCTACCCATTTATTATCCTCGCCCTATGAGGTGTAATTATAACCAGCTTAATTTGTCTCCGCCAAACAGACCTAAAATCCCTCATCGCTTACTCATCCGTAAGCCACATAGGTCTTGTAGCCGCAGGAATCCTAATTCAAACACCATGAGGCCTAACAGGAGCATTAATTATAATAATTGCCCATGGATTAACATCATCTGCTTTATTCTGCTTAGCCAATATAAACTATGAACGAACCCACAGCCGAACAATAATTCTTACACGAGGACTTCAAACAATTTTACCAACCATAACTATATGATGATTTCTAACTTGTTTAGCTAACCTCGCCCTTCCTCCTTTACCCAATTTAATAGGAGAATTAATAATTTTAACCTCTCTATTTAATTGATCCCCATGAACCTTAATATTAACCGGAACAGGCACTCTAATCACAGCCGCTTATTCCCTATACATATACTTAATAACACAACGGGGCCCTCTCCCACTACATATT

[hpc-0356@wahab-01 fq_fp1_clmp_fp2]$ cd Zdi-ADup_041-Ex1-2E-lcwgs-1-2_MitoZ/Zdi-ADup_041-Ex1-2E-lcwgs-1-2.result
[hpc-0356@wahab-01 Zdi-ADup_041-Ex1-2E-lcwgs-1-2.result]$ cat Zdi-ADup_041-Ex1-2E-lcwgs-1-2.cds
>C92523;ND4;len=1381;[2048:3428](+)
ATGTTAAAAATTCTTATCCCAACTATAATACTGTTCCCAACTACACTAATAACACCCTACAAAAAATTATGATCAACAACCCTTCTCCACAGCCTACTTATCGCCTTCCTAAGCCTCATATGATTAAAAACAAACGAAGAAACGGGCTGAACATGCCTCAACCACTATATAGCAATTGATCCCCTATCAACACCCCTTTTAATCCTTACATGCTGGCTTCTCCCGCTAATAATTATTGCAAGCCAAAACCATATAATAATAGAGCCCATTAACCGACAACGAGTTTATATTTTACTCTTAATTTCCCTACAAATATTCCTAATCTTTGCTTTCAGCGCTACCGAAATAATTATATTCTATATCATATTTGAATCCACCTTAATCCCCACTTTATTTATCATCACACGATGAGGTAACCAAACAGAACGCTTAAATGCAGGAACATACTTCCTATTTTATACACTAGCAGGTTCTTTACCACTATTAATTGCCCTTTTTCTCCTACACAATTCAAATGGAACTCTTTCTCTTTTGACTTTACAATACACTAAAACCAACATACCTATAACCTACGCTAATAAATTCTGATGAACAGGTTGCCTCCTAGCATTTCTAGTTAAAATACCACTCTATGGTACCCACCTTTGACTACCCAAAGCTCACGTAGAAGCTCCTATTGCAGGCTCCATAATTTTAGCCGCAGTTTTACTCAAACTAGGAGGGTATGGTATAATTCGAATTTCACCAATACTAGAGCCACTAACCAAAGAGCTAAGCTACCCATTTATTATCCTCGCCCTATGAGGTGTAATTATAACCAGCTTAATTTGTCTCCGCCAAACAGACCTAAAATCCCTCATCGCTTACTCATCCGTAAGCCACATAGGTCTTGTAGCCGCAGGAATCCTAATTCAAACACCATGAGGCCTAACAGGAGCATTAATTATAATAATTGCCCATGGATTAACATCATCTGCTTTATTCTGCTTAGCCAATATAAACTATGAACGAACCCACAGCCGAACAATAATTCTTACACGAGGACTTCAAACAATTTTACCAACCATAACTATATGATGATTTCTAACTTGTTTAGCTAACCTCGCCCTTCCTCCTTTACCCAATTTAATAGGAGAATTAATAATTTTAACCTCTCTATTTAATTGATCCCCATGAACCTTAATATTAACCGGAACAGGCACTCTAATCACAGCCGCTTATTCCCTATACATATACTTAATAACACAACGGGGCCCTCTCCCACTACATATTATTAACCTTAACCCGACCCACTCACGAGAACACTTGCTTATTTCCCTTCACCTAATACCCTTACTATTACTTATTACGAAACCCGAACTAATCTGAGGCTGAACCGCTT

[hpc-0356@wahab-01 fq_fp1_clmp_fp2]$ cd Zdi-ADup_037-Ex1-3D-lcwgs-1-2_MitoZ/Zdi-ADup_037-Ex1-3D-lcwgs-1-2.result
[hpc-0356@wahab-01 Zdi-ADup_037-Ex1-3D-lcwgs-1-2.result]$ cat Zdi-ADup_037-Ex1-3D-lcwgs-1-2.cds
>C239268;ND4;len=1052;[73123:74174](-)
ATGTTACTGACCCAGGCAGGTCTTACAGGCGTTTTTTTAGCGCAGGATGCATTGCTGTTCTATTTCTTTTGGGAACTGGCGCTGATTCCCGTTTATTTTCTCTGTTCTATCTGGGGTGGTGAGAAAAGAATTGCTGTTACCTTCAAATTTTTTGTGTATACTTTTCTTGGCTCTTTGCTGATGCTTGCGGGCATCCTGTTCGTATACTTTCATACGGCCGATCAATCCTTCTCCCTGAAATCGTTCTATGAGGTCAAACTGACCGGCGCACAACAGGGGCTTGCTTTCTGGCTGTTCTTTATAGCATTTGCCATTAAAATGCCGGTATTCCCATTTCATACCTGGCAGCCCGATGCATACGAACAGTCGCCTACTGCAGTAACCATGATACTCAGCGGCGTAATGGTTAAAATGGGTGTTTTTGCATTGATACGCTGGCTGTTGCCGGTGTTTCCGAATGCGTCTTCACAGTTCAGTCATGTTATTATTGTCTTTTCCGTCATTGGCATGCTGTATGCCTCACTGATTGCCATCAGGCAGGACGACCTGAAGCGACTGATCGCTTATTCATCCATTGCTCATATTGGATTGATGTGTGCTGTTGTATTCACGTTTAACAAAACAGGAATGGATGGTGTGATGGTGCAGATGTTCAACCATGGTGTGAATGTGATTGGGCTGTGGGTGGTAGCTGATGTGATTGAACAACAACTGGGAACAAGGAAATTCAGTGAACTGGGAGGACTGGCCCAAAAAGCGCCGGCCCTGGCCATTCTGTTAATGGTGATGGCGCTGGCCAATATTGCTTTGCCGCTGACCAACGCATTCATCGGGGAATTCCTCATGTTCAACGGACTGTTCCAATACAATGGATGGATCGCAGCTGTAGCCTGTATCAGCATCGTCCTGGTGGCAGTGTATACCCTCAACATGATCCAAAGCATATTTTACGGAAATACGGTACCAGCTACGGCGAAGGCGACCGATATCAATAAGAACGTACAATTTACATTGGCAGTACTGGCATTGGTGGTGATAGTGCTGGGTGTTTA
```

</details>

Once that was retrieved, I uploaded each sequence to [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome) identify similarity to the sequence in their database.

| sample | scientific name | percent identity  | query cover |
| ----- | -----|------|-----|
| Zdi-ADup_039-Ex1-2C-lcwgs-1-2 | Zenarchopterus dispar | 99.76% | 100% |
| Zdi-ADup_041-Ex1-2E-lcwgs-1-2 | Zenarchopterus dispar | 99.71% | 100% |
| Zdi-ADup_037-Ex1-3D-lcwgs-1-2 | Phnomibacter ginsenosidimutans <br> Arachidicoccus soli | 72.77% <br> 81.56%| 58% <br> 13%|

### Results:	
* **`Zdi-ADup_012`, which stood out for having higher GC content than all other samples throughout the pipeline matched to _Chromis viridis_ (Cvi).**
* **`Zdi-ADup_037` matched to two different types of bacteria when uploading the ND4 sequence to BLAST.**
* **`Zdi-CDup_006`, `Zdi-CDup_008`, `Zdi-CDup_010`, `Zdi-CDup_011`, `Zdi-CDup_013`, & `Zdi-CDup_014` all matched to _Sphaeramia nematoptera_ (Sne).**
