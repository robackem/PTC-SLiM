# PTC-SLiM
SLiM scripts for simulating PTC evolution in cavefish

###PTC_neutral_model.txt
Simulates 175k generations in a cavefish population (Ne = 32,000). Both de novo PTCs and those sourced from standing genetic variation (seeded into the population at the beginning of the model) have a fixed distribution of fitness effects (DFE) at 0 (neither have any fitness effect). 

###PTC_gammaDFE_model.txt
Simulates 175k generations in a cavefish population (Ne = 32,000). PTCs receive a selection coefficient sampled from a gamma DFE with a specified mean and shape parameter. Under this distribution, PTCs never receive a selection coefficient greater than 0, (i.e., PTCs range from nearly neutral to strongly deleterious)

###PTC_normalDFE_model.txt
Simulates 175k generations in a cavefish population (Ne = 32,000). PTCs receive a selection coefficient sampled from a normal DFE with a specified mean and standard deviation. Under this distribution, PTCs range from beneficial (selection coefficient greater than 0) to deleterious (selection coefficient less than 0) as influenced by the distribution mean and standard deviation 
