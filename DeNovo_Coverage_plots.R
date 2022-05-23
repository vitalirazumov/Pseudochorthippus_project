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

#Reading in the data
data <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Sample summary sheet_de novo.csv", header = T, sep = ";", dec = ",")
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
MeanMergedCovData <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/DeNovoCoverages/MergedWolbBamsCoverageMean.bed", header = F, sep = "\t", dec = ".", col.names = c("Cluster","Start coordinate", "End coordinate", "Mean coverage"))
MeanIndCovData <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/DeNovoCoverages/DeNovoWolbMeanCoveragePlotFile.bed", header = F, sep = "\t", dec = ".", col.names = SampleIDs)
PerBPMergedCovData <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/DeNovoCoverages/MergedBamsCoveragePerBP.bed", header = F, sep = "\t", dec = ".", col.names = c("Cluster","Start coordinate", "End coordinate", "BP number", "Coverage"))
PerBPIndCovData <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/DeNovoCoverages/DeNovoPerBPCoveragePlotFile.bed", header = F, sep = "\t", dec = ".")
ExtraRegionCoverage <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/DeNovoCoverages/DeNovoMeanCoverageExtraPlotFile.bed", header = F, sep = "\t", dec = ".", col.names = SampleIDs)

#Reading in hexadecimal colour vectors
colourscale <- c("#FFCC00", "#99CC00", "#336600", "#CCFFCC", "#669966", "#FF6600", "#FFCCCC", "#9999CC", "#6666CC", "#66CCCC", "#FF3333")
colourscale2 <- c("#FFCC00", "#CCFF66", "#CCFFCC", "#66FF99", "#99FFFF", "#6699FF", "#99CCFF", "#FFCCFF", "#FF99FF", "#FF3399", "#FF3333")

#Reading in order data
LocalityOrder <- factor(data$Locality, levels = c("Gabas", "Hermine", "Soques", "Tourmont", "Araille", "Portalet", "Mulas", "Formigal", "Pazino", "Lanuza", "Escarrilla"))
LocalityOrder2 <- c("Gabas", "Hermine", "Soques", "Tourmont", "Araille", "Portalet", "Mulas", "Formigal", "Pazino", "Lanuza", "Escarrilla")
LocalityOrder3 <- factor(sort(as.character(LocalityOrder)))

###Target region scale
######################

#Average coverage in baited regions, individuals compiled

mean(MeanMergedCovData$Mean.coverage)
median(MeanMergedCovData$Mean.coverage)
sd(MeanMergedCovData$Mean.coverage)


ggplot(MeanMergedCovData, aes(x = Mean.coverage)) +
  geom_density(aes(x = Mean.coverage)) +
  scale_x_continuous(expand = c(0, 0), limits = c(0, 10000)) +
  ggtitle("Merged Per Locus Coverage Density") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Density") +
  xlab("Mean Coverage") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  geom_vline(xintercept = median(MeanMergedCovData$Mean.coverage), size = 0.5, color = "red", linetype = 1) +
  geom_vline(xintercept = mean(MeanMergedCovData$Mean.coverage), size = 0.5, color = "red", linetype = 6)




#Average coverage in baited regions per individual

LongICD <- melt(MeanIndCovData)
median(LongICD$value)
mean(LongICD$value)
sd(LongICD$value)

#Individuals of interest
CovFOR881 <- LongICD[LongICD$variable == "FOR881",]
CovMUL128 <- LongICD[LongICD$variable == "MUL128",]
CovFOR888 <- LongICD[LongICD$variable == "FOR888",]

mean(MeanIndCovData$FOR881)
median(MeanIndCovData$FOR881)

mean(MeanIndCovData$MUL128)
median(MeanIndCovData$MUL128)

mean(MeanIndCovData$FOR888)
median(MeanIndCovData$FOR888)

#Coverage density plot
ggplot(LongICD, aes(x = value, color = variable)) +
  geom_density() +
  scale_x_continuous(expand = c(0, 0), limits = c(0, 50)) + # Add # to see the whole X-axis. Change limits = c(0, XXX) to change width
  ggtitle("Per Individual Coverage Density") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Density") +
  xlab("Mean Coverage") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "None") +
  geom_vline(xintercept = median(LongICD$value), size = 0.5, color = "red", linetype = 1) +
  geom_vline(xintercept = mean(LongICD$value), size = 0.5, color = "red", linetype = 6)


#Average coverage in baited regions FOR881
ggplot(CovFOR881, aes(x = value, color = "yellow" )) +
  geom_density() +
  scale_x_continuous(expand = c(0, 0), limits = c(0, 50)) + # Add # to see the whole X-axis. Change limits = c(0, XXX) to change width
  ggtitle("FOR881 Coverage Density") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Density") +
  xlab("Mean Coverage") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "None") +
  geom_vline(xintercept = median(CovFOR881$value), size = 0.5, color = "red", linetype = 1) +
  geom_vline(xintercept = mean(CovFOR881$value), size = 0.5, color = "red", linetype = 6)

#Average coverage in baited regions MUL128
ggplot(CovMUL128, aes(x = value, color = "yellow" )) +
  geom_density() +
  scale_x_continuous(expand = c(0, 0), limits = c(0, 50)) + # Add # to see the whole X-axis. Change limits = c(0, XXX) to change width
  ggtitle("MUL128 Coverage Density") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Density") +
  xlab("Mean Coverage") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "None") +
  geom_vline(xintercept = median(CovMUL128$value), size = 0.5, color = "red", linetype = 1) +
  geom_vline(xintercept = mean(CovMUL128$value), size = 0.5, color = "red", linetype = 6)

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


#Median
ggplot(SampleMedianMean, aes(x = factor(SampleLocality, levels=LocalityOrder2), MedianCov)) +
  geom_boxplot(aes(fill = LocalityOrder3), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Sample median per locality") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Median") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2)

#Mean
ggplot(SampleMedianMean, aes(x = factor(SampleLocality, levels=LocalityOrder2), MeanCov)) +
  geom_boxplot(aes(fill = LocalityOrder3), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Sample mean per locality") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Mean") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2)

#Calculating coverage cut off point for filtering in downstream analyses

#Coverage for mean + 1SD
mean(MeanMergedCovData$Mean.coverage)+sd(MeanMergedCovData$Mean.coverage)

#Sites excluded if cut off at mean + 1SD
nrow(MeanMergedCovData[MeanMergedCovData$Mean.coverage > mean(MeanMergedCovData$Mean.coverage)+sd(MeanMergedCovData$Mean.coverage),])

###Per Base Pair scale
######################

#Average Per BP coverage in baited regions, individuals compiled
median(PerBPMergedCovData$Coverage)
mean(PerBPMergedCovData$Coverage)
sd(PerBPMergedCovData$Coverage)

#Coverage density plot
ggplot(PerBPMergedCovData, aes(x = Coverage)) +
  geom_density(aes(x = Coverage)) +
  scale_x_continuous(expand = c(0, 0), limits = c(0, 10000)) +
  ggtitle("Merged Per Base Pair Coverage Density") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Density") +
  xlab("Coverage") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  geom_vline(xintercept = median(PerBPMergedCovData$Coverage), size = 0.5, color = "red", linetype = 1) +
  geom_vline(xintercept = mean(PerBPMergedCovData$Coverage), size = 0.5, color = "red", linetype = 6)


#Average coverage in baited regions per individual
LongICDPerBP <- melt(PerBPIndCovData)
median(LongICDPerBP$value)
mean(LongICDPerBP$value)

#Coverage density plot
ggplot(LongICDPerBP, aes(x = value, color = variable)) +
  geom_density() +
  scale_x_continuous(expand = c(0, 0), limits = c(0, 50)) + # Add # to see the whole X-axis. Change limits = c(0, XXX) to change width
  ggtitle("Per Individual Per Base Pair Coverage Density") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Density") +
  xlab("Mean Coverage") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "None") +
  geom_vline(xintercept = median(LongICDPerBP$value), size = 0.5, color = "red", linetype = 1) +
  geom_vline(xintercept = mean(LongICDPerBP$value), size = 0.5, color = "red", linetype = 6)

#Mean and median coverage per individual

MedianCov <- IndMedian(PerBPIndCovData)
MeanCov <- IndMean(PerBPIndCovData)

SampleID <- sort(data$Customer.Code)
SampleLocality <- sort(data$Locality)
SampleMedianMean <- data.frame(SampleID, SampleLocality, MedianCov, MeanCov)


#Median
ggplot(SampleMedianMean, aes(x = factor(SampleLocality, levels=LocalityOrder2), MedianCov)) +
  geom_boxplot(aes(fill = LocalityOrder3), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Sample median per locality") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Median") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2)

#Mean
ggplot(SampleMedianMean, aes(x = factor(SampleLocality, levels=LocalityOrder2), MeanCov)) +
  geom_boxplot(aes(fill = LocalityOrder3), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Sample mean per locality") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Mean") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2)

#Calculating coverage cut off point for filtering in downstream analyses

#Coverage for mean + 1SD
mean(PerBPMergedCovData$Coverage)+sd(PerBPMergedCovData$Coverage)

#Sites excluded if cut off at mean + 1SD
nrow(PerBPMergedCovData[PerBPMergedCovData$Coverage > mean(PerBPMergedCovData$Coverage)+sd(PerBPMergedCovData$Coverage),])

###Extra region coverage
########################

LongICDExtra <- melt(ExtraRegionCoverage)
median(LongICDExtra$value)
mean(LongICDExtra$value)
sd(LongICDExtra$value)
CovExtraFOR881 <- LongICDExtra[LongICDExtra$variable == "FOR881",]
CovExtraMUL128 <- LongICDExtra[LongICDExtra$variable == "MUL128",]
CovExtraFOR888 <- LongICDExtra[LongICDExtra$variable == "FOR888",]

mean(ExtraRegionCoverage$FOR881)
median(ExtraRegionCoverage$FOR881)

mean(ExtraRegionCoverage$MUL128)
median(ExtraRegionCoverage$MUL128)

mean(ExtraRegionCoverage$FOR888)
median(ExtraRegionCoverage$FOR888)


ggplot(LongICDExtra, aes(x = value, color = variable)) +
  geom_density() +
  scale_x_continuous(expand = c(0, 0), limits = c(0, 50)) + # Add # to see the whole X-axis. Change limits = c(0, XXX) to change width
  ggtitle("Per Individual Coverage Density in Extra Regions") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Density") +
  xlab("Mean Coverage") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "None") +
  geom_vline(xintercept = median(LongICDExtra$value), size = 0.5, color = "red", linetype = 1) +
  geom_vline(xintercept = mean(LongICDExtra$value), size = 0.5, color = "red", linetype = 6)

MedianCovExtra <- IndMedian(ExtraRegionCoverage)
MeanCovExtra <- IndMean(ExtraRegionCoverage)

SampleID <- sort(data$Customer.Code)
SampleLocality <- sort(data$Locality)
SampleMedianMeanExtra <- data.frame(SampleID, SampleLocality, MedianCovExtra, MeanCovExtra)

#Median
ggplot(SampleMedianMeanExtra, aes(x = factor(SampleLocality, levels=LocalityOrder2), MedianCovExtra)) +
  geom_boxplot(aes(fill = LocalityOrder3), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Sample Median Per Locality in Extra Regions") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Median") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2)

#Mean
ggplot(SampleMedianMeanExtra, aes(x = factor(SampleLocality, levels=LocalityOrder2), MeanCovExtra)) +
  geom_boxplot(aes(fill = LocalityOrder3), outlier.shape = NA) +
  geom_jitter(width = 0.075, height = 0, size = 1.96) +
  ggtitle("Sample Mean Per Locality in Extra Regions") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Mean") +
  xlab("Locality") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = colourscale2)