#! /bin/bash
LIGANDS="/Users/julianzaugg/Documents/University/Phd/Projects/Evolutionary_Pathway/Results/Docking_analysis/Ligands"
RECEPTORS="."
#Vina configuration file
CONFIG="/Users/julianzaugg/Documents/University/Phd/Projects/Evolutionary_Pathway/Results/Docking_analysis/vina_configuration_files/general_3G0I_vina_conf.txt"
# Base directory to save results for each receptor and ligands
OUT="/Users/julianzaugg/Documents/University/Phd/Projects/Evolutionary_Pathway/Results/Docking_analysis/out"
REPEATS=5

for receptor in $RECEPTORS/*.pdbqt; do
	for ((n=0;n<$REPEATS;n++)); do
		b=`basename $receptor .pdbqt`
		for ligand in $LIGANDS/*.pdbqt; do
			lname=`basename $ligand .pdbqt`
			echo Processing $b $lname
			mkdir -p $OUT/$b/$lname
			outname=${b}_${lname}_conformations_${n}.pdbqt
			logfilename=${b}_${lname}_conformations_${n}_log.txt
			vina --config $CONFIG --out $OUT/$b/$lname/$outname --log $OUT/$b/$lname/$logfilename --receptor $receptor --ligand $ligand
		done
	done
done