#Importing packages and Avenir fonts
library(ggplot2)
library(extrafont)
library(RColorBrewer)
library(reshape2)
library(tidyverse)
library(RColorBrewer)
library(viridis)
library(LEA)
loadfonts(loadfonts(device = "win"))

#Avenir fonts:
#Avenir Regular
#Avenir LT Std 65 Medium
#Avenir LT Std 45 Book
#Avenir LT Std 55 Roman

#Reading in the data
SFSpvalue1 <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/SFS/SAFsiteless_98ind_pval1.sfs.em", header = F, sep = " ")
SFSpvalue1 <- SFSpvalue1[!is.na(SFSpvalue1)]
SFSpvalue1 <- SFSpvalue1[2:99]
SFSpvalue1 <- SFSpvalue1/sum(SFSpvalue1)
SFSpvalue5e1 <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/SFS/SAFsiteless_98ind_pval5e-1.sfs.em", header = F, sep = " ")
SFSpvalue5e1 <- SFSpvalue5e1[!is.na(SFSpvalue5e1)]
SFSpvalue5e1 <- SFSpvalue5e1[2:99]
SFSpvalue5e1 <- SFSpvalue5e1/sum(SFSpvalue5e1)
SFSpvalue4e1 <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/SFS/SAFsiteless_98ind_pval4e-1.sfs.em", header = F, sep = " ")
SFSpvalue4e1 <- SFSpvalue4e1[!is.na(SFSpvalue4e1)]
SFSpvalue4e1 <- SFSpvalue4e1[2:99]
SFSpvalue4e1 <- SFSpvalue4e1/sum(SFSpvalue4e1)
SFSpvalue2e1 <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/SFS/SAFsiteless_98ind_pval2e-1.sfs.em", header = F, sep = " ")
SFSpvalue2e1 <- SFSpvalue2e1[!is.na(SFSpvalue2e1)]
SFSpvalue2e1 <- SFSpvalue2e1[2:99]
SFSpvalue2e1 <- SFSpvalue2e1/sum(SFSpvalue2e1)
SFSpvalue1e1 <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/SFS/SAFsiteless_98ind_pval1e-1.sfs.em", header = F, sep = " ")
SFSpvalue1e1 <- SFSpvalue1e1[!is.na(SFSpvalue1e1)]
SFSpvalue1e1 <- SFSpvalue1e1[2:99]
SFSpvalue1e1 <- SFSpvalue1e1/sum(SFSpvalue1e1)
SFSpvalue1e2 <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/SFS/SAFsiteless_98ind_pval1e-2.sfs.em", header = F, sep = " ")
SFSpvalue1e2 <- SFSpvalue1e2[!is.na(SFSpvalue1e2)]
SFSpvalue1e2 <- SFSpvalue1e2[2:99]
SFSpvalue1e2 <- SFSpvalue1e2/sum(SFSpvalue1e2)
SFSpvalue1e3 <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/SFS/SAFsiteless_98ind_pval1e-3.sfs.em", header = F, sep = " ")
SFSpvalue1e3 <- SFSpvalue1e3[!is.na(SFSpvalue1e3)]
SFSpvalue1e3 <- SFSpvalue1e3[2:99]
SFSpvalue1e3 <- SFSpvalue1e3/sum(SFSpvalue1e3)
SFSpvalue1e4 <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/SFS/SAFsiteless_98ind_pval1e-4.sfs.em", header = F, sep = " ")
SFSpvalue1e4 <- SFSpvalue1e4[!is.na(SFSpvalue1e4)]
SFSpvalue1e4 <- SFSpvalue1e4[2:99]
SFSpvalue1e4 <- SFSpvalue1e4/sum(SFSpvalue1e4)
SFSpvalue1e5 <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/SFS/SAFsiteless_98ind_pval1e-5.sfs.em", header = F, sep = " ")
SFSpvalue1e5 <- SFSpvalue1e5[!is.na(SFSpvalue1e5)]
SFSpvalue1e5 <- SFSpvalue1e5[2:99]
SFSpvalue1e5 <- SFSpvalue1e5/sum(SFSpvalue1e5)
SFSpvalue1e6 <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/SFS/SAFsiteless_98ind_pval1e-6.sfs.em", header = F, sep = " ")
SFSpvalue1e6 <- SFSpvalue1e6[!is.na(SFSpvalue1e6)]
SFSpvalue1e6 <- SFSpvalue1e6[2:99]
SFSpvalue1e6 <- SFSpvalue1e6/sum(SFSpvalue1e6)

#Compiled data frame
SFSframe <- data.frame(SFSpvalue1, SFSpvalue5e1, SFSpvalue4e1, SFSpvalue2e1, SFSpvalue1e1, SFSpvalue1e2, SFSpvalue1e3, SFSpvalue1e4, SFSpvalue1e5, SFSpvalue1e6)
TransposedSFSFrame<- t(SFSframe)
MeltedSFSFrame <- melt(TransposedSFSFrame)

###Grouped barplots

#Full spectrum
ggplot(MeltedSFSFrame, aes(x = Var2, y = value)) +
  geom_bar(aes(fill = Var1), position = "dodge", stat = "identity") +
  geom_segment(aes(x = 0.5, xend = 1.5, y = 0.183095812, yend = 0.183095812), linetype = 5) +
  geom_segment(aes(x = 1.5, xend = 2.5, y = 0.112348844, yend = 0.112348844), linetype = 5) +
  geom_segment(aes(x = 2.5, xend = 3.5, y = 0.075651304, yend = 0.075651304), linetype = 5) +
  geom_segment(aes(x = 3.5, xend = 4.5, y = 0.058423634, yend = 0.058423634), linetype = 5) +
  geom_segment(aes(x = 4.5, xend = 5.5, y = 0.043530388, yend = 0.043530388), linetype = 5) +
  scale_fill_viridis(direction = 1, discrete = T, option = "D", name = "p-value", labels = c("1", "5e-1", "4e-1", "2e-1", "1e-1", "1e-2", "1e-3", "1e-4", "1e-5", "1e-6")) +
  ggtitle("SFS of varying p-values") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Proportion polymorphic sites") +
  xlab("Derived allele frequency") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium"))

#Left tail
ggplot(MeltedSFSFrame, aes(x = Var2, y = value)) +
  geom_bar(aes(fill = Var1), position = "dodge", stat = "identity") +
  geom_segment(aes(x = 0.5, xend = 1.5, y = 0.183095812, yend = 0.183095812), linetype = 5) +
  geom_segment(aes(x = 1.5, xend = 2.5, y = 0.112348844, yend = 0.112348844), linetype = 5) +
  geom_segment(aes(x = 2.5, xend = 3.5, y = 0.075651304, yend = 0.075651304), linetype = 5) +
  geom_segment(aes(x = 3.5, xend = 4.5, y = 0.058423634, yend = 0.058423634), linetype = 5) +
  geom_segment(aes(x = 4.5, xend = 5.5, y = 0.043530388, yend = 0.043530388), linetype = 5) +
  scale_x_continuous(expand = c(0, 0), limits = c(0.5, 5.5)) +
  scale_fill_viridis(direction = 1, discrete = T, option = "D", name = "p-value", labels = c("1", "5e-1", "4e-1", "2e-1", "1e-1", "1e-2", "1e-3", "1e-4", "1e-5", "1e-6")) +
  ggtitle("SFS of varying p-values") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Proportion polymorphic sites") +
  xlab("Derived allele frequency") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) 

#Right tail
ggplot(MeltedSFSFrame, aes(x = Var2, y = value)) +
  geom_bar(aes(fill = Var1), position = "dodge", stat = "identity") +
  geom_segment(aes(x = 93.5, xend = 94.5, y = 0.002234050, yend = 0.002234050), linetype = 5) +
  geom_segment(aes(x = 94.5, xend = 95.5, y = 0.002073754, yend = 0.002073754), linetype = 5) +
  geom_segment(aes(x = 95.5, xend = 96.5, y = 0.002023438, yend = 0.002023438), linetype = 5) +
  geom_segment(aes(x = 96.5, xend = 97.5, y = 0.002877023, yend = 0.002877023), linetype = 5) +
  geom_segment(aes(x = 97.5, xend = 98.5, y = 0.004495605, yend = 0.004495605), linetype = 5) +
  scale_x_continuous(expand = c(0, 0), limits = c(93.5, 98.5)) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 0.006)) +
  scale_fill_viridis(direction = 1, discrete = T, option = "D", name = "p-value", labels = c("1", "5e-1", "4e-1", "2e-1", "1e-1", "1e-2", "1e-3", "1e-4", "1e-5", "1e-6")) +
  ggtitle("SFS of varying p-values") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Proportion polymorphic sites") +
  xlab("Derived allele frequency") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium"))

#Number of sites in p-value 1e-2 SFS
SFSpvalue1e2sum <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/SFS/SAFsiteless_98ind_pval1e-2.sfs.em", header = F, sep = " ")
SFSpvalue1e2sum <- SFSpvalue1e2sum[!is.na(SFSpvalue1e2sum)]
SFSpvalue1e2sum <- SFSpvalue1e2sum[2:99]
sum(SFSpvalue1e2sum)