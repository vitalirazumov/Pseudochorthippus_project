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

#Reading in the data and general factors
SampleIDs <- c("ARA270",  "ARA271",  "ARA273",  "ARA275",  "ARA276",  "ARA277",  "ARA279",  "ARA280",  "ARA281",  "ARA285",  "ESC011",  "ESC012",  "ESC013",  "ESC015", "ESC344",  "FOR876",  "FOR877",  "FOR881",  "FOR884",  "FOR885",  "FOR887",  "FOR888",  "FOR890",  "GAB512",  "GAB513",  "GAB514",  "GAB515",  "GAB517", "HER450",  "HER451",  "HER452",  "HER453",  "HER454",  "HER456",  "HER457",  "HER459",  "HER464",  "HER465",  "LAN927",  "LAN928",  "LAN929",  "LAN930", "LAN931",  "LAN934",  "LAN935",  "LAN936",  "LAN938",  "LAN940",  "MUL118",  "MUL119",  "MUL121",  "MUL128",  "MUL129",  "MUL130",  "MUL413",  "MUL414", "MUL416",  "MUL418",  "PAZ061",  "PAZ062",  "PAZ063",  "PAZ065",  "PAZ068",  "PAZ378",  "PAZ379",  "PAZ380",  "PAZ381",  "PAZ382",  "POR207",  "POR209", "POR211",  "POR214",  "POR216",  "POR217",  "POR219",  "POR220",  "POR221",  "POR222",  "SOQ391",  "SOQ395",  "SOQ397",  "SOQ401",  "SOQ402",  "SOQ403", "SOQ404",  "SOQ405",  "SOQ406",  "SOQ408",  "TOUR331", "TOUR332", "TOUR333", "TOUR336", "TOUR337", "TOUR338", "TOUR340", "TOUR341", "TOUR343", "TOUR345")
data <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Sample summary sheet_de novo.csv", header = T, sep = ";", dec = ",")
CovData <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/AvgCovPerInd.bed", header = F, sep = "\t", dec = ".", col.names = c("Chromosome","Start coordinate", "End coordinate", "Mean coverage", "Z-score"))
IndCovData <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/IndividualCoveragesCompiled.bed", header = F, sep = "\t", dec = ".", col.names = SampleIDs)
CovDataPerBP <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/TestCovPerBP.bed", header = F, sep = "\t", dec = ".", col.names = c("Chromosome","Start coordinate", "End coordinate", "BP number", "Coverage", "Z-score"))
IndCovDataPerBP <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/IndividualCoveragesCompiledPerBP.bed", header = F, sep = "\t", dec = ".")

#Reading in hexadecimal colour vectors
colourscale <- c("#FFCC00", "#99CC00", "#336600", "#CCFFCC", "#669966", "#FF6600", "#FFCCCC", "#9999CC", "#6666CC", "#66CCCC", "#FF3333")
colourscale2 <- c("#FFCC00", "#CCFF66", "#CCFFCC", "#66FF99", "#99FFFF", "#6699FF", "#99CCFF", "#FFCCFF", "#FF99FF", "#FF3399", "#FF3333")

#Reading in order data
LocalityOrder <- factor(data$Locality, levels = c("Gabas", "Hermine", "Soques", "Tourmont", "Araille", "Portalet", "Mulas", "Formigal", "Pazino", "Lanuza", "Escarrilla"))
LocalityOrder
LocalityOrder2 <- c("Gabas", "Hermine", "Soques", "Tourmont", "Araille", "Portalet", "Mulas", "Formigal", "Pazino", "Lanuza", "Escarrilla")
LocalityOrder2
LocalityOrder3 <- factor(sort(as.character(LocalityOrder)))
LocalityOrder3

###################
### Basic stats ###
###################

#Read pairs sequenced
sum(as.numeric(as.character(data$Read.pairs)))
mean(as.numeric(as.character(data$Read.pairs)))
sd(as.numeric(as.character(data$Read.pairs)))

#Min and max read pairs sequenced
min(as.numeric(as.character(data$Read.pairs)))
max(as.numeric(as.character(data$Read.pairs)))
mean(as.numeric(as.character(data$Average.number.of.NTs.in.retained.reads)))

#Total numberof pairs inputed
mean(as.numeric(as.character(data$Total.number.of.pairs..into.Paleomix.)))
sd(as.numeric(as.character(data$Total.number.of.pairs..into.Paleomix.)))

#Total number of reads retained
mean(as.numeric(as.character(data$Total.number.of.read.pairs.retained/2)))
sd(as.numeric(as.character(data$Total.number.of.read.pairs.retained/2)))

#Total number of pairs collapsed into one read
mean(as.numeric(as.character(data$Fraction.of.PE.pairs.collapsed.into.one.read)))
sd(as.numeric(as.character(data$Fraction.of.PE.pairs.collapsed.into.one.read)))

#Total number of NTs
mean(as.numeric(as.character(data$Total.number.of.NTs.in.retained.reads)))
sd(as.numeric(as.character(data$Total.number.of.NTs.in.retained.reads)))

#Average n of NTs in retained reads
mean(as.numeric(as.character(data$Average.number.of.NTs.in.retained.reads)))
sd(as.numeric(as.character(data$Average.number.of.NTs.in.retained.reads)))

#Total number of hits prior to PCR filtering
mean(as.numeric(as.character(data$Total.number.of.hits..prior.to.PCR.duplicate.filtering.)))
sd(as.numeric(as.character(data$Total.number.of.hits..prior.to.PCR.duplicate.filtering.)))

#Fraction of PCR duplicates
mean(as.numeric(as.character(data$Fraction.of.hits.that.were.PCR.duplicates)))
sd(as.numeric(as.character(data$Fraction.of.hits.that.were.PCR.duplicates)))

#Fraction of unique hits
mean(as.numeric(as.character(data$Total.number.of.unique.hits.vs..total.number.of.reads.retained)))
sd(as.numeric(as.character(data$Total.number.of.unique.hits.vs..total.number.of.reads.retained)))

#Average unique read length
mean(as.numeric(as.character(data$Average.number.of.aligned.bases.per.unique.hit)))
sd(as.numeric(as.character(data$Average.number.of.aligned.bases.per.unique.hit)))

#Estimated unique hit coverage
mean(as.numeric(as.character(data$Estimated.coverage.from.unique.hits)))
sd(as.numeric(as.character(data$Estimated.coverage.from.unique.hits)))

###Basic stats plots

#Number of reads per individual -plot
ggplot(data, aes(x = factor(Customer.Code, level = Customer.Code), Read.pairs)) +
  geom_point(aes(colour = LocalityOrder)) +
  geom_segment(aes(xend = Customer.Code, colour = LocalityOrder), yend=0) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, max(data$Read.pairs+500000))) +
  ggtitle("Number of Read Pairs per Sample") +
  theme(plot.title = element_text(size = 24))+
  ylab("Number of Read Pairs") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_colour_manual(values = colourscale)

#Number of raw reads per population -box plot
ggplot(data, aes(x = factor(Locality, levels=LocalityOrder2), Base.pairs.sequenced)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Number of Sequenced Base Pairs per Locality") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Number of Sequenced Base Pairs") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2)

#Number of reads per individual after PALEOMIX -plot
ggplot(data, aes(x = factor(Customer.Code, level = Customer.Code), Total.number.of.read.pairs.retained)) +
  geom_point(aes(colour = LocalityOrder)) +
  geom_segment(aes(xend = Customer.Code, colour = LocalityOrder), yend=0) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, max(data$Read.pairs+500000))) +
  ggtitle("Number of Read Pairs per Sample After Filtering") +
  theme(plot.title = element_text(size = 24))+
  ylab("Number of Read Pairs") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_colour_manual(values = colourscale)

#Number of reads retained per population after PALEOMIX -plot
ggplot(data, aes(x = factor(Locality, levels=LocalityOrder2), Total.number.of.NTs.in.retained.reads)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Number of Retained Base Pairs per Locality") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Number of Retained Base Pairs") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2)

#Fraction of pair ended pairs collapsed into one read
data$Fraction.of.PE.pairs.collapsed.into.one.read <- as.numeric(levels(data$Fraction.of.PE.pairs.collapsed.into.one.read))[data$Fraction.of.PE.pairs.collapsed.into.one.read]

ggplot(data, aes(x = factor(Locality, levels=LocalityOrder2), Fraction.of.PE.pairs.collapsed.into.one.read)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Fraction of collapsed pairs") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Fraction") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2) +
  scale_y_continuous(breaks = seq(0.20, 0.60 ,0.05))

#Average number of NTs in retained reads
data$Average.number.of.NTs.in.retained.reads <- as.numeric(levels(data$Average.number.of.NTs.in.retained.reads))[data$Average.number.of.NTs.in.retained.reads]

ggplot(data, aes(x = factor(Locality, levels=LocalityOrder2), Average.number.of.NTs.in.retained.reads)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Average number of NTs in retained reads") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Average number of NTs") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2) +
  scale_y_continuous(breaks = seq(160, 180, 2.5), limits = c(160, 180), expand = c(0.025, 0.025))

#Fraction of hits that were PCR duplicates
data$Fraction.of.hits.that.were.PCR.duplicates <- as.numeric(levels(data$Fraction.of.hits.that.were.PCR.duplicates))[data$Fraction.of.hits.that.were.PCR.duplicates]

ggplot(data, aes(x = factor(Locality, levels=LocalityOrder2), Fraction.of.hits.that.were.PCR.duplicates)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Fraction of hits that were PCR duplicates") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Fraction") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2) +
  scale_y_continuous(breaks = seq(0.20, 0.70, 0.05), limits = c(0.20, 0.70), expand = c(0, 0))

#Total number of unique hits vs. total number of reads retained
data$Total.number.of.unique.hits.vs..total.number.of.reads.retained <- as.numeric(levels(data$Total.number.of.unique.hits.vs..total.number.of.reads.retained))[data$Total.number.of.unique.hits.vs..total.number.of.reads.retained]

ggplot(data, aes(x = factor(Locality, levels=LocalityOrder2), Total.number.of.unique.hits.vs..total.number.of.reads.retained)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Total number of unique hits vs. total number of reads retained") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Fraction") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2) +
  scale_y_continuous(breaks = seq(0.15, 0.50, 0.05), limits = c(0.15, 0.475), expand = c(0, 0))

#Estimated coverage from unique hits
data$Estimated.coverage.from.unique.hits <- as.numeric(levels(data$Estimated.coverage.from.unique.hits))[data$Estimated.coverage.from.unique.hits]

ggplot(data, aes(x = factor(Locality, levels=LocalityOrder2), Estimated.coverage.from.unique.hits)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Estimated coverage from unique hits") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Coverage") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2) +
  scale_y_continuous(breaks = c(1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5))