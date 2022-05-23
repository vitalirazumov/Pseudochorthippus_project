#Importing packages and Avenir fonts
library(ggplot2)
library(extrafont)
library(RColorBrewer)
library(reshape2)
library(tidyverse)
library(RColorBrewer)
library(viridis)
loadfonts(loadfonts(device = "win"))

#Avenir fonts:
#Avenir Regular
#Avenir LT Std 65 Medium
#Avenir LT Std 45 Book
#Avenir LT Std 55 Roman

###SFS pvalue test

#Reading in the data
SFSpvalue1e2 <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/DeNovoStats/SFS/SFSDeNovo1e-2.sfs.em", header = F, sep = " ")
SFSpvalue1e2 <- SFSpvalue1e2[!is.na(SFSpvalue1e2)]
SFSpvalue1e2 <- SFSpvalue1e2[2:99]
SFSpvalue1e2 <- SFSpvalue1e2/sum(SFSpvalue1e2)

#Compiled data frame
SFSframe <- data.frame(SFSpvalue1, SFSpvalue5e1, SFSpvalue4e1, SFSpvalue2e1, SFSpvalue1e1, SFSpvalue1e2, SFSpvalue1e3, SFSpvalue1e4, SFSpvalue1e5, SFSpvalue1e6)
TransposedSFSFrame<- t(SFSpvalue1e2)
MeltedSFSFrame <- melt(TransposedSFSFrame)

#Barplot
ggplot(MeltedSFSFrame, aes(x = Var2, y = value)) +
  geom_bar(aes(fill = Var1), position = "dodge", stat = "identity") +
  ggtitle("SFS of varying p-values") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Proportion polymorphic sites") +
  xlab("Derived allele frequency") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium"))


#Number of sites in p-value 1e-2 SFS
SFSpvalue1e2sum <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/DeNovoStats/SFS/SFSDeNovo1e-2.sfs.em", header = F, sep = " ")
SFSpvalue1e2sum <- SFSpvalue1e2sum[!is.na(SFSpvalue1e2)]
SFSpvalue1e2sum <- SFSpvalue1e2sum[2:99]
sum(SFSpvalue1e2sum)