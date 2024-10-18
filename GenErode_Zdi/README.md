<img src="https://lifg.australian.museum/Image/9uTxr6do.jpeg?version=full" alt="Zdi" width="300"/>

# GenErode: _Zenarchopterus dispar_ lcWGS

Following the [GenErode pipeline](https://github.com/philippinespire/pire_lcwgs_data_processing/tree/main/scripts/GenErode_Wahab) for Pbb.

Done by Gianna Mazzei (September 2024).

---

## GenErode Processing

<details><summary>1. Set-Up</summary>

### 1. Set-Up

Make a copy of the template folder, renaming it according to your species name.
```
cp -r /home/e1garcia/shotgun_PIRE/pire_lcwgs_data_processing/scripts/GenErode_Wahab/GenErode_templatedir /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi
```
Then, create the necessary subdirectories
```
mkdir /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/config
mkdir /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/historical
mkdir /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/modern
mkdir /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/reference
mkdir /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/gerp_outgroups
mkdir /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/mitochondria
```
Add 1st_sequencing_run Zdi species data to the subdirectories:
```
rsync /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/1st_sequencing_run/fq_raw/Zdi-A*.fq.gz /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/historical

rsync /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/1st_sequencing_run/fq_raw/Zdi-C*.fq.gz /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/modern
```
Make sure they all synced properly:
```
ls -1 /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/1st_sequencing_run/fq_raw/Zdi-A*.fq.gz  | wc -l
ls -1 /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/historical | wc -l
94
94

ls -1 /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/1st_sequencing_run/fq_raw/Zdi-C*.fq.gz | wc -l
ls -1 /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/modern | wc -l
128
128
```

Now add 2nd_sequencing_run Zdi species data to the subdirectories:
```
rsync /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/2nd_sequencing_run/fq_raw/Zdi-A*.fq.gz /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/historical

rsync /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/2nd_sequencing_run/fq_raw/Zdi-C*.fq.gz /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/modern
```
Check it worked:
```
ls -1 /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/2nd_sequencing_run/fq_raw/Zdi-A*.fq.gz  | wc -l
ls -1 /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/historical/*2.1.fq.gz | wc -l
ls -1 /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/historical/*2.2.fq.gz | wc -l
94
47
47

ls -1 /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/2nd_sequencing_run/fq_raw/Zdi-C*.fq.gz  | wc -l
ls -1 /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/modern/*2.1.fq.gz | wc -l
ls -1 /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/modern/*2.2.fq.gz | wc -l
98
49
49
```
Add reference genome:
```
rsync /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/1st_sequencing_run/mkBAM_ddocent/reference.genbank.Zdi.fasta /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi/reference
```

---

</details>

<details><summary>2. Get Newick tree</summary>

### 2. Get Newick tree

To begin to populate the `gerp_outgroups` directory, we need to download genomes from ~30 other fishes. Zenarchopterus dispar is within the Zenarchopteridae family within the order Beloniformes. On Genbank, there are only 3 unique chromosome level genomes in this order. Within the same clade, Atherinomorphae, the next closest groups are Atheriniformes and Cyprinodontiformes, with 4 and 11 chromosome level genomes, respectively. After this, I have to expand to the next closest clade, Cichlomorphae. Within this clade, the order Cichliformes has 12 unique genomes. All of these total exactly 30.

<div align="center">
 <img src="https://github.com/philippinespire/pire_parupeneus_barberinus_lcwgs/blob/main/GenErode_Zdi/Zdi_relationships.png" alt="Zdi_relationships" width="400"/>
</div>


















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
