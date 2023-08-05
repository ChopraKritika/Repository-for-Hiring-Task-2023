library(ggplot2)   #Loading the ggplot2 library
file <- read.csv(gzfile("Homo_sapiens.gene_info.gz"), fill = TRUE, header= T, sep="\t")   #Reading the provided tab separated .gz file
graph = ggplot(file[which(file$chromosome != "-" & !grepl("\\|", file$chromosome)),],   #Discarding the rows which represents no value as "-" or ambiguous values with "|" and providing rest of the data to ggplot function for plotting
	aes(factor(chromosome, level=c(1:22,"X","Y","MT","Un"))))+   #Stating "Chromosome" column for plotting x-axis in the specified order (order taken from the provided reference graph)  
	geom_bar(fill="grey30")+   #Specifying Bar graph to be plotted with the provided data	
	xlab("Chromosomes")+   #Setting x-axis label
	ylab("Gene count")+   #Setting y-axis label
	ggtitle("Number of genes in each chromosome")+   #Setting title of the plot	
	theme_classic()+   #Adding a particular theme to the plot (for specific layout and transparent background as depicted in the given reference graph)
	theme(plot.title = element_text(hjust=0.5))   #Center aligning the title of the plot
ggsave(graph, filename = "Graph.pdf")   #Saving the plot to a PDF file
