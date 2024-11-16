<img src="https://lifg.australian.museum/Image/9uTxr6do.jpeg?version=full" alt="Zdi" width="300"/>

# GenErode_Zdi_3: _Zenarchopterus dispar_ lcWGS

Following the [GenErode pipeline](https://github.com/philippinespire/pire_lcwgs_data_processing/tree/main/scripts/GenErode_Wahab) for Zdi.

Done by Gianna Mazzei (November 2024).

---

## GenErode Processing

<details><summary>1. Set-up/Get config files</summary>

### 1. Set-up/Get config files

I began by making a new GenErode directory and copied over the template folder contents.
```
[hpc-0356@wahab-01 pire_zenarchopterus_dispar_lcwgs]$ mdir GenErode_Zdi_3
cp -r /home/e1garcia/shotgun_PIRE/pire_lcwgs_data_processing/scripts/GenErode_Wahab/GenErode_templatedir/* /archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_3
```
Now, instead of making the necessary subdirectories and populating them, I will copy ones over that have already been populated from a [previous directory](https://github.com/philippinespire/pire_zenarchopterus_dispar_lcwgs/tree/main/abandoned_GenErode_Zdi_2) since this this directory is the 3rd iteration.
```
[hpc-0356@wahab-01 abandoned_GenErode_Zdi_2]$ cp -r historical ../GenErode_Zdi_3/.
[hpc-0356@wahab-01 abandoned_GenErode_Zdi_2]$ cp -r modern ../GenErode_Zdi_3/.
[hpc-0356@wahab-01 abandoned_GenErode_Zdi_2]$ cp -r gerp_outgroups ../GenErode_Zdi_3/.
[hpc-0356@wahab-01 abandoned_GenErode_Zdi_2]$ cp -r config ../GenErode_Zdi_3/.
[hpc-0356@wahab-01 abandoned_GenErode_Zdi_2]$ mkdir ../GenErode_Zdi_3/reference && cp reference/reference.genbank.Zdi.fasta ../GenErode_Zdi_3/reference/
[hpc-0356@wahab-01 GenErode_Zdi_3]$ mkdir mitochondria
```

Since I have already created the necessary config files, the only thing I have to do is edit the `config.yaml` file to reflect this new directory name
```
[hpc-0356@wahab-01 GenErode_Zdi_3]$ sed -i 's/GenErode_Zdi_2/GenErode_Zdi_3/g' config/config.yaml
[hpc-0356@wahab-01 GenErode_Zdi_3]$ cat -n config/config.yaml
# changes are:
    23	ref_path: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2/reference/reference.genbank.Zdi.fasta"
   492	gerp_ref_path: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2/gerp_outgroups"
   501	tree: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2/Zdi_gerp_tree.nwk"
```
---

</details>

<details><summary>2. GERP outgroup files</summary>

### 2. GERP outgroup files

This is the 3rd version of a GenErode directory for Zdi, so I have already downloaded all of the gerp outgroups for this species, which I transferred over when I copied the `gerp_outgroups` directory from a previous run. 

**To recap on the species I added (from my 2nd GenErode directory):**
* "To begin to populate the `gerp_outgroups` directory, we need to download genomes from  at least 30 other fishes. _Zenarchopterus dispar_ is within the Zenarchopteridae family within the order Beloniformes. On Genbank, there are 3 unique chromosome level genomes in this order. Within the same clade, Atherinomorphae, the next closest groups are Atheriniformes and Cyprinodontiformes, with 4 and 11 chromosome level genomes, respectively. After this, I had to expand to the next closest clade, Cichlomorphae. Within this clade, the order Cichliformes has 12 unique genomes. The sister order to Cichliformes, Polycentridae, had no genomes. This equals 30 genomes.
* Unfortunately, _Xenentodon cancila_, which belonged to Beloniformes, caused issues when trying to run GenErode. Because of this, we now only have 29 genomes. There is a 13th whole genome in the order Cichliformes, but I avoided it due to it being an unclassified species (_Rhamphochromis sp. 'chilingali'_) and unrecognized by TimeTree. To evade the issue, I'm going to download the _Rhamphochromis sp. 'chilingali'_ genome but list _Rhamphochromis esox_ as the species name for creating the TimeTree, as this species is recognized for some reason."

<div align="center">
 <img src="https://github.com/philippinespire/pire_zenarchopterus_dispar_lcwgs/blob/main/abandoned_GenErode_Zdi_2/Zdi_relationships_2.png" alt="Zdi_relationships" width="500"/>
</div>
<p>

My first directory failed because I was having issues with _Xenentodon cancila_ (in Beloniformes). I made a new directory where I removed that species, added a new one to replace it (_Rhamphochromis sp. 'chilingali'_ in Cichliformes), and reran GenErode. This second directory failed for the same reason as the first, but for a different species (_Cololabis saira_) which worked fine the first time. We have realized that the species files are likely not the issue, but our Zdi reference genome since it is at the scaffold level and needs to be filtered. 

Now, I will readd _Xenentodon cancila_, keeping _Rhamphochromis sp. 'chilingali'_, to this directory, making our total number of gerp outgroup genomes 31. 

```
# Xenentodon cancila
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/014/839/995/GCA_014839995.1_fXenCan1.pri/GCA_014839995.1_fXenCan1.pri_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_014839995.1_fXenCan1.pri_genomic.fna.gz Xenentodon_cancila.fa.gz

[hpc-0356@wahab-01 gerp_outgroups]$ ls -1
Amphilophus_citrinellus.fa.gz
Anableps_anableps.fa.gz
Archocentrus_centrarchus.fa.gz
Astatotilapia_calliptera.fa.gz
Chromidotilapia_guntheri.fa.gz
Cololabis_saira.fa.gz
Cyprinodon_diabolis.fa.gz
Etroplus_suratensis.fa.gz
Fundulus_diaphanus.fa.gz
Gambusia_affinis.fa.gz
Girardinichthys_multiradiatus.fa.gz
Kryptolebias_marmoratus.fa.gz
Maylandia_zebra.fa.gz
Melanotaenia_boesemani.fa.gz
Nematolebias_whitei.fa.gz
Neolamprologus_multifasciatus.fa.gz
Neostethus_bicornis.fa.gz
Nothobranchius_furzeri.fa.gz
Odontesthes_bonariensis.fa.gz
Oreochromis_aureus.fa.gz
Oryzias_curvinotus.fa.gz
Parachromis_managuensis.fa.gz
Pelmatolapia_mariae.fa.gz
Petenia_splendida.fa.gz
Pholidichthys_leucotaenia.fa.gz
Poecilia_formosa.fa.gz
Rhamphochromis_chilingali.fa.gz
Telmatherina_bonti.fa.gz
Valencia_hispanica.fa.gz
Xenentodon_cancila.fa.gz
Xiphophorus_birchmanni.fa.gz

[hpc-0356@wahab-01 gerp_outgroups]$ ls -1 | wc -l
31
```
---
</details> 

<details><summary>3. Get Newick tree</summary>

### 3. Get Newick tree

I created a txt file listing the names of all the species in the `gerp_outgroups` directory and uploaded this to [TimeTree of Life](https://timetree.org/). We need to add Zenarchopterus dispar to this list, but neither the species nor its genus is recognized by the database. However, within the same family (Zenarchopteridae) the species Dermogenys collettei is recognized. Likewise, Rhamphochromis sp. 'chilingali' is not recognized, but Rhamphochromis esox is.

**I will be using <ins>Dermogenys collettei in place of Zenarchopterus dispar</ins> and <ins>Rhamphochromis esox in place of Rhamphochromis sp. 'chilingali'</ins>**

Species List:
```
*Dermogenys collettei
Amphilophus citrinellus
Anableps anableps
Archocentrus centrarchus
Astatotilapia calliptera
Chromidotilapia guntheri
Cololabis saira
Cyprinodon diabolis
Etroplus suratensis
Fundulus diaphanus
Gambusia affinis
Girardinichthys multiradiatus
Kryptolebias marmoratus
Maylandia zebra
Melanotaenia boesemani
Nematolebias whitei
Neolamprologus multifasciatus
Neostethus bicornis
Nothobranchius furzeri
Odontesthes bonariensis
Oreochromis aureus
Oryzias curvinotus
Parachromis managuensis
Pelmatolapia mariae
Petenia splendida
Pholidichthys leucotaenia
Poecilia formosa
*Rhamphochromis esox
Telmatherina bonti
Valencia hispanica
Xiphophorus birchmanni
```
<p>

I downloaded the tree as a Newick File (and jpg) and uploaded it to this `GenErode_Zdi_3` directory.
</p>

```
[hpc-0356@wahab-01 gerp_outgroups]$ logout

giannamazzei@Giannas-Laptop ~ % cd ~/Downloads

giannamazzei@Giannas-Laptop Downloads % scp Zdi_gerp_tree.nwk hpc-0356@wahab.hpc.odu.edu:/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_3

giannamazzei@Giannas-Laptop Downloads % scp Zdi_prunetree.jpg hpc-0356@wahab.hpc.odu.edu:/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_3
```

Now, in the .nwk file, rename the focal species with the name of the reference assembly file, as well as rename the species for Rhamphochromis:
```
[hpc-0356@wahab-01 GenErode_Zdi_3]$ sed -i 's/Dermogenys_collettei/reference.genbank.Zdi.fasta/g' Zdi_gerp_tree.nwk
[hpc-0356@wahab-01 GenErode_Zdi_3]$ sed -i 's/Rhamphochromis_esox/Rhamphochromis_chilingali/g' Zdi_gerp_tree.nwk
```
<div align="center">
 
  ### TimeTree Output:
 
 <img src="https://github.com/philippinespire/pire_zenarchopterus_dispar_lcwgs/blob/main/GenErode_Zdi_3/Zdi_prunetree.jpg" alt="Zdi prunetree" width="700"/>
</div>

---

</details>

<details><summary>4. Process the reference genome</summary>

### 4. Process the reference genome

As I've noted previously, we believe the cause of our previous GenErode failures is from our Zdi reference genome containing scaffolds that are too small. 

I'm now going to process the file, following [step 1 of this unrelated pipeline](https://github.com/philippinespire/REUs/tree/master/2022_REU/PSMC).

First, I need to copy the relevant script:
```
[hpc-0356@wahab-01 GenErode_Zdi_3]$ cp /home/e1garcia/shotgun_PIRE/REUs/2022_REU/PSMC/scripts/removesmalls.pl reference/.
```
Now, lets filter out the smaller scaffolds, keeping only scaffolds longer than 20kb.
```
[hpc-0356@wahab-01 reference]$ perl removesmalls.pl 20000 reference.genbank.Zdi.fasta > reference.genbank.Zdi.20k.fasta
```
Now let's check the length of the filtered assembly, which tells you the number of scaffolds left after filtering, and compare it to the pre-filtered genome:
```
# filtered:
[hpc-0356@wahab-01 reference]$ cat reference.genbank.Zdi.20k.fasta | grep "^>" | wc -l
2841

# original:
[hpc-0356@wahab-01 reference]$ cat reference.genbank.Zdi.fasta | grep "^>" | wc -l
69922
```
Great, now that this number has significantly decreased, we know the script worked to filter out reads shorter than 20kb.

See total length of the filtered assemblies & compare:
```
[hpc-0356@wahab-01 reference]$ cat reference.genbank.Zdi.20k.fasta | grep -v "^>" | tr "\n" "\t" | sed 's/\t//g' | wc -c
456648442

[hpc-0356@wahab-01 reference]$ cat reference.genbank.Zdi.fasta | grep -v "^>" | tr "\n" "\t" | sed 's/\t//g' | wc -c
689690477
```
Finally, change the names of the scaffolds to numerals (1,2,3...x).
```
[hpc-0356@wahab-01 reference]$ awk -i inplace '/^>/{print ">" ++i; next}{print}' reference.genbank.Zdi.20k.fasta
```
Now the reference genome has been processed and we can move forward with running GenErode.

---
</details>

<details><summary>4. Run GenErode</summary>

### 4. Run GenErode

Copy the sbatch script
```
[hpc-0356@wahab-01 GenErode_Zdi_3]$ cp /home/e1garcia/shotgun_PIRE/pire_lcwgs_data_processing/scripts/GenErode_Wahab/run_GenErode.sbatch .
```
Run GenErode:
```
[hpc-0356@wahab-01 GenErode_Zdi_3]$ sbatch run_GenErode.sbatch
```

Submitted batch job 3709865 (Nov 15 2024)

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
