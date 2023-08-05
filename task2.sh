# STEP 1: Considering the input file
file="NC_000913.faa.gz"    #Using the downloaded .gz file and saving its name inside the variable file
# If the file is to be downloaded from the given link and then the calculation is to be performed, follow the given two steps instead of the above one:
# (1) wget https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.faa  ---> Downloading the file
# (2) file="NC_000913.faa"   ---> Using the downloaded .faa file and saving its name inside the variable file

# STEP 2: Calculating the average length of protein in the given data 
echo "scale=2; `zcat $file|grep -v ">"|tr -d "\t,\n"|wc -c`  /  `zcat $file|grep ">" -c`" | bc   #NOTE: If .faa file is considered for caculation, replace zcat with cat  
# Explanation:
# (1)echo: Print the result of the following calculation to a new line
# (2)scale=2: Sets the decimal points to 2 for the resulting number to be calculated. It yields the result as 316.85, if no decimal points are required the scale can be set to 0 or other commands like expr can be used 
# (3)`zcat $file|grep -v ">"|tr -d "\t,\n"|wc -c`: Calculates the number of amino acids. Reads the file via zcat, identifies all sequence identifiers starting from ">" & reverses it via grep -v to select all amino acid sequences, removes the tab and newline characters from the sequences via tr, counts the number of amino acids present by wc -c.
# (4)/: sign of division
# (5)`zcat $file|grep ">" -c`: Calculates the number of protein sequences. Reads the file via zcat, identifies all the sequences and counts them via grep -c.
# (6)bc: Divides the number of amino acids(3) with number of protein sequences(5) and present the result upto two decimal places.
