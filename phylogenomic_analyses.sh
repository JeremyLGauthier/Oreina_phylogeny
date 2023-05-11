
#! /bin/bash

#PHYLOGENY PART
#$1 alignment phylip format
#$2 partition file

#PART 1 PARTITION FINDER TO IDENTIFY PARTITIONS

mkdir FOLDER
ln -s ../$1 ./FOLDER/$1


header="
## ALIGNMENT FILE ##\n
alignment = $1;\n
\n
## BRANCHLENGTHS: linked | unlinked ##\n
branchlengths = linked;\n
\n
## MODELS OF EVOLUTION: all | allx | mrbayes | beast | gamma | gammai | <list> ##\n
models = GTR, GTR+G, GTR+I+G;\n
\n
# MODEL SELECCTION: AIC | AICc | BIC #\n
model_selection = aicc;\n
\n
## DATA BLOCKS: see manual for how to define ##\n
[data_blocks]"

echo -e $header >> ./FOLDER/partition_finder.cfg
awk '{print $1";"}' $2 >> ./FOLDER/partition_finder.cfg

end="\n
## SCHEMES, search: all | user | greedy | rcluster | rclusterf | kmeans##\n
[schemes]\n
search = rcluster;\n"

echo -e $end >> ./FOLDER/partition_finder.cfg
PartitionFinder.py -p 6 -r FOLDER/


#PART 2 IQ TREE MODEL TO EACH PARTITION
sed -e 's/RaxML/@/g' -e 's/#nexus/@#nexus/g' ./FOLDER/analysis/best_scheme.txt | tr '\n' '?' | tr '@' '\n' | grep "#nexus" | tr '?' '\n' | grep -v "charpartition PartitionFinder" > partitionfinder_best_scheme_partitions.nex
iqtree -s $1 -m MFP -spp partitionfinder_best_scheme_partitions.nex -safe

#PART 3 IQ TREE PHYLOGENY
iqtree -s $1 -spp partitionfinder_best_scheme_partitions_models.nex -bb 1000 -bnni -alrt 1000 -nt 6 -o M1501_Timarcha_gottingensis -safe -pre concatenated_alignment_output


#SORTADATE
#Locus tree
for i in `ls locus_*.phy`
	do
	iqtree -s "$i" -st DNA -m MFP -o M1501_Timarcha_gottingensis -AICc -T AUTO -safe
	done

#Rooting
for i in `ls *.treefile` ; do pxrr -t "$i" -g M1501_Timarcha_gottingensis -o "$i"_root.tree ; done

#Selection
python /SortaDate/src/get_var_length.py GeneT/ --flend .tree --outf var
python /SortaDate/src/get_bp_genetrees.py GeneT/ rooted.concatenated_alignment_output.treefile --flend .tree --outf bp
python /SortaDate/src/combine_results.py var bp --outf comb
python /SortaDate/src/get_good_genes.py comb --order 3,1,2 --max 50 --outf gg312

grep -v "name" gg312 | head -n 200 | awk '{print $1}' > list_keep
while read a ; do name=`echo $a | sed -e 's/.phy.treefile_root.tree//g'` ; cp ../"$name" ./KEEP/ ; done < list_keep




