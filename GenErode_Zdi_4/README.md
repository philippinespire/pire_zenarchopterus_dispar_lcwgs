<img src="https://lifg.australian.museum/Image/9uTxr6do.jpeg?version=full" alt="Zdi" width="300"/>

# `GenErode_Zdi_4`: _Zenarchopterus dispar_ lcWGS

Following the [GenErode pipeline](https://github.com/philippinespire/pire_lcwgs_data_processing/tree/main/scripts/GenErode_Wahab) for Zdi.

Done by Gianna Mazzei (November 2024).

---

## GenErode Processing

<details><summary>1. Set-up/Update config.yaml</summary>

### 1. Set-up/Update config.yam

_**This is the 4th iteration of GenErode directories for Zdi.**_ 

**There is one very minor difference between this folder and [abandoned_GenErode_Zdi_3](https://github.com/philippinespire/pire_zenarchopterus_dispar_lcwgs/tree/main/abandoned_GenErode_Zdi_3) → I forgot to update my path to the updated reference genome in my `config.yaml` file. For more details on how I specifically populated any directories or updated the reference genome, check the readme for the directory linked above.**

I began by making a new GenErode directory and copied over the template folder contents.
```
[hpc-0356@wahab-01 pire_zenarchopterus_dispar_lcwgs]$ mdir GenErode_Zdi_4
[hpc-0356@wahab-01 pire_zenarchopterus_dispar_lcwgs]$ cp -r /home/e1garcia/shotgun_PIRE/pire_lcwgs_data_processing/scripts/GenErode_Wahab/GenErode_templatedir/* /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_4
```
Now, I will copy over previously populated directories and necessary files.
```
[hpc-0356@wahab-01 GenErode_Zdi_4]$ cp -r ../abandoned_GenErode_Zdi_1/historical .
[hpc-0356@wahab-01 GenErode_Zdi_4]$ cp -r ../abandoned_GenErode_Zdi_1/modern .
[hpc-0356@wahab-01 GenErode_Zdi_4]$ cp -r ../abandoned_GenErode_Zdi_3/gerp_outgroups/ .
[hpc-0356@wahab-01 GenErode_Zdi_4]$ cp -r ../abandoned_GenErode_Zdi_3/config/ .
[hpc-0356@wahab-01 GenErode_Zdi_4]$ mkdir reference
[hpc-0356@wahab-01 GenErode_Zdi_4]$ cp -r ../abandoned_GenErode_Zdi_3/reference/reference.genbank.Zdi.20k.fasta .
[hpc-0356@wahab-01 GenErode_Zdi_4]$ cp -r ../abandoned_GenErode_Zdi_3/Zdi_gerp_tree.nwk .
[hpc-0356@wahab-01 GenErode_Zdi_4]$ mkdir mitochondria
```

The only thing I have to update before rerunning GenErode, is the `config.yaml` file to reflect this directory path as well as the new reference genome name
```
[hpc-0356@wahab-01 GenErode_Zdi_4]$ sed -i 's/GenErode_Zdi_3/GenErode_Zdi_4/g' config/config.yaml
[hpc-0356@wahab-01 GenErode_Zdi_4]$ sed -i 's/reference.genbank.Zdi.fasta/reference.genbank.Zdi.20k.fasta/g' config/config.yaml
[hpc-0356@wahab-01 GenErode_Zdi_3]$ cat -n config/config.yaml
# changes are:
    23	ref_path: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_4/reference/reference.genbank.Zdi.20k.fasta"
   492	gerp_ref_path: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_4/gerp_outgroups"
   501	tree: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_4/Zdi_gerp_tree.nwk"

[hpc-0356@wahab-01 GenErode_Zdi_4]$ diff config/config.yaml ../abandoned_GenErode_Zdi_3/config/config.yaml 
23c23
< ref_path: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_4/reference/reference.genbank.Zdi.20k.fasta"
---
> ref_path: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_3/reference/reference.genbank.Zdi.fasta"
492c492
< gerp_ref_path: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_4/gerp_outgroups"
---
> gerp_ref_path: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_3/gerp_outgroups"
501c501
< tree: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_4/Zdi_gerp_tree.nwk"
---
> tree: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_3/Zdi_gerp_tree.nwk"
```
---

</details>

<details><summary>2. Run GenErode</summary>

### 2. Run GenErode

Copy the sbatch script
```
[hpc-0356@wahab-01 GenErode_Zdi_4]$ cp /home/e1garcia/shotgun_PIRE/pire_lcwgs_data_processing/scripts/GenErode_Wahab/run_GenErode.sbatch .
```
Run GenErode:
```
[hpc-0356@wahab-01 GenErode_Zdi_4]$ sbatch run_GenErode.sbatch
```
<ins>**Jobs Log**</ins>
* **3739022** (Nov 19 2024) -> random failure. going to add `--rerun-incomplete` tag to a copy of the sbatch script and rerun
* **3797055** (Nov 24 2024) -> random failure. rerunning
* **3830988** (Nov 24 2024) -> I ran out of storage in my home dir, causing job failure. rerunning
* **3996365** (Dec 12 2024) 

---
</details>

<details><summary>Credits</summary>

# Credits

<img src="docs/source/img/logga_viridis2.png" alt="logo" width="25%"/> 

GitHub repository for GenErode, a Snakemake pipeline for the analysis 
of whole-genome sequencing data from historical and modern samples to 
study patterns of genome erosion.

## Documentation

The full pipeline documentation can be found on the [repository wiki](https://github.com/NBISweden/GenErode/wiki).

## Citation

If you've used GenErode to produce results, please cite our paper:

Kutschera VE, Kierczak M, van der Valk T, von Seth J, Dussex N, Lord E, Dehasque M, Stanton DWG, Emami P, Nystedt B, Dalén L, Díez-del-Molino D (2022) GenErode: a bioinformatics pipeline to investigate genome erosion in endangered and extinct species. BMC Bioinformatics 23, 228 https://doi.org/10.1186/s12859-022-04757-0

## Pipeline overview

<img src="docs/source/img/figure_1_generode_pipeline_v7.png" alt="processing" width="75%"/>

Figure 1: Overview of the GenErode pipeline data processing tracks. Input 
and output files formats, dependencies between steps, and main software used
are shown. Optional steps are highlighted in red. 

<img src="docs/source/img/figure_2_generode_pipeline_v7.png" alt="analysis" width="75%"/>

Figure 2: Overview of the GenErode pipeline data analysis tracks and final reports.
Input file formats and main software used are shown.


## Licence information

GenErode pipeline

Copyright (C) 2022  Verena Kutschera

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.


Logo: Jonas Söderberg

</details>
