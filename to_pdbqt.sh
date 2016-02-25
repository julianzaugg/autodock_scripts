#! /bin/bash
PDBLOCATION=""
OUTLOCATION=""
for f in PDBLOCATION/*.pdb; do
	b=`basename $f .pdb`
	echo Converting pdb $b
	prepare_receptor4.py -r $f -o OUTLOCATION/${b}.pdbqt -A checkhydrogens -U waters
done