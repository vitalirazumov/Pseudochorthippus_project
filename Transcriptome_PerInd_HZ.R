#############################
# Individual Heterozygosity #
#############################

#Importing packages and Avenir fonts
library(methods)
library(optparse)
library(ggplot2)
library(scales)
library(reshape2)
library(ggpubr)
library(viridis)
library(extrafont)
library(dplyr)
loadfonts(loadfonts(device = "win"))

#Reading in the data
IndHZData <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/ANGSD/Heterozygosity/realSFS/SummarySFSPerInd.csv", header = F, sep = ";", dec = ".")

#Formatting data
IndHZs <- IndHZData[1]
IndHZs[2] <- IndHZData[2]
IndHZs[3] <- IndHZData[4]/sum(IndHZData[3:5])

#Reading in hexadecimal colour vectors
ViridisColours <- c("#18D6CBFF", "#455BCDFF", "#A2FC3CFF", "#F05B12FF", "#30123BFF", "#C42503FF", "#FEA632FF", "#7A0403FF", "#E1DD37FF", "#46F884FF", "#3E9BFEFF")

#Reading in order data
LocalityOrder <- factor(IndHZs$V2 , levels = c("Gabas", "Hermine", "Soques", "Tourmont", "Araille", "Portalet", "Mulas", "Formigal", "Pazino", "Lanuza", "Escarrilla"))
LocalityOrder
LocalityOrder2 <- c("Gabas", "Hermine", "Soques", "Tourmont", "Araille", "Portalet", "Mulas", "Formigal", "Pazino", "Lanuza", "Escarrilla")
LocalityOrder2


###Per Individual Heterozygosity boxplot

ggplot(IndHZs, aes(x = factor(V2, levels=LocalityOrder2), V4)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Individual Heterozygosity Per Population") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Heterozygosity") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular")) +
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_color_viridis() 

###Min, max and avg heterozygosity
min(IndHZs[,3])
max(IndHZs[,3])
mean(IndHZs[,3])