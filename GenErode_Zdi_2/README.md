<img src="https://lifg.australian.museum/Image/9uTxr6do.jpeg?version=full" alt="Zdi" width="300"/>

# GenErode: _Zenarchopterus dispar_ lcWGS

Following the [GenErode pipeline](https://github.com/philippinespire/pire_lcwgs_data_processing/tree/main/scripts/GenErode_Wahab) for Pbb.

Done by Gianna Mazzei (October 2024).

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

To begin to populate the `gerp_outgroups` directory, we need to download genomes from  at least 30 other fishes. _Zenarchopterus dispar_ is within the Zenarchopteridae family within the order Beloniformes. On Genbank, there are 3 unique chromosome level genomes in this order. Within the same clade, Atherinomorphae, the next closest groups are Atheriniformes and Cyprinodontiformes, with 4 and 11 chromosome level genomes, respectively. After this, I had to expand to the next closest clade, Cichlomorphae. Within this clade, the order Cichliformes has 12 unique genomes. The sister order to Cichliformes, Polycentridae, had no genomes. This equals 30 genomes.

Unfortunately, _Xenentodon cancila_, which belonged to Beloniformes, caused issues when trying to run GenErode. Because of this, we now only have 29 genomes. There is a 13th whole genome in the order Cichliformes, but I avoided it due to it being an unclassified species (_Rhamphochromis sp. 'chilingali'_) and unrecognized by TimeTree. To evade the issue, I'm going to download the _Rhamphochromis sp. 'chilingali'_ genome but list _Rhamphochromis esox_ as the species name for creating the TimeTree, as this species is recognized for some reason.

<div align="center">
 <img src="https://github.com/philippinespire/pire_zenarchopterus_dispar_lcwgs/blob/main/GenErode_Zdi_2/Zdi_relationships_2.png" alt="Zdi_relationships" width="500"/>
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

# Xenentodon cancila was removed from this list as it was causing problems for GenErode
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

# *Added* Rhamphochromis sp. 'chilingali'
[hpc-0356@wahab-01 gerp_outgroups]$ wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/963/969/265/GCA_963969265.1_fRhaChi2.1/GCA_963969265.1_fRhaChi2.1_genomic.fna.gz
[hpc-0356@wahab-01 gerp_outgroups]$ mv GCA_963969265.1_fRhaChi2.1_genomic.fna.gz Rhamphochromis_chilingali.fa.gz
```

</details>



I created a txt file listing the names of all the species in the `gerp_outgroups` directory and uploaded this to [TimeTree of Life](https://timetree.org/). We need to add Zenarchopterus dispar to this list, but neither the species nor its genus is recognized by the database. However, within the same family (Zenarchopteridae) the species Dermogenys collettei is recognized. 

**I will be using Dermogenys collettei as a proxy for Zenarchopterus dispar and Rhamphochromis esox in place of Rhamphochromis sp. 'chilingali'**

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

I downloaded the tree as a Newick File (and jpg) and uploaded it to my `GenErode_Zdi_2` directory.
</p>

```
[hpc-0356@wahab-01 gerp_outgroups]$ logout

giannamazzei@Giannas-Laptop ~ % cd ~/Downloads

giannamazzei@Giannas-Laptop Downloads % scp Zdi_gerp_tree.nwk hpc-0356@wahab.hpc.odu.edu:/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2

giannamazzei@Giannas-Laptop Downloads % scp Zdi_prunetree.jpg hpc-0356@wahab.hpc.odu.edu:/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2
```

Now, in the .nwk file, rename the focal species with the name of the reference assembly file, as well as rename the species for Rhamphochromis:
```
[hpc-0356@wahab-01 GenErode_Zdi_2]$ sed -i 's/Dermogenys_collettei/reference.genbank.Zdi.fasta/g' Zdi_gerp_tree.nwk
[hpc-0356@wahab-01 GenErode_Zdi_2]$ sed -i 's/Rhamphochromis_esox/Rhamphochromis_chilingali/g' Zdi_gerp_tree.nwk
```
<div align="center">
 
 ### TimeTree Output:
 
 <img src="https://github.com/philippinespire/pire_zenarchopterus_dispar_lcwgs/blob/main/GenErode_Zdi_2/Zdi_prunetree.jpg" alt="Zdi prunetree" width="700"/>
</div>

---

</details>

<details><summary>3. Edit the config files</summary>

### 3. Edit the config files

I wrote a script to try and automate this process.

I began by copying it from where I originally made it:
```
[hpc-0356@wahab-01 GenErode_Zdi]$ cp /archive/carpenterlab/pire/pire_parupeneus_barberinus_lcwgs/test_GenErode_Pbb/config_file_population.sh .
```
Within the file, I have two variables you need to set on lines 9 and 10
```
species_code="Zdi"  # Replace XXX with the actual species code, ex. "Pbb"
species_name="zenarchopterus_dispar"  # Replace with the actual species name, ex. "parupeneus_barberinus"
```
Now running the script should populate the config text files, if this works the way I hope it does.
```
[hpc-0356@wahab-01 GenErode_Zdi]$ ./config_file_population.sh 
```
It worked!!

**Zdi_historical_samples.txt:**
```
[hpc-0356@wahab-01 config]$ cat Zdi_historical_samples.txt 
samplename_index_lane readgroup_id readgroup_platform path_to_R1_fastq_file path_to_R2_fastq_file
ZdiADup001_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_001-Ex1-11B-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_001-Ex1-11B-lcwgs-1-1.2.fq.gz
ZdiADup002_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_002-Ex1-9G-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_002-Ex1-9G-lcwgs-1-1.2.fq.gz
ZdiADup003_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_003-Ex1-9H-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_003-Ex1-9H-lcwgs-1-1.2.fq.gz
ZdiADup004_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_004-Ex1-10A-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_004-Ex1-10A-lcwgs-1-1.2.fq.gz
ZdiADup005_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_005-Ex1-10B-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_005-Ex1-10B-lcwgs-1-1.2.fq.gz
ZdiADup006_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_006-Ex1-10C-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_006-Ex1-10C-lcwgs-1-1.2.fq.gz
ZdiADup007_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_007-Ex1-10D-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_007-Ex1-10D-lcwgs-1-1.2.fq.gz
ZdiADup008_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_008-Ex1-10E-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_008-Ex1-10E-lcwgs-1-1.2.fq.gz
ZdiADup009_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_009-Ex1-10F-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_009-Ex1-10F-lcwgs-1-1.2.fq.gz
ZdiADup010_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_010-Ex1-10G-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_010-Ex1-10G-lcwgs-1-1.2.fq.gz
ZdiADup011_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_011-Ex1-10H-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_011-Ex1-10H-lcwgs-1-1.2.fq.gz
ZdiADup012_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_012-Ex1-11A-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_012-Ex1-11A-lcwgs-1-1.2.fq.gz
ZdiADup013_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_013-Ex1-12F-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_013-Ex1-12F-lcwgs-1-1.2.fq.gz
ZdiADup014_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_014-Ex1-11C-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_014-Ex1-11C-lcwgs-1-1.2.fq.gz
ZdiADup015_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_015-Ex1-11D-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_015-Ex1-11D-lcwgs-1-1.2.fq.gz
ZdiADup016_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_016-Ex1-11E-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_016-Ex1-11E-lcwgs-1-1.2.fq.gz
ZdiADup017_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_017-Ex1-11F-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_017-Ex1-11F-lcwgs-1-1.2.fq.gz
ZdiADup018_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_018-Ex1-11G-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_018-Ex1-11G-lcwgs-1-1.2.fq.gz
ZdiADup019_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_019-Ex1-11H-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_019-Ex1-11H-lcwgs-1-1.2.fq.gz
ZdiADup020_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_020-Ex1-12A-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_020-Ex1-12A-lcwgs-1-1.2.fq.gz
ZdiADup021_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_021-Ex1-12B-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_021-Ex1-12B-lcwgs-1-1.2.fq.gz
ZdiADup022_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_022-Ex1-12C-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_022-Ex1-12C-lcwgs-1-1.2.fq.gz
ZdiADup023_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_023-Ex1-12D-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_023-Ex1-12D-lcwgs-1-1.2.fq.gz
ZdiADup024_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_024-Ex1-12E-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_024-Ex1-12E-lcwgs-1-1.2.fq.gz
ZdiADup025_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_025-Ex1-2A-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_025-Ex1-2A-lcwgs-1-1.2.fq.gz
ZdiADup026_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_026-Ex1-12G-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_026-Ex1-12G-lcwgs-1-1.2.fq.gz
ZdiADup027_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_027-Ex1-12H-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_027-Ex1-12H-lcwgs-1-1.2.fq.gz
ZdiADup028_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_028-Ex1-9F-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_028-Ex1-9F-lcwgs-1-1.2.fq.gz
ZdiADup029_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_029-Ex1-1A-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_029-Ex1-1A-lcwgs-1-1.2.fq.gz
ZdiADup030_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_030-Ex1-1B-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_030-Ex1-1B-lcwgs-1-1.2.fq.gz
ZdiADup031_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_031-Ex1-1C-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_031-Ex1-1C-lcwgs-1-1.2.fq.gz
ZdiADup032_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_032-Ex1-1D-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_032-Ex1-1D-lcwgs-1-1.2.fq.gz
ZdiADup033_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_033-Ex1-1E-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_033-Ex1-1E-lcwgs-1-1.2.fq.gz
ZdiADup034_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_034-Ex1-1F-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_034-Ex1-1F-lcwgs-1-1.2.fq.gz
ZdiADup035_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_035-Ex1-1G-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_035-Ex1-1G-lcwgs-1-1.2.fq.gz
ZdiADup036_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_036-Ex1-1H-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_036-Ex1-1H-lcwgs-1-1.2.fq.gz
ZdiADup037_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_037-Ex1-3D-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_037-Ex1-3D-lcwgs-1-1.2.fq.gz
ZdiADup038_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_038-Ex1-2B-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_038-Ex1-2B-lcwgs-1-1.2.fq.gz
ZdiADup039_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_039-Ex1-2C-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_039-Ex1-2C-lcwgs-1-1.2.fq.gz
ZdiADup040_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_040-Ex1-2D-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_040-Ex1-2D-lcwgs-1-1.2.fq.gz
ZdiADup041_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_041-Ex1-2E-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_041-Ex1-2E-lcwgs-1-1.2.fq.gz
ZdiADup042_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_042-Ex1-2F-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_042-Ex1-2F-lcwgs-1-1.2.fq.gz
ZdiADup043_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_043-Ex1-2G-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_043-Ex1-2G-lcwgs-1-1.2.fq.gz
ZdiADup044_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_044-Ex1-2H-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_044-Ex1-2H-lcwgs-1-1.2.fq.gz
ZdiADup045_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_045-Ex1-3A-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_045-Ex1-3A-lcwgs-1-1.2.fq.gz
ZdiADup046_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_046-Ex1-3B-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_046-Ex1-3B-lcwgs-1-1.2.fq.gz
ZdiADup047_Ex1_L2 2277W2LT4:2 illumina historical/Zdi-ADup_047-Ex1-3C-lcwgs-1-1.1.fq.gz historical/Zdi-ADup_047-Ex1-3C-lcwgs-1-1.2.fq.gz
ZdiADup001_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_001-Ex1-11B-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_001-Ex1-11B-lcwgs-1-2.2.fq.gz
ZdiADup002_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_002-Ex1-9G-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_002-Ex1-9G-lcwgs-1-2.2.fq.gz
ZdiADup003_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_003-Ex1-9H-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_003-Ex1-9H-lcwgs-1-2.2.fq.gz
ZdiADup004_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_004-Ex1-10A-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_004-Ex1-10A-lcwgs-1-2.2.fq.gz
ZdiADup005_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_005-Ex1-10B-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_005-Ex1-10B-lcwgs-1-2.2.fq.gz
ZdiADup006_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_006-Ex1-10C-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_006-Ex1-10C-lcwgs-1-2.2.fq.gz
ZdiADup007_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_007-Ex1-10D-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_007-Ex1-10D-lcwgs-1-2.2.fq.gz
ZdiADup008_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_008-Ex1-10E-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_008-Ex1-10E-lcwgs-1-2.2.fq.gz
ZdiADup009_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_009-Ex1-10F-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_009-Ex1-10F-lcwgs-1-2.2.fq.gz
ZdiADup010_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_010-Ex1-10G-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_010-Ex1-10G-lcwgs-1-2.2.fq.gz
ZdiADup011_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_011-Ex1-10H-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_011-Ex1-10H-lcwgs-1-2.2.fq.gz
ZdiADup012_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_012-Ex1-11A-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_012-Ex1-11A-lcwgs-1-2.2.fq.gz
ZdiADup013_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_013-Ex1-12F-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_013-Ex1-12F-lcwgs-1-2.2.fq.gz
ZdiADup014_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_014-Ex1-11C-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_014-Ex1-11C-lcwgs-1-2.2.fq.gz
ZdiADup015_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_015-Ex1-11D-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_015-Ex1-11D-lcwgs-1-2.2.fq.gz
ZdiADup016_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_016-Ex1-11E-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_016-Ex1-11E-lcwgs-1-2.2.fq.gz
ZdiADup017_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_017-Ex1-11F-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_017-Ex1-11F-lcwgs-1-2.2.fq.gz
ZdiADup018_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_018-Ex1-11G-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_018-Ex1-11G-lcwgs-1-2.2.fq.gz
ZdiADup019_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_019-Ex1-11H-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_019-Ex1-11H-lcwgs-1-2.2.fq.gz
ZdiADup020_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_020-Ex1-12A-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_020-Ex1-12A-lcwgs-1-2.2.fq.gz
ZdiADup021_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_021-Ex1-12B-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_021-Ex1-12B-lcwgs-1-2.2.fq.gz
ZdiADup022_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_022-Ex1-12C-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_022-Ex1-12C-lcwgs-1-2.2.fq.gz
ZdiADup023_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_023-Ex1-12D-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_023-Ex1-12D-lcwgs-1-2.2.fq.gz
ZdiADup024_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_024-Ex1-12E-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_024-Ex1-12E-lcwgs-1-2.2.fq.gz
ZdiADup025_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_025-Ex1-2A-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_025-Ex1-2A-lcwgs-1-2.2.fq.gz
ZdiADup026_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_026-Ex1-12G-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_026-Ex1-12G-lcwgs-1-2.2.fq.gz
ZdiADup027_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_027-Ex1-12H-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_027-Ex1-12H-lcwgs-1-2.2.fq.gz
ZdiADup028_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_028-Ex1-9F-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_028-Ex1-9F-lcwgs-1-2.2.fq.gz
ZdiADup029_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_029-Ex1-1A-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_029-Ex1-1A-lcwgs-1-2.2.fq.gz
ZdiADup030_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_030-Ex1-1B-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_030-Ex1-1B-lcwgs-1-2.2.fq.gz
ZdiADup031_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_031-Ex1-1C-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_031-Ex1-1C-lcwgs-1-2.2.fq.gz
ZdiADup032_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_032-Ex1-1D-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_032-Ex1-1D-lcwgs-1-2.2.fq.gz
ZdiADup033_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_033-Ex1-1E-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_033-Ex1-1E-lcwgs-1-2.2.fq.gz
ZdiADup034_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_034-Ex1-1F-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_034-Ex1-1F-lcwgs-1-2.2.fq.gz
ZdiADup035_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_035-Ex1-1G-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_035-Ex1-1G-lcwgs-1-2.2.fq.gz
ZdiADup036_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_036-Ex1-1H-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_036-Ex1-1H-lcwgs-1-2.2.fq.gz
ZdiADup037_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_037-Ex1-3D-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_037-Ex1-3D-lcwgs-1-2.2.fq.gz
ZdiADup038_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_038-Ex1-2B-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_038-Ex1-2B-lcwgs-1-2.2.fq.gz
ZdiADup039_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_039-Ex1-2C-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_039-Ex1-2C-lcwgs-1-2.2.fq.gz
ZdiADup040_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_040-Ex1-2D-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_040-Ex1-2D-lcwgs-1-2.2.fq.gz
ZdiADup041_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_041-Ex1-2E-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_041-Ex1-2E-lcwgs-1-2.2.fq.gz
ZdiADup042_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_042-Ex1-2F-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_042-Ex1-2F-lcwgs-1-2.2.fq.gz
ZdiADup043_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_043-Ex1-2G-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_043-Ex1-2G-lcwgs-1-2.2.fq.gz
ZdiADup044_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_044-Ex1-2H-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_044-Ex1-2H-lcwgs-1-2.2.fq.gz
ZdiADup045_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_045-Ex1-3A-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_045-Ex1-3A-lcwgs-1-2.2.fq.gz
ZdiADup046_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_046-Ex1-3B-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_046-Ex1-3B-lcwgs-1-2.2.fq.gz
ZdiADup047_Ex1_L4 227NLCLT4:4 illumina historical/Zdi-ADup_047-Ex1-3C-lcwgs-1-2.1.fq.gz historical/Zdi-ADup_047-Ex1-3C-lcwgs-1-2.2.fq.gz
```
**Zdi_historical_samples.txt:**
```
[hpc-0356@wahab-01 config]$ cat Zdi_modern_samples.txt 
samplename_index_lane readgroup_id readgroup_platform path_to_R1_fastq_file path_to_R2_fastq_file
ZdiCDup001_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_001-Ex1-5D-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_001-Ex1-5D-lcwgs-1-1.2.fq.gz
ZdiCDup002_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_002-Ex1-5E-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_002-Ex1-5E-lcwgs-1-1.2.fq.gz
ZdiCDup003_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_003-Ex1-5F-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_003-Ex1-5F-lcwgs-1-1.2.fq.gz
ZdiCDup004_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_004-Ex1-5G-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_004-Ex1-5G-lcwgs-1-1.2.fq.gz
ZdiCDup005_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_005-Ex1-5H-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_005-Ex1-5H-lcwgs-1-1.2.fq.gz
ZdiCDup006_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_006-Ex1-6A-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_006-Ex1-6A-lcwgs-1-1.2.fq.gz
ZdiCDup007_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_007-Ex1-6B-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_007-Ex1-6B-lcwgs-1-1.2.fq.gz
ZdiCDup008_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_008-Ex1-6C-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_008-Ex1-6C-lcwgs-1-1.2.fq.gz
ZdiCDup010_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_010-Ex1-6D-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_010-Ex1-6D-lcwgs-1-1.2.fq.gz
ZdiCDup011_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_011-Ex1-6E-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_011-Ex1-6E-lcwgs-1-1.2.fq.gz
ZdiCDup012_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_012-Ex1-6F-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_012-Ex1-6F-lcwgs-1-1.2.fq.gz
ZdiCDup013_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_013-Ex1-6G-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_013-Ex1-6G-lcwgs-1-1.2.fq.gz
ZdiCDup014_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_014-Ex1-6H-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_014-Ex1-6H-lcwgs-1-1.2.fq.gz
ZdiCDup015_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_015-Ex1-7A-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_015-Ex1-7A-lcwgs-1-1.2.fq.gz
ZdiCDup016_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_016-Ex1-7B-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_016-Ex1-7B-lcwgs-1-1.2.fq.gz
ZdiCDup017_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_017-Ex1-7C-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_017-Ex1-7C-lcwgs-1-1.2.fq.gz
ZdiCDup018_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_018-Ex1-7D-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_018-Ex1-7D-lcwgs-1-1.2.fq.gz
ZdiCDup019_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_019-Ex1-7E-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_019-Ex1-7E-lcwgs-1-1.2.fq.gz
ZdiCDup020_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_020-Ex1-7F-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_020-Ex1-7F-lcwgs-1-1.2.fq.gz
ZdiCDup021_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_021-Ex1-7G-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_021-Ex1-7G-lcwgs-1-1.2.fq.gz
ZdiCDup022_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_022-Ex1-7H-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_022-Ex1-7H-lcwgs-1-1.2.fq.gz
ZdiCDup023_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_023-Ex1-8A-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_023-Ex1-8A-lcwgs-1-1.2.fq.gz
ZdiCDup024_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_024-Ex1-8B-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_024-Ex1-8B-lcwgs-1-1.2.fq.gz
ZdiCDup025_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_025-Ex1-8C-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_025-Ex1-8C-lcwgs-1-1.2.fq.gz
ZdiCDup026_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_026-Ex1-8D-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_026-Ex1-8D-lcwgs-1-1.2.fq.gz
ZdiCDup027_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_027-Ex1-8E-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_027-Ex1-8E-lcwgs-1-1.2.fq.gz
ZdiCDup028_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_028-Ex1-8F-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_028-Ex1-8F-lcwgs-1-1.2.fq.gz
ZdiCDup029_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_029-Ex1-8G-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_029-Ex1-8G-lcwgs-1-1.2.fq.gz
ZdiCDup030_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_030-Ex1-8H-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_030-Ex1-8H-lcwgs-1-1.2.fq.gz
ZdiCDup031_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_031-Ex1-9A-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_031-Ex1-9A-lcwgs-1-1.2.fq.gz
ZdiCDup032_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_032-Ex1-9B-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_032-Ex1-9B-lcwgs-1-1.2.fq.gz
ZdiCDup033_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_033-Ex1-9C-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_033-Ex1-9C-lcwgs-1-1.2.fq.gz
ZdiCDup034_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_034-Ex1-9D-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_034-Ex1-9D-lcwgs-1-1.2.fq.gz
ZdiCDup035_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_035-Ex1-9E-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_035-Ex1-9E-lcwgs-1-1.2.fq.gz
ZdiCDup036_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_036-Ex1-9F-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_036-Ex1-9F-lcwgs-1-1.2.fq.gz
ZdiCDup037_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_037-Ex1-9G-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_037-Ex1-9G-lcwgs-1-1.2.fq.gz
ZdiCDup038_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_038-Ex1-9H-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_038-Ex1-9H-lcwgs-1-1.2.fq.gz
ZdiCDup039_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_039-Ex1-10A-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_039-Ex1-10A-lcwgs-1-1.2.fq.gz
ZdiCDup040_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_040-Ex1-10B-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_040-Ex1-10B-lcwgs-1-1.2.fq.gz
ZdiCDup041_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_041-Ex1-10C-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_041-Ex1-10C-lcwgs-1-1.2.fq.gz
ZdiCDup042_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_042-Ex1-10D-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_042-Ex1-10D-lcwgs-1-1.2.fq.gz
ZdiCDup043_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_043-Ex1-10E-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_043-Ex1-10E-lcwgs-1-1.2.fq.gz
ZdiCDup044_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_044-Ex1-10F-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_044-Ex1-10F-lcwgs-1-1.2.fq.gz
ZdiCDup045_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_045-Ex1-10G-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_045-Ex1-10G-lcwgs-1-1.2.fq.gz
ZdiCDup046_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_046-Ex1-10H-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_046-Ex1-10H-lcwgs-1-1.2.fq.gz
ZdiCDup047_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_047-Ex1-11A-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_047-Ex1-11A-lcwgs-1-1.2.fq.gz
ZdiCDup048_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_048-Ex1-11B-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_048-Ex1-11B-lcwgs-1-1.2.fq.gz
ZdiCDup049_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_049-Ex1-11C-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_049-Ex1-11C-lcwgs-1-1.2.fq.gz
ZdiCDup050_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_050-Ex1-11D-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_050-Ex1-11D-lcwgs-1-1.2.fq.gz
ZdiCDup051_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_051-Ex1-11E-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_051-Ex1-11E-lcwgs-1-1.2.fq.gz
ZdiCDup053_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_053-Ex1-11F-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_053-Ex1-11F-lcwgs-1-1.2.fq.gz
ZdiCDup054_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_054-Ex1-11G-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_054-Ex1-11G-lcwgs-1-1.2.fq.gz
ZdiCDup055_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_055-Ex1-11H-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_055-Ex1-11H-lcwgs-1-1.2.fq.gz
ZdiCDup056_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_056-Ex1-12A-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_056-Ex1-12A-lcwgs-1-1.2.fq.gz
ZdiCDup057_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_057-Ex1-12B-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_057-Ex1-12B-lcwgs-1-1.2.fq.gz
ZdiCDup058_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_058-Ex1-12C-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_058-Ex1-12C-lcwgs-1-1.2.fq.gz
ZdiCDup059_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_059-Ex1-12D-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_059-Ex1-12D-lcwgs-1-1.2.fq.gz
ZdiCDup060_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_060-Ex1-12E-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_060-Ex1-12E-lcwgs-1-1.2.fq.gz
ZdiCDup061_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_061-Ex1-12F-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_061-Ex1-12F-lcwgs-1-1.2.fq.gz
ZdiCDup062_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_062-Ex1-12G-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_062-Ex1-12G-lcwgs-1-1.2.fq.gz
ZdiCDup064_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_064-Ex1-5A-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_064-Ex1-5A-lcwgs-1-1.2.fq.gz
ZdiCDup065_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_065-Ex1-5B-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_065-Ex1-5B-lcwgs-1-1.2.fq.gz
ZdiCDup066_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_066-Ex1-5C-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_066-Ex1-5C-lcwgs-1-1.2.fq.gz
ZdiCDup071_Ex1_L2 2277W2LT4:2 illumina modern/Zdi-CDup_071-Ex1-12H-lcwgs-1-1.1.fq.gz modern/Zdi-CDup_071-Ex1-12H-lcwgs-1-1.2.fq.gz
ZdiCDup001_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_001-Ex1-5D-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_001-Ex1-5D-lcwgs-1-2.2.fq.gz
ZdiCDup002_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_002-Ex1-5E-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_002-Ex1-5E-lcwgs-1-2.2.fq.gz
ZdiCDup003_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_003-Ex1-5F-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_003-Ex1-5F-lcwgs-1-2.2.fq.gz
ZdiCDup004_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_004-Ex1-5G-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_004-Ex1-5G-lcwgs-1-2.2.fq.gz
ZdiCDup005_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_005-Ex1-5H-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_005-Ex1-5H-lcwgs-1-2.2.fq.gz
ZdiCDup006_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_006-Ex1-6A-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_006-Ex1-6A-lcwgs-1-2.2.fq.gz
ZdiCDup007_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_007-Ex1-6B-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_007-Ex1-6B-lcwgs-1-2.2.fq.gz
ZdiCDup008_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_008-Ex1-6C-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_008-Ex1-6C-lcwgs-1-2.2.fq.gz
ZdiCDup010_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_010-Ex1-6D-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_010-Ex1-6D-lcwgs-1-2.2.fq.gz
ZdiCDup011_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_011-Ex1-6E-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_011-Ex1-6E-lcwgs-1-2.2.fq.gz
ZdiCDup012_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_012-Ex1-6F-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_012-Ex1-6F-lcwgs-1-2.2.fq.gz
ZdiCDup013_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_013-Ex1-6G-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_013-Ex1-6G-lcwgs-1-2.2.fq.gz
ZdiCDup014_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_014-Ex1-6H-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_014-Ex1-6H-lcwgs-1-2.2.fq.gz
ZdiCDup015_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_015-Ex1-7A-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_015-Ex1-7A-lcwgs-1-2.2.fq.gz
ZdiCDup016_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_016-Ex1-7B-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_016-Ex1-7B-lcwgs-1-2.2.fq.gz
ZdiCDup017_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_017-Ex1-7C-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_017-Ex1-7C-lcwgs-1-2.2.fq.gz
ZdiCDup018_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_018-Ex1-7D-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_018-Ex1-7D-lcwgs-1-2.2.fq.gz
ZdiCDup019_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_019-Ex1-7E-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_019-Ex1-7E-lcwgs-1-2.2.fq.gz
ZdiCDup021_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_021-Ex1-7G-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_021-Ex1-7G-lcwgs-1-2.2.fq.gz
ZdiCDup022_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_022-Ex1-7H-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_022-Ex1-7H-lcwgs-1-2.2.fq.gz
ZdiCDup026_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_026-Ex1-8D-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_026-Ex1-8D-lcwgs-1-2.2.fq.gz
ZdiCDup031_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_031-Ex1-9A-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_031-Ex1-9A-lcwgs-1-2.2.fq.gz
ZdiCDup033_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_033-Ex1-9C-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_033-Ex1-9C-lcwgs-1-2.2.fq.gz
ZdiCDup034_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_034-Ex1-9D-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_034-Ex1-9D-lcwgs-1-2.2.fq.gz
ZdiCDup035_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_035-Ex1-9E-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_035-Ex1-9E-lcwgs-1-2.2.fq.gz
ZdiCDup037_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_037-Ex1-9G-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_037-Ex1-9G-lcwgs-1-2.2.fq.gz
ZdiCDup038_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_038-Ex1-9H-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_038-Ex1-9H-lcwgs-1-2.2.fq.gz
ZdiCDup039_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_039-Ex1-10A-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_039-Ex1-10A-lcwgs-1-2.2.fq.gz
ZdiCDup040_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_040-Ex1-10B-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_040-Ex1-10B-lcwgs-1-2.2.fq.gz
ZdiCDup041_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_041-Ex1-10C-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_041-Ex1-10C-lcwgs-1-2.2.fq.gz
ZdiCDup042_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_042-Ex1-10D-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_042-Ex1-10D-lcwgs-1-2.2.fq.gz
ZdiCDup043_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_043-Ex1-10E-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_043-Ex1-10E-lcwgs-1-2.2.fq.gz
ZdiCDup045_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_045-Ex1-10G-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_045-Ex1-10G-lcwgs-1-2.2.fq.gz
ZdiCDup046_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_046-Ex1-10H-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_046-Ex1-10H-lcwgs-1-2.2.fq.gz
ZdiCDup047_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_047-Ex1-11A-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_047-Ex1-11A-lcwgs-1-2.2.fq.gz
ZdiCDup050_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_050-Ex1-11D-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_050-Ex1-11D-lcwgs-1-2.2.fq.gz
ZdiCDup051_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_051-Ex1-11E-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_051-Ex1-11E-lcwgs-1-2.2.fq.gz
ZdiCDup054_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_054-Ex1-11G-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_054-Ex1-11G-lcwgs-1-2.2.fq.gz
ZdiCDup056_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_056-Ex1-12A-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_056-Ex1-12A-lcwgs-1-2.2.fq.gz
ZdiCDup057_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_057-Ex1-12B-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_057-Ex1-12B-lcwgs-1-2.2.fq.gz
ZdiCDup058_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_058-Ex1-12C-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_058-Ex1-12C-lcwgs-1-2.2.fq.gz
ZdiCDup059_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_059-Ex1-12D-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_059-Ex1-12D-lcwgs-1-2.2.fq.gz
ZdiCDup060_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_060-Ex1-12E-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_060-Ex1-12E-lcwgs-1-2.2.fq.gz
ZdiCDup061_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_061-Ex1-12F-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_061-Ex1-12F-lcwgs-1-2.2.fq.gz
ZdiCDup062_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_062-Ex1-12G-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_062-Ex1-12G-lcwgs-1-2.2.fq.gz
ZdiCDup064_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_064-Ex1-5A-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_064-Ex1-5A-lcwgs-1-2.2.fq.gz
ZdiCDup065_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_065-Ex1-5B-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_065-Ex1-5B-lcwgs-1-2.2.fq.gz
ZdiCDup066_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_066-Ex1-5C-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_066-Ex1-5C-lcwgs-1-2.2.fq.gz
ZdiCDup071_Ex1_L4 227NLCLT4:4 illumina modern/Zdi-CDup_071-Ex1-12H-lcwgs-1-2.1.fq.gz modern/Zdi-CDup_071-Ex1-12H-lcwgs-1-2.2.fq.gz
```
The next step is to copy the Sumatran rhino test config file to Zdi's config directory and then edit the file, but the majority of edits made to it do not need to be changed per species, so I will copy a config file that I previously edited for Pbb. All of the edits to that file are listed [here](https://github.com/philippinespire/pire_parupeneus_barberinus_lcwgs/tree/main/GenErode_Pbb).
```
[hpc-0356@wahab-01 config]$ cp /archive/carpenterlab/pire/pire_parupeneus_barberinus_lcwgs/GenErode_Pbb/config/config.yaml .
```
Then I edited the file to include Zdi specific information:

* **ref_path:** "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2/reference/reference.genbank.Zdi.fasta"
* **historical_samples:** "config/Zdi_historical_samples.txt"
* **modern_samples:** "config/Zdi_modern_samples.txt"
* **historical_rescaled_samplenames:** ["ZdiADup001","ZdiADup002","ZdiADup003","ZdiADup004","ZdiADup005","ZdiADup006","ZdiADup007","ZdiADup008","ZdiADup009","ZdiADup010","ZdiADup011","ZdiADup012","ZdiADup013","ZdiADup014","ZdiADup015","ZdiADup016","ZdiADup017","ZdiADup018","ZdiADup019","ZdiADup020","ZdiADup021","ZdiADup022","ZdiADup023","ZdiADup024","ZdiADup025","ZdiADup026","ZdiADup027","ZdiADup028","ZdiADup029","ZdiADup030","ZdiADup031","ZdiADup032","ZdiADup033","ZdiADup034","ZdiADup035","ZdiADup036","ZdiADup037","ZdiADup038","ZdiADup039","ZdiADup040","ZdiADup041","ZdiADup042","ZdiADup043","ZdiADup044","ZdiADup045","ZdiADup046","ZdiADup047"]
* **gerp_ref_path:** "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2/gerp_outgroups"
* **tree:** "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2/Zdi_gerp_tree.nwk"

---
</details>

<details><summary>4. Run GenErode</summary>

### 4. Run GenErode

Copy the sbatch script
```
[hpc-0356@wahab-01 GenErode_Zdi]$ cp /home/e1garcia/shotgun_PIRE/pire_lcwgs_data_processing/scripts/GenErode_Wahab/run_GenErode.sbatch .
```
Run GenErode:
```
[hpc-0356@wahab-01 GenErode_Zdi]$ sbatch run_GenErode.sbatch
```
#### Failed jobs and their errors:

* **3617731:**
    * `FileNotFoundError: [Errno 2] No such file or directory:'results/logs/2_mapping/historical/reference.genbank.Zdi'`
    * this directory does exist, though, so I will just rerun the script

* **3621604:** 
    * `Error message: sacct: error: slurm_persist_conn_open_without_init: failed to open persistent connection to host:head-2.ib.cluster:6819: Connection timed out`

* **3624474:**
    * errors with `Xenentodon_cancila` files but we can't identify the issue. May have been due to the timeout from before so I will rerun with an incomplete tag this time.
    * ```
      [hpc-0356@wahab-01 GenErode_Zdi]$ cp run_GenErode.sbatch ./run_GenErode_incomplete.sbatch
      [hpc-0356@wahab-01 GenErode_Zdi]$ nano run_GenErode_incomplete.sbatch
          # add --rerun-incomplete tag
      [hpc-0356@wahab-01 GenErode_Zdi]$ sbatch run_GenErode_incomplete.sbatch
      ```

* **3624828:**
    *  more errors involving `Xenentodon_cancila` but we cannot identify the issue. I have to remove that species, but that leaves me with only 29 genomes. See **2. Get Newick Tree** for more details.
    * <details><summary> >>>> Making a new directory: GenErode_Zdi_2 <<<< </summary>
      
      ```
      [hpc-0356@wahab-01 pire_zenarchopterus_dispar_lcwgs]$ mkdir GenErode_Zdi_2
       # remake directories
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ mkdir config
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ mkdir historical
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ mkdir modern
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ mkdir mitochondria
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ mkdir reference
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ mkdir gerp_outgroups
  
      # populate them
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ cp -r ../GenErode_Zdi/modern/ .
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ cp -r ../GenErode_Zdi/historical/ .
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ cp -r ../GenErode_Zdi/gerp_outgroups/ .  # having removed Xenentodon cancila first
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ cp -r ../GenErode_Zdi/config/ .
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ cp -r ../GenErode_Zdi/reference/reference.genbank.Zdi.fasta reference/.

      # edit config.yaml file with new path
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ nano config.yaml
      ref_path: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2/reference/reference.genbank.Zdi.fasta"
      gerp_ref_path: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2/gerp_outgroups"
      tree: "/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2/Zdi_gerp_tree.nwk"
  
       # add temple dir folders
      [hpc-0356@wahab-01 GenErode_Zdi_2]$ cp -r /home/e1garcia/shotgun_PIRE/pire_lcwgs_data_processing/scripts/GenErode_Wahab/GenErode_templatedir/* .
  
       # add new nwk files
       [hpc-0356@wahab-01 GenErode_Zdi_2]$ cd ~/Downloads
       giannamazzei@Giannas-Laptop Downloads % scp Zdi_gerp_tree.nwk hpc-0356@wahab.hpc.odu.edu:/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2
       giannamazzei@Giannas-Laptop Downloads % scp Zdi_prunetree.jpg hpc-0356@wahab.hpc.odu.edu:/archive/carpenterlab/pire/pire_zenarchopterus_dispar_lcwgs/GenErode_Zdi_2
       [hpc-0356@wahab-01 GenErode_Zdi_2]$ sed -i 's/Dermogenys_collettei/reference.genbank.Zdi.fasta/g' Zdi_gerp_tree.nwk
       ```
       </details>

 ### _The following have been run in `GenErode_Zdi_2`_

Copy the sbatch script
```
[hpc-0356@wahab-01 GenErode_Zdi_2]$ cp /home/e1garcia/shotgun_PIRE/pire_lcwgs_data_processing/scripts/GenErode_Wahab/run_GenErode.sbatch .
```
Run GenErode:
```
[hpc-0356@wahab-01 GenErode_Zdi_2]$ sbatch run_GenErode.sbatch
```
#### Failed jobs and their errors:
* **3674736** -> (currently running)


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
