# Oreina_phylogeny





Data and scripts used to perform phylogenomic analyses for *Oreina* phylogeny (Systematic Entomology 2023)


### Script description:

1. Read processing and loci reconstruction using phyloHyRAD pipeline:<br>
**https://github.com/JeremyLGauthier/PHyRAD/tree/master/phyloHyRAD**

2. Phylogenomic process including IQtree and Sortadate:<br>
**phylogenomic_analyses.sh**

3. Biogeographic reconstruction using BioGeoBears:<br>
**script\_BioGeoBears\_Oreina.r**

4. Host plant reconstruction using Phytools:<br>
**script\_hostplant\_phytools\_Oreina.r**



### Data description :

1. Global alignement and partition file:<br>
**Oreina\_concatenated\_148s.phylip**
**Oreina\_partitionfinder\_best\_scheme\_partitions\_models.nex**

2. Best tree obtained for each dataset:<br>
**Oreina\_datasetA\_iqtree.nexus**
**Oreina\_datasetB\_iqtree.newick**
**Oreina\_datasetC\_BEAST.tree**

3. Dating file for BEAST:<br>
**Oreina\_200loci\_sortadate\_9clocks\_Uncorr\_relax\_TruelogNorm\_Yule\_1calib.xml**




