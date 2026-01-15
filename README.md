# PTC-SLiM
SLiM scripts for simulating PTC evolution in cavefish

For full information on SLiM please see https://messerlab.org/slim/

**Note:** Generate a usage statement for any of my perl scripts using 

```
perl script.pl -h
```

## For calculating an estimated PTC-specific mutation rate used by all SLiM models

## estimate_mutationrate.pl
Estimates the probability of a PTC occurring in the cDNA of each gene supplied. 

Requires 2 input files: 
1. **PTC_codon_prob_key.txt** (contains the probability of producing a PTC at each nucleotide position for each possible codon)
2. a file containing cDNA sequences for each gene (one gene and sequence per line)
```
>ENSAMXT00000000567;GTTTCAGGGCTCCTCAGTTTCTGTGCGGCTGCTGTGAGCATGCGCGAGTCACGTGGGCGGCGCCGTGGGGGAAGCATGGCGGCG...
>ENSAMXT00000000488;ATTATGCTGCTAACTCTGTATACTGTTTACTCTATAGCATTTTCTTTCTCCGTCTAATTTTATGTTAAATGTTAAATTTAATTT...
```
**Note:** Calculation of synonymous substitution probability can be generated instead using **SYNONYMOUS_codon_prob_key.txt**


## For investigation of the potential strength and direction of selection on PTCs in caves
Our first objective using SLiM was to explore the potential strength and direction of selection on PTCs in caves. We explored the fate and frequency of de novo PTCs and those sourced from standing genetic variation (seeded into the population at the beginning of the model) under three different distributions of fitness effects (DFE)

### PTC_neutral_model.txt
Simulates 175k generations in a cavefish population (Ne = 32,000). Both de novo and standing PTCs have a fixed DFE at 0 (neither have any fitness effect). 

### PTC_gammaDFE_model.txt
Simulates 175k generations in a cavefish population (Ne = 32,000). PTCs receive a selection coefficient sampled from a gamma DFE with a specified mean and shape parameter. Under this distribution, PTCs never receive a selection coefficient greater than 0, (i.e., PTCs range from nearly neutral to strongly deleterious)

### PTC_normalDFE_model.txt
Simulates 175k generations in a cavefish population (Ne = 32,000). PTCs receive a selection coefficient sampled from a normal DFE with a specified mean and standard deviation. Under this distribution, PTCs range from beneficial (selection coefficient greater than 0) to deleterious (selection coefficient less than 0) as influenced by the distribution mean and standard deviation 

## For investigation of the role of effective population size and drift on PTC frequency
Our second objective using SLiM was to explore whether our observation that cave populations contain a significantly higher proportion of high-frequency PTCs than surface populations could be simply due to the smaller population size, and subsequently increased genetic drift, in caves. To investigate this, we re-ran the gamma DFE model (which fit our observed PTC frequency distribution most closely) with different population sizes (compared to our initial models using 32,000 individuals) to see how the proportion of high frequency PTCs would change.

### PTC_gammaDFE_model_Ne1000.txt
Cave population of 1,000 individuals

### PTC_gammaDFE_model_Ne8500.txt
Cave population of 8,500 individuals

### PTC_gammaDFE_model_Ne250k.txt
Cave population of 250,000 individuals
