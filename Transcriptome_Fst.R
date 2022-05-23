#Importing packages and Avenir fonts
library(ade4)
library(ggplot2)
library(extrafont)
library(RColorBrewer)
library(reshape2)
library(tidyverse)
library(RColorBrewer)
library(viridis)
loadfonts(loadfonts(device = "win"))

#Reading in data and creating matrices
IndCovDataPerBP <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/IndividualCoveragesCompiledPerBP.bed", header = F, sep = "\t", dec = ".")

PopwiseFst <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/Fst/PopulationwiseFst.csv", header = T, row.names = 1, sep = ";", dec = ".")
PopwiseDist <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/Fst/PopulationwiseDistance.csv", header = T, row.names = 1, sep = ";", dec = ",")

PopFstMatrix <- dist(PopwiseFst)
as.matrix(PopFstMatrix)
PopDistMatrix <- dist(PopwiseDist)
as.matrix(PopDistMatrix)

#####################################
### Max depth for Fst calculation ###
#####################################

#Mean pop size

MeanPopSize <- 98/11
MeanPopSize

#Mean and SD per individual

PerPopMeanDepth <- sapply(IndCovDataPerBP[,1:98], mean)
PerPopMeanDepth

PerPopSDDepth <- sapply(IndCovDataPerBP[,1:98], sd)
PerPopSDDepth

#Average of mean and SD

AvgMean <- mean(PerPopMeanDepth)
AvgMean

AvgSD <- mean(PerPopSDDepth)
AvgSD

#Max Depth

AvgMeanXPop <- AvgMean * 9
AvgMeanXPop

AvgSDXPop <- AvgSD * 9
AvgSDXPop

AvgMeanXPop + AvgSDXPop

AvgMean + AvgSD

#############################
### Mantel's test & plots ###
#############################

###Whole transect

#Performing Mantel's test

mantel.rtest(PopFstMatrix, PopDistMatrix, nrepet = 1000)

#Scatterplot

PopFstXDistDF <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/Fst/PopFstXDistDF.csv", header = T, row.names = 1, sep = ";", dec = ",")

ggplot(data = PopFstXDistDF, aes(x = Distance.km, y = Fst)) +
  geom_point() +
  geom_smooth(method='lm') +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0.01, 0.01), limits = c(0, 0.54)) +
  scale_x_continuous(expand = c(0.01, 0.01), limits = c(0.0, 21.1)) +
  ggtitle("Isolation by distance") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Fst") +
  xlab("Distance") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) 

#Gray area is the 0.95 confidence interval

###North side, excluding Mulas

FranceFst <- PopwiseFst[1:6,1:6]
FranceDist <- PopwiseDist[1:6,1:6]

FranceFstMatrix <- dist(FranceFst)
FranceDistMatrix <- dist(FranceDist)

as.matrix(FranceFstMatrix)
as.matrix(FranceDistMatrix)

#Performing Mantel's test
mantel.rtest(FranceFstMatrix, FranceDistMatrix, nrepet = 1000)

#Scatterplot
FranceFstXDistDF <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/Fst/FranceFstXDistDF.csv", header = T, row.names = 1, sep = ";", dec = ",")

ggplot(data = FranceFstXDistDF, aes(x = Distance.km, y = Fst)) +
  geom_point() +
  geom_smooth(method='lm') +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0.01, 0.01), limits = c(-0.006, 0.325)) +
  scale_x_continuous(expand = c(0.01, 0.01), limits = c(0.0, 10.6)) +
  ggtitle("Isolation by distance north of hybridzone") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Fst") +
  xlab("Distance") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) 

###South side, excluding Mulas

SpainFst <- PopwiseFst[8:11,8:11]
SpainDist <- PopwiseDist[8:11,8:11]

SpainFstMatrix <- dist(SpainFst)
SpainDistMatrix <- dist(SpainDist)

as.matrix(SpainFstMatrix)
as.matrix(SpainDistMatrix)

#Performing Mantel's test
mantel.rtest(SpainFstMatrix, SpainDistMatrix, nrepet = 1000)

#Scatterplot
SpainFstXDistDF <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Paleomix/Baits/TheOne/Fst/SpainFstXDistDF.csv", header = T, row.names = 1, sep = ";", dec = ",")

ggplot(data = SpainFstXDistDF, aes(x = Distance.km, y = Fst)) +
  geom_point() +
  geom_smooth(method='lm') +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0.01, 0.01), limits = c(-0.008, 0.125)) +
  scale_x_continuous(expand = c(0.01, 0.01), limits = c(0.0, 3.4)) +
  ggtitle("Isolation by distance south of hybridzone") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Fst") +
  xlab("Distance") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) 