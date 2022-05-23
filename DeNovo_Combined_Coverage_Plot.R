#Importing packages and Avenir fonts
library(ggplot2)
library(ggpubr)
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

#Reading in the data
data <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Sample summary sheet_de novo.csv", header = T, sep = ";", dec = ",")
MeanIndCovData <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/DeNovoCoverages/DeNovoWolbMeanCoveragePlotFile.bed", header = F, sep = "\t", dec = ".", col.names = SampleIDs)
SampleIDs <- c("ARA270",  "ARA271",  "ARA273",  "ARA275",  "ARA276",  "ARA277",  "ARA279",  "ARA280",  "ARA281", "ARA285",
               "ESC011",  "ESC012",  "ESC013",  "ESC015", "ESC344",
               "FOR876",  "FOR877",  "FOR881", "FOR884",  "FOR885",  "FOR887",  "FOR888",  "FOR890",
               "GAB512",  "GAB513",  "GAB514",  "GAB515", "GAB517",
               "HER450",  "HER451",  "HER452",  "HER453",  "HER454",  "HER456",  "HER457",  "HER459",  "HER464",  "HER465",
               "LAN927",  "LAN928",  "LAN929",  "LAN930", "LAN931",  "LAN934",  "LAN935",  "LAN936",  "LAN938",  "LAN940",
               "MUL118",  "MUL119",  "MUL121",  "MUL128",  "MUL129",  "MUL130",  "MUL413",  "MUL414", "MUL416",  "MUL418",
               "PAZ061",  "PAZ062",  "PAZ063",  "PAZ065",  "PAZ068",  "PAZ378",  "PAZ379",  "PAZ380",  "PAZ381",  "PAZ382",
               "POR207",  "POR209", "POR211",  "POR214",  "POR216",  "POR217",  "POR219",  "POR220",  "POR221",  "POR222",
               "SOQ391",  "SOQ395",  "SOQ397",  "SOQ401",  "SOQ402",  "SOQ403", "SOQ404",  "SOQ405",  "SOQ406",  "SOQ408",
               "TOUR331", "TOUR332", "TOUR333", "TOUR336", "TOUR337", "TOUR338", "TOUR340", "TOUR341", "TOUR343", "TOUR345")

#Reading in hexadecimal colour vectors
CustomColours <- c("#30123BFF", "#455BCDFF", "#3E9BFEFF", "#18D6CBFF", "#46F884FF", "#A2FC3CFF", "#E1DD37FF", "#FEA632FF", "#F05B12FF", "#C42503FF", "#7A0403FF")

#Reading in order data
LocalityOrder <- factor(data$Locality, levels = c("Gabas", "Hermine", "Soques", "Tourmont", "Araille", "Portalet", "Mulas", "Formigal", "Pazino", "Lanuza", "Escarrilla"))
LocalityOrder2 <- c("Gabas", "Hermine", "Soques", "Tourmont", "Araille", "Portalet", "Mulas", "Formigal", "Pazino", "Lanuza", "Escarrilla")
LocalityOrder3 <- factor(sort(as.character(LocalityOrder)))

#All genome regions combined coverage

#Mean and median coverage per individual
IndMedian <- function(x) {
  prevector <- vector("numeric", length = ncol(x))
  for (i in c(1:ncol(x)))
    prevector[i] <- median(x[,i])
  print(prevector)
}
MedianCov <- IndMedian(MeanIndCovData)


IndMean <- function(x) {
  prevector <- vector("numeric", length = ncol(x))
  for (i in c(1:ncol(x)))
    prevector[i] <- mean(x[,i])
  print(prevector)
}
MeanCov <- IndMean(MeanIndCovData)

SampleID <- sort(data$Customer.Code)
SampleLocality <- sort(data$Locality)
SampleMedianMean <- data.frame(SampleID, SampleLocality, MedianCov, MeanCov)

#Mean (Included in combined plot)

DNPlot <- ggplot(SampleMedianMean, aes(x = factor(SampleLocality, levels=LocalityOrder2), MeanCov)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Mean general coverage per locality") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Mean Coverage") +
  xlab("Locality") +
  labs(fill = "Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = CustomColours)
DNPlot

#Wolb and mtDNA coverage

WolbachiaCoverage <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/WolbachiaAndMTCoverages/DeNovoMeanCoverageWolbachiaPlotFile.bed", header = F, sep = "\t", dec = ".", col.names = SampleIDs)

Wolb16S <- WolbachiaCoverage[1,]
Wolb16S <- t(Wolb16S)
Wolb16S <- data.frame(Wolb16S, data$Locality)
Wolb16S[,3] <- log10(Wolb16S$X1)

mean(Wolb16S$X1)
sd(Wolb16S$X1)

Wolb23S <- WolbachiaCoverage[2,]
Wolb23S <- t(Wolb23S)
Wolb23S <- data.frame(Wolb23S, data$Locality)
Wolb23S[,3] <- log10(Wolb23S$X2)

mean(Wolb23S$X2)
sd(Wolb23S$X2)

MTCoverage <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/WolbachiaAndMTCoverages/DeNovoMeanCoverageMtPlotFile.bed", header = F, sep = "\t", dec = ".", col.names = SampleIDs)
MTCoverage <- MTCoverage[1,]
MTCoverage <- t(MTCoverage)
MTCoverage <- data.frame(MTCoverage, data$Locality)

mean(MTCoverage$X1)
sd(MTCoverage$X1)

#Log10

#Wolbachia 16S

W16SPlot <- ggplot(Wolb16S, aes(x = factor(data.Locality, levels=LocalityOrder2), V3)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Wolbachia 16S log10(Coverage)") +
  theme(plot.title = element_text(size = 18)) +
  ylab("log10(Coverage)") +
  xlab("Locality") +
  labs(fill = "Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = CustomColours)

#Wolbachia 23S

W23SPlot <- ggplot(Wolb23S, aes(x = factor(data.Locality, levels=LocalityOrder2), V3)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Wolbachia 23S log10(Coverage)") +
  theme(plot.title = element_text(size = 18)) +
  ylab("log10(Coverage)") +
  xlab("Locality") +
  labs(fill = "Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = CustomColours)

#Mitochondrion

MTPlot <- ggplot(MTCoverage, aes(x = factor(data.Locality, levels=LocalityOrder2), X1)) +
  geom_boxplot(aes(fill = LocalityOrder), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Mitochondrial Coverage") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Coverage") +
  xlab("Locality") +
  labs(fill = "Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = CustomColours)


#####################################
### Setting the plots on one page ###
#####################################

DNPlot
MTPlot
W16SPlot
W23SPlot

ggarrange(DNPlot, MTPlot, W16SPlot, W23SPlot,
                             font.label = list(family="Avenir Regular"),
          ncol = 1, nrow = 4)