
#############################################
# Heterozygosity and Inbreeding coefficient #
#############################################

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
HWEdataARA <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/Heterozygosity and F plots/new.hweFiles/Pop1_HWE_newANC.hwe", header = T, sep = "\t", dec = ",")
HWEdataESC <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/Heterozygosity and F plots/new.hweFiles/Pop2_HWE_newANC.hwe", header = T, sep = "\t", dec = ",")
HWEdataFOR <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/Heterozygosity and F plots/new.hweFiles/Pop3_HWE_newANC.hwe", header = T, sep = "\t", dec = ",")
HWEdataGAB <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/Heterozygosity and F plots/new.hweFiles/Pop4_HWE_newANC.hwe", header = T, sep = "\t", dec = ",")
HWEdataHER <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/Heterozygosity and F plots/new.hweFiles/Pop5_HWE_newANC.hwe", header = T, sep = "\t", dec = ",")
HWEdataLAN <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/Heterozygosity and F plots/new.hweFiles/Pop6_HWE_newANC.hwe", header = T, sep = "\t", dec = ",")
HWEdataMUL <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/Heterozygosity and F plots/new.hweFiles/Pop7_HWE_newANC.hwe", header = T, sep = "\t", dec = ",")
HWEdataPAZ <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/Heterozygosity and F plots/new.hweFiles/Pop8_HWE_newANC.hwe", header = T, sep = "\t", dec = ",")
HWEdataPOR <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/Heterozygosity and F plots/new.hweFiles/Pop9_HWE_newANC.hwe", header = T, sep = "\t", dec = ",")
HWEdataSOQ <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/Heterozygosity and F plots/new.hweFiles/Pop10_HWE_newANC.hwe", header = T, sep = "\t", dec = ",")
HWEdataTOUR <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/Heterozygosity and F plots/new.hweFiles/Pop11_HWE_newANC.hwe", header = T, sep = "\t", dec = ",")


###Calculating expected heterozygosity per site

#hweFreq from factor to numeric

HWEdataARA$hweFreq <- as.numeric(as.character(HWEdataARA$hweFreq))
HWEdataESC$hweFreq <- as.numeric(as.character(HWEdataESC$hweFreq))
HWEdataFOR$hweFreq <- as.numeric(as.character(HWEdataFOR$hweFreq))
HWEdataGAB$hweFreq <- as.numeric(as.character(HWEdataGAB$hweFreq))
HWEdataHER$hweFreq <- as.numeric(as.character(HWEdataHER$hweFreq))
HWEdataLAN$hweFreq <- as.numeric(as.character(HWEdataLAN$hweFreq))
HWEdataMUL$hweFreq <- as.numeric(as.character(HWEdataMUL$hweFreq))
HWEdataPAZ$hweFreq <- as.numeric(as.character(HWEdataPAZ$hweFreq))
HWEdataPOR$hweFreq <- as.numeric(as.character(HWEdataPOR$hweFreq))
HWEdataSOQ$hweFreq <- as.numeric(as.character(HWEdataSOQ$hweFreq))
HWEdataTOUR$hweFreq <- as.numeric(as.character(HWEdataTOUR$hweFreq))

#the expected proportion of heterozygotes can be derived from the allelic frequency under HW (hweFreq), (Hexp=2pq)
#Hexp = 2*(hweFreq)(1-hweFreq)

HWEdataARA$Hexp <- 2*(HWEdataARA$hweFreq)*(1-HWEdataARA$hweFreq)
HWEdataESC$Hexp <- 2*(HWEdataESC$hweFreq)*(1-HWEdataESC$hweFreq)
HWEdataFOR$Hexp <- 2*(HWEdataFOR$hweFreq)*(1-HWEdataFOR$hweFreq)
HWEdataGAB$Hexp <- 2*(HWEdataGAB$hweFreq)*(1-HWEdataGAB$hweFreq)
HWEdataHER$Hexp <- 2*(HWEdataHER$hweFreq)*(1-HWEdataHER$hweFreq)
HWEdataLAN$Hexp <- 2*(HWEdataLAN$hweFreq)*(1-HWEdataLAN$hweFreq)
HWEdataMUL$Hexp <- 2*(HWEdataMUL$hweFreq)*(1-HWEdataMUL$hweFreq)
HWEdataPAZ$Hexp <- 2*(HWEdataPAZ$hweFreq)*(1-HWEdataPAZ$hweFreq)
HWEdataPOR$Hexp <- 2*(HWEdataPOR$hweFreq)*(1-HWEdataPOR$hweFreq)
HWEdataSOQ$Hexp <- 2*(HWEdataSOQ$hweFreq)*(1-HWEdataSOQ$hweFreq)
HWEdataTOUR$Hexp <- 2*(HWEdataTOUR$hweFreq)*(1-HWEdataTOUR$hweFreq)

#F from factor to numeric

HWEdataARA$F <- as.numeric(as.character(HWEdataARA$F))
HWEdataESC$F <- as.numeric(as.character(HWEdataESC$F))
HWEdataFOR$F <- as.numeric(as.character(HWEdataFOR$F))
HWEdataGAB$F <- as.numeric(as.character(HWEdataGAB$F))
HWEdataHER$F <- as.numeric(as.character(HWEdataHER$F))
HWEdataLAN$F <- as.numeric(as.character(HWEdataLAN$F))
HWEdataMUL$F <- as.numeric(as.character(HWEdataMUL$F))
HWEdataPAZ$F <- as.numeric(as.character(HWEdataPAZ$F))
HWEdataPOR$F <- as.numeric(as.character(HWEdataPOR$F))
HWEdataSOQ$F <- as.numeric(as.character(HWEdataSOQ$F))
HWEdataTOUR$F <- as.numeric(as.character(HWEdataTOUR$F))

FDataFrame <- data.frame(HWEdataGAB$F,
                         HWEdataHER$F,
                         HWEdataSOQ$F,
                         HWEdataTOUR$F,
                         HWEdataARA$F,
                         HWEdataPOR$F,
                         HWEdataMUL$F,
                         HWEdataFOR$F,
                         HWEdataPAZ$F,
                         HWEdataLAN$F,
                         HWEdataESC$F)


#the observed proportion of heterozygotes can now be calculated using F, the departure from HW or inbreeding coefficient (F=1-Hobs/Hexp)
#Hobs= Hexp - F* Hexp

HWEdataARA$Hobs <- HWEdataARA$Hexp-(HWEdataARA$F*HWEdataARA$Hexp)
HWEdataESC$Hobs <- HWEdataESC$Hexp-(HWEdataESC$F*HWEdataESC$Hexp)
HWEdataFOR$Hobs <- HWEdataFOR$Hexp-(HWEdataFOR$F*HWEdataFOR$Hexp)
HWEdataGAB$Hobs <- HWEdataGAB$Hexp-(HWEdataGAB$F*HWEdataGAB$Hexp)
HWEdataHER$Hobs <- HWEdataHER$Hexp-(HWEdataHER$F*HWEdataHER$Hexp)
HWEdataLAN$Hobs <- HWEdataLAN$Hexp-(HWEdataLAN$F*HWEdataLAN$Hexp)
HWEdataMUL$Hobs <- HWEdataMUL$Hexp-(HWEdataMUL$F*HWEdataMUL$Hexp)
HWEdataPAZ$Hobs <- HWEdataPAZ$Hexp-(HWEdataPAZ$F*HWEdataPAZ$Hexp)
HWEdataPOR$Hobs <- HWEdataPOR$Hexp-(HWEdataPOR$F*HWEdataPOR$Hexp)
HWEdataSOQ$Hobs <- HWEdataSOQ$Hexp-(HWEdataSOQ$F*HWEdataSOQ$Hexp)
HWEdataTOUR$Hobs <- HWEdataTOUR$Hexp-(HWEdataTOUR$F*HWEdataTOUR$Hexp)

#p.value from factor to numeric

HWEdataARA$p.value <- as.numeric(as.character(HWEdataARA$p.value))
HWEdataESC$p.value <- as.numeric(as.character(HWEdataESC$p.value))
HWEdataFOR$p.value <- as.numeric(as.character(HWEdataFOR$p.value))
HWEdataGAB$p.value <- as.numeric(as.character(HWEdataGAB$p.value))
HWEdataHER$p.value <- as.numeric(as.character(HWEdataHER$p.value))
HWEdataLAN$p.value <- as.numeric(as.character(HWEdataLAN$p.value))
HWEdataMUL$p.value <- as.numeric(as.character(HWEdataMUL$p.value))
HWEdataPAZ$p.value <- as.numeric(as.character(HWEdataPAZ$p.value))
HWEdataPOR$p.value <- as.numeric(as.character(HWEdataPOR$p.value))
HWEdataSOQ$p.value <- as.numeric(as.character(HWEdataSOQ$p.value))
HWEdataTOUR$p.value <- as.numeric(as.character(HWEdataTOUR$p.value))

###Identifying positions with HWE p-value <= 0.05

HWEdataARA$p.value.below.05 <- ifelse(HWEdataARA$p.value <= 0.05, "Below", "Above")
HWEdataESC$p.value.below.05 <- ifelse(HWEdataESC$p.value <= 0.05, "Below", "Above")
HWEdataFOR$p.value.below.05 <- ifelse(HWEdataFOR$p.value <= 0.05, "Below", "Above")
HWEdataGAB$p.value.below.05 <- ifelse(HWEdataGAB$p.value <= 0.05, "Below", "Above")
HWEdataHER$p.value.below.05 <- ifelse(HWEdataHER$p.value <= 0.05, "Below", "Above")
HWEdataLAN$p.value.below.05 <- ifelse(HWEdataLAN$p.value <= 0.05, "Below", "Above")
HWEdataMUL$p.value.below.05 <- ifelse(HWEdataMUL$p.value <= 0.05, "Below", "Above")
HWEdataPAZ$p.value.below.05 <- ifelse(HWEdataPAZ$p.value <= 0.05, "Below", "Above")
HWEdataPOR$p.value.below.05 <- ifelse(HWEdataPOR$p.value <= 0.05, "Below", "Above")
HWEdataSOQ$p.value.below.05 <- ifelse(HWEdataSOQ$p.value <= 0.05, "Below", "Above")
HWEdataTOUR$p.value.below.05 <- ifelse(HWEdataTOUR$p.value <= 0.05, "Below", "Above")



###Plotting inbreeding coefficient, F, histogram

ARAFhist <- ggplot(HWEdataARA, aes(x = F, fill = p.value.below.05)) + 
  geom_histogram(binwidth = 0.02, position="stack", color="black") +
  geom_text(x = 0.32, y = 25700, label = paste0("Number of sites = ", nrow(HWEdataARA)), aes(family = "Avenir Regular")) +
  expand_limits(y=40000) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(plot.title = element_text(size = 24))

#ARAFhist

ESCFhist <- ggplot(HWEdataESC, aes(x = F, fill = p.value.below.05)) + 
  geom_histogram(binwidth = 0.02, position="stack", color="black") +
  geom_text(x = 0.32, y = 25700, label = paste0("Number of sites = ", nrow(HWEdataESC)), aes(family = "Avenir Regular")) +
  expand_limits(y=40000) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  theme(plot.title = element_text(size = 24))

FORFhist <- ggplot(HWEdataFOR, aes(x = F, fill = p.value.below.05)) + 
  geom_histogram(binwidth = 0.02, position="stack", color="black") +
  geom_text(x = 0.32, y = 25700, label = paste0("Number of sites = ", nrow(HWEdataFOR)), aes(family = "Avenir Regular")) +
  expand_limits(y=40000) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  theme(plot.title = element_text(size = 24))

GABFhist <- ggplot(HWEdataGAB, aes(x = F, fill = p.value.below.05)) + 
  geom_histogram(binwidth = 0.02, position="stack", color="black") +
  geom_text(x = 0.32, y = 25700, label = paste0("Number of sites = ", nrow(HWEdataGAB)), aes(family = "Avenir Regular")) +
  expand_limits(y=40000) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  theme(plot.title = element_text(size = 24))

HERFhist <- ggplot(HWEdataHER, aes(x = F, fill = p.value.below.05)) + 
  geom_histogram(binwidth = 0.02, position="stack", color="black") +
  geom_text(x = 0.32, y = 25700, label = paste0("Number of sites = ", nrow(HWEdataHER)), aes(family = "Avenir Regular")) +
  expand_limits(y=40000) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  theme(plot.title = element_text(size = 24))

LANFhist <- ggplot(HWEdataLAN, aes(x = F, fill = p.value.below.05)) + 
  geom_histogram(binwidth = 0.02, position="stack", color="black") +
  geom_text(x = 0.32, y = 25700, label = paste0("Number of sites = ", nrow(HWEdataLAN)), aes(family = "Avenir Regular")) +
  expand_limits(y=40000) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  theme(plot.title = element_text(size = 24))

MULFhist <- ggplot(HWEdataMUL, aes(x = F, fill = p.value.below.05)) + 
  geom_histogram(binwidth = 0.02, position="stack", color="black") +
  geom_text(x = 0.32, y = 25700, label = paste0("Number of sites = ", nrow(HWEdataMUL)), aes(family = "Avenir Regular")) +
  expand_limits(y=40000) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  theme(plot.title = element_text(size = 24))

PAZFhist <- ggplot(HWEdataPAZ, aes(x = F, fill = p.value.below.05)) + 
  geom_histogram(binwidth = 0.02, position="stack", color="black") +
  geom_text(x = 0.32, y = 25700, label = paste0("Number of sites = ", nrow(HWEdataPAZ)), aes(family = "Avenir Regular")) +
  expand_limits(y=40000) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  theme(plot.title = element_text(size = 24))

PORFhist <- ggplot(HWEdataPOR, aes(x = F, fill = p.value.below.05)) + 
  geom_histogram(binwidth = 0.02, position="stack", color="black") +
  geom_text(x = 0.32, y = 25700, label = paste0("Number of sites = ", nrow(HWEdataPOR)), aes(family = "Avenir Regular")) +
  expand_limits(y=40000) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  theme(plot.title = element_text(size = 24))

SOQFhist <- ggplot(HWEdataSOQ, aes(x = F, fill = p.value.below.05)) + 
  geom_histogram(binwidth = 0.02, position="stack", color="black") +
  geom_text(x = 0.32, y = 25700, label = paste0("Number of sites = ", nrow(HWEdataSOQ)), aes(family = "Avenir Regular")) +
  expand_limits(y=40000) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  theme(plot.title = element_text(size = 24))

#SOQFhist

TOURFhist <- ggplot(HWEdataTOUR, aes(x = F, fill = p.value.below.05)) + 
  geom_histogram(binwidth = 0.02, position="stack", color="black") +
  geom_text(x = 0.32, y = 25700, label = paste0("Number of sites = ", nrow(HWEdataTOUR)), aes(family = "Avenir Regular")) +
  expand_limits(y=40000) +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank()) +
  scale_x_continuous(expand = c(0, 0)) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  theme(plot.title = element_text(size = 24))

###Combined plot

CombinedPlots <- ggarrange(GABFhist, HERFhist, SOQFhist, TOURFhist, ARAFhist, PORFhist, MULFhist, FORFhist, PAZFhist, LANFhist, ESCFhist,
                           labels = c("GAB", "HER", "SOQ", "TOUR", "ARA", "POR", "MUL", "FOR", "PAZ", "LAN", "ESC"),
                           hjust = c(0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001),
                           ncol = 1, nrow = 11, heights = c(1,1,1,1,1,1,1,1,1,1,1.2),
                           font.label = list(family="Avenir Regular"),
                           align = "v"
)
CombinedPlots

###Plotting expected heterozygosity

ggplot(HWEdataARA, aes(x = Hexp)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Araille") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataESC, aes(x = Hexp)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Escarilla") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataFOR, aes(x = Hexp)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Formigal") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataGAB, aes(x = Hexp)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Gabas") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataHER, aes(x = Hexp)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Hermine") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataLAN, aes(x = Hexp)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Lanuza") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataMUL, aes(x = Hexp)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Mulas") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataPAZ, aes(x = Hexp)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Pazino") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataPOR, aes(x = Hexp)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Portalet") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataSOQ, aes(x = Hexp)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Soques") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataTOUR, aes(x = Hexp)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Tourmont") +
  theme(plot.title = element_text(size = 24))


###Plotting observed heterozygosity

ggplot(HWEdataARA, aes(x = Hobs)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Araille") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataESC, aes(x = Hobs)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Escarilla") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataFOR, aes(x = Hobs)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Formigal") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataGAB, aes(x = Hobs)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Gabas") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataHER, aes(x = Hobs)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Hermine") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataLAN, aes(x = Hobs)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Lanuza") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataMUL, aes(x = Hobs)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Mulas") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataPAZ, aes(x = Hobs)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Pazino") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataPOR, aes(x = Hobs)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Portalet") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataSOQ, aes(x = Hobs)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Soques") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataTOUR, aes(x = Hobs)) + 
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Tourmont") +
  theme(plot.title = element_text(size = 24))


###hweFreq per site

ggplot(HWEdataARA, aes(x = hweFreq)) +
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Araille") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataGAB, aes(x = hweFreq)) +
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Gabas") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataMUL, aes(x = hweFreq)) +
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Mulas") +
  theme(plot.title = element_text(size = 24))

ggplot(HWEdataESC, aes(x = hweFreq)) +
  geom_histogram(binwidth = 0.005, color="black", fill="white") +
  ggtitle("Escarilla") +
  theme(plot.title = element_text(size = 24))

###Proportion of sites significantly deviating from HWE per population

SigPPerPop <- c(
length(HWEdataGAB$p.value.below.05[HWEdataGAB$p.value.below.05 == "Below"])/length(HWEdataGAB[,1]),
length(HWEdataHER$p.value.below.05[HWEdataHER$p.value.below.05 == "Below"])/length(HWEdataHER[,1]),
length(HWEdataSOQ$p.value.below.05[HWEdataSOQ$p.value.below.05 == "Below"])/length(HWEdataSOQ[,1]),
length(HWEdataTOUR$p.value.below.05[HWEdataTOUR$p.value.below.05 == "Below"])/length(HWEdataTOUR[,1]),
length(HWEdataARA$p.value.below.05[HWEdataARA$p.value.below.05 == "Below"])/length(HWEdataARA[,1]),
length(HWEdataPOR$p.value.below.05[HWEdataPOR$p.value.below.05 == "Below"])/length(HWEdataPOR[,1]),
length(HWEdataMUL$p.value.below.05[HWEdataMUL$p.value.below.05 == "Below"])/length(HWEdataMUL[,1]),
length(HWEdataFOR$p.value.below.05[HWEdataFOR$p.value.below.05 == "Below"])/length(HWEdataFOR[,1]),
length(HWEdataPAZ$p.value.below.05[HWEdataPAZ$p.value.below.05 == "Below"])/length(HWEdataPAZ[,1]),
length(HWEdataLAN$p.value.below.05[HWEdataLAN$p.value.below.05 == "Below"])/length(HWEdataLAN[,1]),
length(HWEdataESC$p.value.below.05[HWEdataESC$p.value.below.05 == "Below"])/length(HWEdataESC[,1]))

SigPPerPop

GeoOrder <- c("GAB", "HER", "SOQ", "TOUR", "ARA", "POR", "MUL", "FOR", "PAZ", "LAN", "ESC")

SigPPerPopDF <- data.frame(GeoOrder, SigPPerPop)

ggplot(SigPPerPopDF, aes(x = factor(GeoOrder, level = GeoOrder), y = SigPPerPop, )) +
  geom_point() +
  ggtitle("Proportion of sites significantly deviating from HWE") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Significant sites") +
  xlab("Sampling site") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium"))


#Mean F per sampling site

MeanFs <- c(mean(HWEdataGAB$F),
            mean(HWEdataHER$F),
            mean(HWEdataSOQ$F),
            mean(HWEdataTOUR$F),
            mean(HWEdataARA$F),
            mean(HWEdataPOR$F),
            mean(HWEdataMUL$F),
            mean(HWEdataFOR$F),
            mean(HWEdataPAZ$F),
            mean(HWEdataLAN$F),
            mean(HWEdataESC$F))

MeanFs

MedianFs <- c(median(HWEdataGAB$F),
              median(HWEdataHER$F),
              median(HWEdataSOQ$F),
              median(HWEdataTOUR$F),
              median(HWEdataARA$F),
              median(HWEdataPOR$F),
              median(HWEdataMUL$F),
              median(HWEdataFOR$F),
              median(HWEdataPAZ$F),
              median(HWEdataLAN$F),
              median(HWEdataESC$F))
MedianFs

LowerSDFs <- MeanFs-c(sd(HWEdataGAB$F)/2,
               sd(HWEdataHER$F)/2,
               sd(HWEdataSOQ$F)/2,
               sd(HWEdataTOUR$F)/2,
               sd(HWEdataARA$F)/2,
               sd(HWEdataPOR$F)/2,
               sd(HWEdataMUL$F)/2,
               sd(HWEdataFOR$F)/2,
               sd(HWEdataPAZ$F)/2,
               sd(HWEdataLAN$F)/2,
               sd(HWEdataESC$F)/2)
LowerSDFs

UpperSDFs <- MeanFs+c(sd(HWEdataGAB$F)/2,
                      sd(HWEdataHER$F)/2,
                      sd(HWEdataSOQ$F)/2,
                      sd(HWEdataTOUR$F)/2,
                      sd(HWEdataARA$F)/2,
                      sd(HWEdataPOR$F)/2,
                      sd(HWEdataMUL$F)/2,
                      sd(HWEdataFOR$F)/2,
                      sd(HWEdataPAZ$F)/2,
                      sd(HWEdataLAN$F)/2,
                      sd(HWEdataESC$F)/2)
UpperSDFs

LocalityOrder <- factor(c("Gabas", "Hermine", "Soques", "Tourmont", "Araille", "Portalet", "Mulas", "Formigal", "Pazino", "Lanuza", "Escarrilla"))
LocalityOrder

LocalityOrder3 <- c("Escarrilla", "Lanuza", "Pazino", "Formigal", "Mulas", "Portalet", "Araille", "Tourmont", "Soques", "Hermine", "Gabas")
LocalityOrder3

MeanFframe <- data.frame(MeanFs, LocalityOrder)
MedianFframe <- data.frame(MedianFs, LocalityOrder)
MedianFframe[3] <- LowerSDFs
MedianFframe[4] <- UpperSDFs

ggplot(MeanFframe, aes(x = MeanFs, factor(LocalityOrder, levels=LocalityOrder3))) +
  geom_point(size = 1.96) +
  scale_x_continuous(expand = c(0, 0), limits = c(-1, 1)) +
  ggtitle("Mean F per sampling site") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Locality") +
  xlab("F") +
  theme(text=element_text(size=16,  family="Avenir Regular")) +
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality") +
  scale_fill_manual(values = CustomColours)

ggplot(MedianFframe, aes(x = MedianFs, factor(LocalityOrder, levels=LocalityOrder3), xmin = V3, xmax = V4)) +
  geom_point(size = 1.96) +
  geom_pointrange() +
  geom_vline(xintercept=0, lty=2, size = 1) +
  ggtitle("Median F per sampling site") +
  scale_x_continuous(expand = c(0, 0), limits = c(-1, 1)) +
  theme(plot.title = element_text(size = 18)) +
  ylab("Locality") +
  xlab("F") +
  theme(text=element_text(size=16,  family="Avenir Regular")) +
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium")) +
  scale_color_discrete("Locality")

###Stacked plot of proportions

#N of significantly positive F

NPosF <- c(length(HWEdataGAB$p.value.below.05[HWEdataGAB$F > 0 & HWEdataGAB$p.value.below.05 == "Below"]),
length(HWEdataHER$p.value.below.05[HWEdataHER$F > 0 & HWEdataHER$p.value.below.05 == "Below"]),
length(HWEdataSOQ$p.value.below.05[HWEdataSOQ$F > 0 & HWEdataSOQ$p.value.below.05 == "Below"]),
length(HWEdataTOUR$p.value.below.05[HWEdataTOUR$F > 0 & HWEdataTOUR$p.value.below.05 == "Below"]),
length(HWEdataARA$p.value.below.05[HWEdataARA$F > 0 & HWEdataARA$p.value.below.05 == "Below"]),
length(HWEdataPOR$p.value.below.05[HWEdataPOR$F > 0 & HWEdataPOR$p.value.below.05 == "Below"]),
length(HWEdataMUL$p.value.below.05[HWEdataMUL$F > 0 & HWEdataMUL$p.value.below.05 == "Below"]),
length(HWEdataFOR$p.value.below.05[HWEdataFOR$F > 0 & HWEdataFOR$p.value.below.05 == "Below"]),
length(HWEdataPAZ$p.value.below.05[HWEdataPAZ$F > 0 & HWEdataPAZ$p.value.below.05 == "Below"]),
length(HWEdataLAN$p.value.below.05[HWEdataLAN$F > 0 & HWEdataLAN$p.value.below.05 == "Below"]),
length(HWEdataESC$p.value.below.05[HWEdataESC$F > 0 & HWEdataESC$p.value.below.05 == "Below"]))

#N of significantly Negative F

NNegF <- c(length(HWEdataGAB$p.value.below.05[HWEdataGAB$F < 0 & HWEdataGAB$p.value.below.05 == "Below"]),
           length(HWEdataHER$p.value.below.05[HWEdataHER$F < 0 & HWEdataHER$p.value.below.05 == "Below"]),
           length(HWEdataSOQ$p.value.below.05[HWEdataSOQ$F < 0 & HWEdataSOQ$p.value.below.05 == "Below"]),
           length(HWEdataTOUR$p.value.below.05[HWEdataTOUR$F < 0 & HWEdataTOUR$p.value.below.05 == "Below"]),
           length(HWEdataARA$p.value.below.05[HWEdataARA$F < 0 & HWEdataARA$p.value.below.05 == "Below"]),
           length(HWEdataPOR$p.value.below.05[HWEdataPOR$F < 0 & HWEdataPOR$p.value.below.05 == "Below"]),
           length(HWEdataMUL$p.value.below.05[HWEdataMUL$F < 0 & HWEdataMUL$p.value.below.05 == "Below"]),
           length(HWEdataFOR$p.value.below.05[HWEdataFOR$F < 0 & HWEdataFOR$p.value.below.05 == "Below"]),
           length(HWEdataPAZ$p.value.below.05[HWEdataPAZ$F < 0 & HWEdataPAZ$p.value.below.05 == "Below"]),
           length(HWEdataLAN$p.value.below.05[HWEdataLAN$F < 0 & HWEdataLAN$p.value.below.05 == "Below"]),
           length(HWEdataESC$p.value.below.05[HWEdataESC$F < 0 & HWEdataESC$p.value.below.05 == "Below"]))

#N of nonsignificant F

NNonF <- c(length(HWEdataGAB$p.value.below.05[HWEdataGAB$p.value.below.05 == "Above"]),
           length(HWEdataHER$p.value.below.05[HWEdataHER$p.value.below.05 == "Above"]),
           length(HWEdataSOQ$p.value.below.05[HWEdataSOQ$p.value.below.05 == "Above"]),
           length(HWEdataTOUR$p.value.below.05[HWEdataTOUR$p.value.below.05 == "Above"]),
           length(HWEdataARA$p.value.below.05[HWEdataARA$p.value.below.05 == "Above"]),
           length(HWEdataPOR$p.value.below.05[HWEdataPOR$p.value.below.05 == "Above"]),
           length(HWEdataMUL$p.value.below.05[HWEdataMUL$p.value.below.05 == "Above"]),
           length(HWEdataFOR$p.value.below.05[HWEdataFOR$p.value.below.05 == "Above"]),
           length(HWEdataPAZ$p.value.below.05[HWEdataPAZ$p.value.below.05 == "Above"]),
           length(HWEdataLAN$p.value.below.05[HWEdataLAN$p.value.below.05 == "Above"]),
           length(HWEdataESC$p.value.below.05[HWEdataESC$p.value.below.05 == "Above"]))

PvalueProportions <- data.frame(LocalityOrder, NPosF, NNegF, NNonF)
PvalueProportionsHorizontal <- PvalueProportions
PvalueProportions <- melt(PvalueProportions)

ggplot(data=PvalueProportions, aes(x = LocalityOrder, y = value, fill = variable)) +
  geom_bar(stat = "identity") +
  ggtitle("Proportions of sites") +
  scale_fill_discrete(name = "HWE Deviance") +
  labs(fill = "Significance") +
  theme(plot.title = element_text(size = 24))+
  ylab("Number of Sites") +
  xlab(NULL) +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  scale_fill_manual(values=c("#73D055FF", "#DE7065FF", "#3E9BFEFF"), labels = c("Positive", "Negative", "Nonsignificant"))

#Fractions of significantly deviating sites

#Negative

NegProportions <- PvalueProportionsHorizontal$NNegF/
  (PvalueProportionsHorizontal$NPosF+PvalueProportionsHorizontal$NNegF+PvalueProportionsHorizontal$NNonF)

mean(NegProportions)
#0.04970068
sd(NegProportions)
#0.01120433

#Positive

PosProportions <- PvalueProportionsHorizontal$NPosF/
  (PvalueProportionsHorizontal$NPosF+PvalueProportionsHorizontal$NNegF+PvalueProportionsHorizontal$NNonF)
PosProportions

mean(PosProportions)
#0.04548691
sd(PosProportions)
#0.006242901