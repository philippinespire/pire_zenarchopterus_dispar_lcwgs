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

To begin to populate the `gerp_outgroups` directory, we need to download genomes from ~30 other fishes. Zenarchopterus dispar is within the Zenarchopteridae family within the order Beloniformes. On Genbank, there are only 3 unique chromosome level genomes in this order. Within the same clade, Atherinomorphae, the next closest groups are Atheriniformes and Cyprinodontiformes, with 4 and 11 chromosome level genomes, respectively. After this, I had to expand to the next closest clade, Cichlomorphae. Within this clade, the order Cichliformes has 13 unique genomes. The sister order to Cichliformes, Polycentridae, had no genomes. All of these total 31.

<div align="center">
 <img src="https://github.com/philippinespire/pire_zenarchopterus_dispar_lcwgs/blob/main/GenErode_Zdi/Zdi_relationships.png" alt="Zdi_relationships" width="450"/>
</div>
<p>

 
</p>
<details><summary>To see how I downloaded all the genomes:</summary>
<p>
 
**Beloniformes**
</p>

```
# Cololabis saira
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/033/807/715/GCF_033807715.1_fColSai1.1/GCF_033807715.1_fColSai1.1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_033807715.1_fColSai1.1_genomic.fna.gz Cololabis_saira.fa.gz

# Oryzias curvinotus
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/023/969/325/GCA_023969325.1_ASM2396932v1/GCA_023969325.1_ASM2396932v1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_023969325.1_ASM2396932v1_genomic.fna.gz Oryzias_curvinotus.fa.gz

# Xenentodon cancila
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/014/839/995/GCA_014839995.1_fXenCan1.pri/GCA_014839995.1_fXenCan1.pri_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_014839995.1_fXenCan1.pri_genomic.fna.gz  Xenentodon_cancila.fa.gz
```

**Atheriniformes**
```
# Melanotaenia boesemani
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/017/639/745/GCF_017639745.1_fMelBoe1.pri/GCF_017639745.1_fMelBoe1.pri_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_017639745.1_fMelBoe1.pri_genomic.fna.gz Melanotaenia_boesemani.fa.gz

# Neostethus bicornis
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/902/685/375/GCA_902685375.1_fNeoBic2.1/GCA_902685375.1_fNeoBic2.1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_902685375.1_fNeoBic2.1_genomic.fna.gz Neostethus_bicornis.fa.gz

# Odontesthes bonariensis
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/027/942/865/GCA_027942865.1_fOdoBon6.hap1/GCA_027942865.1_fOdoBon6.hap1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_027942865.1_fOdoBon6.hap1_genomic.fna.gz Odontesthes_bonariensis.fa.gz

# Telmatherina bonti
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/933/228/915/GCA_933228915.1_fTelBon1.1/GCA_933228915.1_fTelBon1.1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_933228915.1_fTelBon1.1_genomic.fna.gz Telmatherina_bonti.fa.gz
```


**Cyprinodontiformes**
```
# Anableps anableps
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/014/839/685/GCA_014839685.1_fAnaAna1.pri/GCA_014839685.1_fAnaAna1.pri_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_014839685.1_fAnaAna1.pri_genomic.fna.gz Anableps_anableps.fa.gz

# Cyprinodon diabolis
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/030/533/445/GCA_030533445.1_UCB_CyDiab_1.0/GCA_030533445.1_UCB_CyDiab_1.0_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_030533445.1_UCB_CyDiab_1.0_genomic.fna.gz Cyprinodon_diabolis.fa.gz

# Fundulus diaphanus
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/037/039/145/GCA_037039145.1_fFunDia1.hap1/GCA_037039145.1_fFunDia1.hap1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_037039145.1_fFunDia1.hap1_genomic.fna.gz Fundulus_diaphanus.fa.gz

# Gambusia affinis
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/019/740/435/GCF_019740435.1_SWU_Gaff_1.0/GCF_019740435.1_SWU_Gaff_1.0_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_019740435.1_SWU_Gaff_1.0_genomic.fna.gz Gambusia_affinis.fa.gz

# Girardinichthys multiradiatus
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/021/462/225/GCF_021462225.1_DD_fGirMul_XY1/GCF_021462225.1_DD_fGirMul_XY1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_021462225.1_DD_fGirMul_XY1_genomic.fna.gz Girardinichthys_multiradiatus.fa.gz

# Kryptolebias marmoratus
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/649/575/GCF_001649575.2_ASM164957v2/GCF_001649575.2_ASM164957v2_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_001649575.2_ASM164957v2_genomic.fna.gz Kryptolebias_marmoratus.fa.gz

# Nematolebias whitei
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/014/905/685/GCF_014905685.2_NemWhi1/GCF_014905685.2_NemWhi1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_014905685.2_NemWhi1_genomic.fna.gz Nematolebias_whitei.fa.gz

# Nothobranchius furzeri
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/027/789/165/GCF_027789165.1_UI_Nfuz_MZM_1.0/GCF_027789165.1_UI_Nfuz_MZM_1.0_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_027789165.1_UI_Nfuz_MZM_1.0_genomic.fna.gz Nothobranchius_furzeri.fa.gz

# Poecilia formosa
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/485/575/GCF_000485575.1_Poecilia_formosa-5.1.2/GCF_000485575.1_Poecilia_formosa-5.1.2_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_000485575.1_Poecilia_formosa-5.1.2_genomic.fna.gz Poecilia_formosa.fa.gz

# Valencia hispanica
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/963/556/495/GCA_963556495.2_fValHis1.1_MT/GCA_963556495.2_fValHis1.1_MT_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_963556495.2_fValHis1.1_MT_genomic.fna.gz Valencia_hispanica.fa.gz

# Xiphophorus birchmanni
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/036/418/095/GCA_036418095.1_xbir-COAC-16-VIII-22-M_v2023.1/GCA_036418095.1_xbir-COAC-16-VIII-22-M_v2023.1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_036418095.1_xbir-COAC-16-VIII-22-M_v2023.1_genomic.fna.gz Xiphophorus_birchmanni.fa.gz
```

**Cichliformes**
```
# Amphilophus citrinellus
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/013/435/755/GCA_013435755.1_ASM1343575v1/GCA_013435755.1_ASM1343575v1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_013435755.1_ASM1343575v1_genomic.fna.gz Amphilophus_citrinellus.fa.gz

# Archocentrus centrarchus
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/007/364/275/GCF_007364275.1_fArcCen1/GCF_007364275.1_fArcCen1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_007364275.1_fArcCen1_genomic.fna.gz Archocentrus_centrarchus.fa.gz

# Astatotilapia calliptera
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/900/246/225/GCF_900246225.1_fAstCal1.2/GCF_900246225.1_fAstCal1.2_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_900246225.1_fAstCal1.2_genomic.fna.gz Astatotilapia_calliptera.fa.gz

# Chromidotilapia guntheri
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/040/805/835/GCA_040805835.1_ASM4080583v1/GCA_040805835.1_ASM4080583v1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_040805835.1_ASM4080583v1_genomic.fna.gz Chromidotilapia_guntheri.fa.gz

# Etroplus suratensis
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/041/004/005/GCA_041004005.1_CIBA_Esura_1.1/GCA_041004005.1_CIBA_Esura_1.1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_041004005.1_CIBA_Esura_1.1_genomic.fna.gz Etroplus_suratensis.fa.gz

# Maylandia zebra
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/238/955/GCF_000238955.4_M_zebra_UMD2a/GCF_000238955.4_M_zebra_UMD2a_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_000238955.4_M_zebra_UMD2a_genomic.fna.gz Maylandia_zebra.fa.gz

# Neolamprologus multifasciatus
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/963/576/455/GCA_963576455.2_fNeoMul1.2/GCA_963576455.2_fNeoMul1.2_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_963576455.2_fNeoMul1.2_genomic.fna.gz Neolamprologus_multifasciatus.fa.gz

# Oreochromis aureus
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/013/358/895/GCF_013358895.1_ZZ_aureus/GCF_013358895.1_ZZ_aureus_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_013358895.1_ZZ_aureus_genomic.fna.gz Oreochromis_aureus.fa.gz

# Parachromis managuensis
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/040/437/545/GCA_040437545.1_ASM4043754v1/GCA_040437545.1_ASM4043754v1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_040437545.1_ASM4043754v1_genomic.fna.gz Parachromis_managuensis.fa.gz

# Pelmatolapia mariae
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/036/321/145/GCF_036321145.2_Pm_UMD_F_2/GCF_036321145.2_Pm_UMD_F_2_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCF_036321145.2_Pm_UMD_F_2_genomic.fna.gz Pelmatolapia_mariae.fa.gz

# Petenia splendida
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/040/437/555/GCA_040437555.1_P_splendida_v1.0/GCA_040437555.1_P_splendida_v1.0_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_040437555.1_P_splendida_v1.0_genomic.fna.gz Petenia_splendida.fa.gz

# Pholidichthys leucotaenia
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/020/510/985/GCA_020510985.1_fPhoLeu1.pri/GCA_020510985.1_fPhoLeu1.pri_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_020510985.1_fPhoLeu1.pri_genomic.fna.gz Pholidichthys_leucotaenia.fa.gz
```
</details>



I created a txt file listing the names of all the species in the `gerp_outgroups` directory, adding Zenarchopterus dispar, and uploaded this to [TimeTree of Life](https://timetree.org/).

Species List:
```
Zenarchopeterus dispar
Cololabis saira
Oryzias curvinotus
Xenentodon cancila
Melanotaenia boesemani
Neostethus bicornis
Odontesthes bonariensis
Telmatherina bonti
Anableps anableps
Cyprinodon diabolis
Fundulus diaphanus
Gambusia affinis
Girardinichthys multiradiatus
Kryptolebias marmoratus
Nematolebias whitei
Nothobranchius furzeri
Poecilia formosa
Valencia hispanica
Xiphophorus birchmanni
Amphilophus citrinellus
Archocentrus centrarchus
Astatotilapia calliptera
Chromidotilapia guntheri
Etroplus suratensis
Maylandia zebra
Neolamprologus multifasciatus
Oreochromis aureus
Parachromis managuensis
Pelmatolapia mariae
Petenia splendida
Pholidichthys leucotaenia
```
















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
