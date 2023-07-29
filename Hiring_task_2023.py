import pandas as pd

print("Reading Files...")

symbol = pd.read_table("Homo_sapiens.gene_info.gz") # Reading .gz File
gmt = open("h.all.v2023.1.Hs.symbols.gmt")  # Opening GMT file in read mode

print("Mapping gene symbols and synonyms to corresponding GeneIDs...")

map = dict(zip(symbol.Symbol,symbol.GeneID)) # Mapping all Gene symbols to corresponding GeneIDs and storing as a key,value pair in a dictionary
column5_values = symbol.Synonyms.str.split("|") # Splitting all synonym values by "|" from column5 and saving as arrays in column5_values

for i in column5_values.index: 
        length = len(column5_values[i])
        v = [symbol.GeneID[i]]*length   # Creating an array of similar GeneID of length complementary to number of synonyms to be mapped
        if column5_values[i][0] == "-":  # Skipping the blank synonym values
                continue
        else:
                map_secondary = dict(zip(column5_values[i],v)) # Mapping all Gene synonyms to corresponding GeneIDs and storing as a key,value pair in a dictionary
                map.update(map_secondary) # Combining both the mapping dictionaries into one. For repeating values of gene symbols and synonyms, the last value of GeneID found, is accepted
# NOTE: There were 50 gene symbols and 67 gene synonyms which were repeating with different GeneIDs in the Homo_sapiens.gene_info.gz 
# NOTE: Among these only 1 gene symbol (HBD) was getting mapped to h.all.v2023.1.Hs.symbols.gmt file. Because there was no specification for dealing with repeating values, so for the time being, repeating gene symbols/synonyms were replaced with last GeneIds encountered 

print("Creating new GMT file...")

with open("Output_GMT.gmt","w") as outfile:  # Creating a new GMT file for output
        for line in gmt:
                new_line = line.rstrip().split("\t")  # Reading gmt file line by line and storing all values of a line as array
                new_line = [map.get(k,k) for k in new_line]  # Replacing the gene symbols/synonyms from gmt file with GeneIDs as stored in the above dictionary
                outfile.write("\t".join(str(each) for each in new_line) + "\n")  # Writing all the mapped GeneIDs to the new Tab-delimited GMT file 
outfile.close()
print("Done")
