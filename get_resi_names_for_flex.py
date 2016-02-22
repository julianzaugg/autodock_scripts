#!/usr/bin/python
"""
For assisting in using Autodock python preparation scripts.

Given a pdb structure and a list of residue numbers, will output full names 
of residues for each chain in the pdb, in the format required for `prepare_flexreceptor4.py'
E.g.,  RECEPTOR_NAME:CHAINID:ARG8_ILE84

input :
-pdb  pdb structure
-positions positions to grab residue information; '215'


Requires Biopython
"""
import argparse
import sys

import Bio
from Bio.PDB import *


if __name__ == "__main__":
    input_parser = argparse.ArgumentParser(description='Description to be added')
    input_parser.add_argument('-r', '--receptor', help='Input PDB file', required=True)
    input_parser.add_argument('-p', '--positions', help='Positions to extract',nargs='+', required=True)
    args = input_parser.parse_args()
    pdb_parser = PDBParser()
    structure = pdb_parser.get_structure(args.receptor.split("/")[-1].split(".")[0], args.receptor)
    model =structure[0]
    splitted_input_positions = map(int, args.positions[0].split(","))

    chain_strs = []
    for chain in model:
        # cur_chain = model[chain.id]
        chain_str = ":".join([structure.id, chain.id])
        cnt = 0
        for position in splitted_input_positions:
            residue = chain[(' ', position, ' ')]
            if cnt == 0:
                joiner = ":"
                cnt += 1
            else: joiner = "_"
            chain_str += joiner + residue.get_resname() + str(position)
        print "CHAIN %s residue string : " % (chain.id) + chain_str
        chain_strs.append(chain_str)
    print
    print "COMBINED STRING : " + ",".join(chain_strs)

