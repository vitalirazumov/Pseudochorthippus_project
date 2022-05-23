#Importing packages and Avenir fonts
library(ggplot2)
library(scales)
library(reshape2)
library(ggpubr)
library(viridis)
library(extrafont)
library(hzar)
library(mosaic)
loadfonts(loadfonts(device = "win"))

#Avenir fonts:
#Avenir Regular
#Avenir LT Std 65 Medium
#Avenir LT Std 45 Book
#Avenir LT Std 55 Roman

#Locality order vectors for plotting
PopLabels <- c("GAB", rep(" ", 4), "HER", rep(" ", 9), "SOQ", rep(" ", 10), "TOUR", rep(" ", 9), "ARA", rep(" ", 9), "POR", rep(" ", 9),
                "MUL", rep(" ", 8), "FOR", rep(" ", 7), "PAZ", rep(" ", 9), "LAN", rep(" ", 9), "ESC", rep(" ", 4))
PopOrder <- c("GAB", "HER", "SOQ", "TOUR", "ARA", "POR", "MUL", "FOR", "PAZ", "LAN", "ESC")
SampleIdentities <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/PopSampleID.info",as.is=T)


#Hexadecimal codes for colours used
scales::viridis_pal(option = "H")(length(unique(PopOrder)))

#######################
### Structure plots ###
#######################

###Structure plot, K2
ngsadmixK2 <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/Analysis_Data/ngsAdmix_K2_REP_12.qopt")
K2DF <- cbind(SampleIdentities, ngsadmixK2)
colnames(K2DF) <- c("Population", "SampleID", "GT1", "GT2")

# Reassigning MUL414 as SOQ414 and re-ordering the data frame
K2DF[56,1] <- "SOQ"
K2DF[56,2] <- "SOQ414"
K2DF <- K2DF[order(K2DF$SampleID),]
K2DF$Population <- factor(K2DF$Population, levels = PopOrder)
K2DF <-  K2DF[order(K2DF$Population),]

#Removing unnecessary column
K2DF <- K2DF[,2:4]

#Fixing row numbers
rownames(K2DF) <- 1:nrow(K2DF)

#Melting the data frame
MeltK2DF <- melt(K2DF, id.vars="SampleID")

#Creating a vector of sample names for plotting
SampleNames <- MeltK2DF[1:98,1]

#Plotting
K2plot <- ggplot(MeltK2DF, aes(factor(SampleID, level = SampleNames), value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity", width=1) +
  scale_y_continuous(labels = percent) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Admixture proportion") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular")) +
  theme(axis.text.x = element_text(size = 13, angle = 0, vjust = 0.5, hjust=0.12, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "none") +
  scale_x_discrete(labels = c(PopLabels), position = "top") +
  theme(axis.title.x = element_blank(), axis.ticks.x = element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(title = element_blank()) +
  theme(plot.margin = unit(c(0,0.5,0.1,1.5), "cm")) +
  geom_vline(xintercept = c(5.5, 15.5, 26.5, 36.5, 46.5, 56.5, 65.5, 73.5, 83.5, 93.5), size = 1, color = "black", linetype = 2) +
  geom_vline(xintercept = c(seq(1.5,4.5), seq(6.5,14.5), seq(16.5,25.5), seq(27.5,35.5), seq(37.5,45.5), seq(47.5,55.5), seq(57.5,64.5), seq(66.5,72.5),
                            seq(74.5,82.5), seq(84.5,92.5), seq(94.5,97.5)),
             size = 0.1, color = "black", linetype = 1) +
  scale_fill_manual(values = c("#30123BFF", "#7A0403FF"))

K2plot

#Admixture proportions in

#Mulas
mean(K2DF[57:65,3])
#0.5526455
sd(K2DF[57:65,3])
#0.06629622

#Portalet
mean(K2DF[47:56,3])
#0.184584
sd(K2DF[47:56,3])
#0.02009896

#Araille
mean(K2DF[37:46,3])
#0.007494545
sd(K2DF[37:46,3])
#0.01725941

#Formigal
mean(K2DF[66:73,3])
#0.9899044
sd(K2DF[66:73,3])
#0.02855463

### Structure plot, K3
ngsadmixK3 <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/Analysis_Data/ngsAdmix_K3_REP_36.qopt")
K3DF <- cbind(SampleIdentities, ngsadmixK3)
colnames(K3DF) <- c("Population", "SampleID", "GT1", "GT2", "GT3")

K3DF[56,1] <- "SOQ"
K3DF[56,2] <- "SOQ414"
K3DF <- K3DF[order(K3DF$SampleID),]
K3DF$Population <- factor(K3DF$Population, levels = PopOrder)
K3DF <-  K3DF[order(K3DF$Population),]

K3DF <- K3DF[,2:5]

MeltK3DF <- melt(K3DF, id.vars="SampleID")

rownames(K3DF) <- 1:nrow(K3DF)

K3plot <- ggplot(MeltK3DF, aes(factor(SampleID, level = SampleNames), value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity", width=1) +
  scale_y_continuous(labels = percent) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Admixture proportion") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "none") +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(title = element_blank()) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  geom_vline(xintercept = c(5.5, 15.5, 26.5, 36.5, 46.5, 56.5, 65.5, 73.5, 83.5, 93.5), size = 1, color = "black", linetype = 2) +
  geom_vline(xintercept = c(seq(1.5,4.5), seq(6.5,14.5), seq(16.5,25.5), seq(27.5,35.5), seq(37.5,45.5), seq(47.5,55.5), seq(57.5,64.5), seq(66.5,72.5),
                            seq(74.5,82.5), seq(84.5,92.5), seq(94.5,97.5)),
             size = 0.1, color = "black", linetype = 1) +
  scale_fill_manual(values = c("#30123BFF", "#455BCDFF", "#7A0403FF"))

K3plot

#Admixture proportions in

#Soques
mean(K3DF[16:26,3])
#0.1278478
sd(K3DF[16:26,3])
#0.01484424

### Structure analysis, K4
ngsadmixK4 <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/Analysis_Data/ngsAdmix_K4_REP_49.qopt")
K4DF <- cbind(SampleIdentities, ngsadmixK4)
colnames(K4DF) <- c("Population", "SampleID", "GT1", "GT2", "GT3", "GT4")

K4DF[56,1] <- "SOQ"
K4DF[56,2] <- "SOQ414"
K4DF <- K4DF[order(K4DF$SampleID),]
K4DF$Population <- factor(K4DF$Population, levels = PopOrder)
K4DF <-  K4DF[order(K4DF$Population),]

K4DF <- K4DF[,2:6]

MeltK4DF <- melt(K4DF, id.vars="SampleID")

K4plot <- ggplot(MeltK4DF, aes(factor(SampleID, level = SampleNames), value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity", width=1) +
  scale_y_continuous(labels = percent) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Admixture proportion") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "none") +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(title = element_blank()) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  geom_vline(xintercept = c(5.5, 15.5, 26.5, 36.5, 46.5, 56.5, 65.5, 73.5, 83.5, 93.5), size = 1, color = "black", linetype = 2) +
  geom_vline(xintercept = c(seq(1.5,4.5), seq(6.5,14.5), seq(16.5,25.5), seq(27.5,35.5), seq(37.5,45.5), seq(47.5,55.5), seq(57.5,64.5), seq(66.5,72.5),
                            seq(74.5,82.5), seq(84.5,92.5), seq(94.5,97.5)),
             size = 0.1, color = "black", linetype = 1) +
  scale_fill_manual(values = c("#30123BFF", "#7A0403FF", "#455BCDFF", "#C42503FF"))

K4plot

### Structure analysis, K5
ngsadmixK5 <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/Analysis_Data/ngsAdmix_K5_REP_28.qopt")
K5DF <- cbind(SampleIdentities, ngsadmixK5)
colnames(K5DF) <- c("Population", "SampleID", "GT1", "GT2", "GT3", "GT4", "GT5")

K5DF[56,1] <- "SOQ"
K5DF[56,2] <- "SOQ414"
K5DF <- K5DF[order(K5DF$SampleID),]
K5DF$Population <- factor(K5DF$Population, levels = PopOrder)
K5DF <-  K5DF[order(K5DF$Population),]

K5DF <- K5DF[,2:7]

MeltK5DF <- melt(K5DF, id.vars="SampleID")

K5plot <- ggplot(MeltK5DF, aes(factor(SampleID, level = SampleNames), value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity", width=1) +
  scale_y_continuous(labels = percent) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Admixture proportion") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "none") +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(title = element_blank()) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  geom_vline(xintercept = c(5.5, 15.5, 26.5, 36.5, 46.5, 56.5, 65.5, 73.5, 83.5, 93.5), size = 1, color = "black", linetype = 2) +
  geom_vline(xintercept = c(seq(1.5,4.5), seq(6.5,14.5), seq(16.5,25.5), seq(27.5,35.5), seq(37.5,45.5), seq(47.5,55.5), seq(57.5,64.5), seq(66.5,72.5),
                            seq(74.5,82.5), seq(84.5,92.5), seq(94.5,97.5)),
             size = 0.1, color = "black", linetype = 1) +
  scale_fill_manual(values = c("#7A0403FF", "#C42503FF", "#455BCDFF", "#30123BFF", "#3E9BFEFF"))

K5plot

### Structure analysis, K6
ngsadmixK6 <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/Analysis_Data/ngsAdmix_K6_REP_35.qopt")
K6DF <- cbind(SampleIdentities, ngsadmixK6)
colnames(K6DF) <- c("Population", "SampleID", "GT1", "GT2", "GT3", "GT4", "GT5", "GT6")

K6DF[56,1] <- "SOQ"
K6DF[56,2] <- "SOQ414"
K6DF <- K6DF[order(K6DF$SampleID),]
K6DF$Population <- factor(K6DF$Population, levels = PopOrder)
K6DF <-  K6DF[order(K6DF$Population),]

K6DF <- K6DF[,2:8]

MeltK6DF <- melt(K6DF, id.vars="SampleID")

K6plot <- ggplot(MeltK6DF, aes(factor(SampleID, level = SampleNames), value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity", width=1) +
  scale_y_continuous(labels = percent) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Admixture proportion") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "none") +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(title = element_blank()) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  geom_vline(xintercept = c(5.5, 15.5, 26.5, 36.5, 46.5, 56.5, 65.5, 73.5, 83.5, 93.5), size = 1, color = "black", linetype = 2) +
  geom_vline(xintercept = c(seq(1.5,4.5), seq(6.5,14.5), seq(16.5,25.5), seq(27.5,35.5), seq(37.5,45.5), seq(47.5,55.5), seq(57.5,64.5), seq(66.5,72.5),
                            seq(74.5,82.5), seq(84.5,92.5), seq(94.5,97.5)),
             size = 0.1, color = "black", linetype = 1) +
  scale_fill_manual(values = c("#7A0403FF", "#30123BFF", "#3E9BFEFF", "#455BCDFF", "#C42503FF", "#F05B12FF"))

K6plot

### Structure analysis, K7
ngsadmixK7 <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/Analysis_Data/ngsAdmix_K7_REP_02.qopt")
K7DF <- cbind(SampleIdentities, ngsadmixK7)
colnames(K7DF) <- c("Population", "SampleID", "GT1", "GT2", "GT3", "GT4", "GT5", "GT6", "GT7")

K7DF[56,1] <- "SOQ"
K7DF[56,2] <- "SOQ414"
K7DF <- K7DF[order(K7DF$SampleID),]
K7DF$Population <- factor(K7DF$Population, levels = PopOrder)
K7DF <-  K7DF[order(K7DF$Population),]

K7DF <- K7DF[,2:9]

MeltK7DF <- melt(K7DF, id.vars="SampleID")

K7plot <- ggplot(MeltK7DF, aes(factor(SampleID, level = SampleNames), value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity", width=1) +
  scale_y_continuous(labels = percent) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Admixture proportion") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "none") +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(title = element_blank()) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  geom_vline(xintercept = c(5.5, 15.5, 26.5, 36.5, 46.5, 56.5, 65.5, 73.5, 83.5, 93.5), size = 1, color = "black", linetype = 2) +
  geom_vline(xintercept = c(seq(1.5,4.5), seq(6.5,14.5), seq(16.5,25.5), seq(27.5,35.5), seq(37.5,45.5), seq(47.5,55.5), seq(57.5,64.5), seq(66.5,72.5),
                            seq(74.5,82.5), seq(84.5,92.5), seq(94.5,97.5)),
             size = 0.1, color = "black", linetype = 1) +
  scale_fill_manual(values = c("#7A0403FF", "#455BCDFF", "#F05B12FF", "#30123BFF", "#C42503FF", "#18D6CBFF", "#3E9BFEFF"))

K7plot

### Structure analysis, K8
ngsadmixK8 <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/Analysis_Data/ngsAdmix_K8_REP_03.qopt")
K8DF <- cbind(SampleIdentities, ngsadmixK8)
colnames(K8DF) <- c("Population", "SampleID", "GT1", "GT2", "GT3", "GT4", "GT5", "GT6", "GT7", "GT8")

K8DF[56,1] <- "SOQ"
K8DF[56,2] <- "SOQ414"
K8DF <- K8DF[order(K8DF$SampleID),]
K8DF$Population <- factor(K8DF$Population, levels = PopOrder)
K8DF <-  K8DF[order(K8DF$Population),]

K8DF <- K8DF[,2:10]

MeltK8DF <- melt(K8DF, id.vars="SampleID")

K8plot <- ggplot(MeltK8DF, aes(factor(SampleID, level = SampleNames), value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity", width=1) +
  scale_y_continuous(labels = percent) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Admixture proportion") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "none") +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(title = element_blank()) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  geom_vline(xintercept = c(5.5, 15.5, 26.5, 36.5, 46.5, 56.5, 65.5, 73.5, 83.5, 93.5), size = 1, color = "black", linetype = 2) +
  geom_vline(xintercept = c(seq(1.5,4.5), seq(6.5,14.5), seq(16.5,25.5), seq(27.5,35.5), seq(37.5,45.5), seq(47.5,55.5), seq(57.5,64.5), seq(66.5,72.5),
                            seq(74.5,82.5), seq(84.5,92.5), seq(94.5,97.5)),
             size = 0.1, color = "black", linetype = 1) +
  scale_fill_manual(values = c("#18D6CBFF", "#30123BFF", "#F05B12FF", "#3E9BFEFF", "#7A0403FF", "#C42503FF", "#455BCDFF", "#FEA632FF"))

K8plot

### Structure analysis, K9
ngsadmixK9 <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/Analysis_Data/ngsAdmix_K9_REP_34.qopt")
K9DF <- cbind(SampleIdentities, ngsadmixK9)
colnames(K9DF) <- c("Population", "SampleID", "GT1", "GT2", "GT3", "GT4", "GT5", "GT6", "GT7", "GT8", "GT9")

K9DF[56,1] <- "SOQ"
K9DF[56,2] <- "SOQ414"
K9DF <- K9DF[order(K9DF$SampleID),]
K9DF$Population <- factor(K9DF$Population, levels = PopOrder)
K9DF <-  K9DF[order(K9DF$Population),]

K9DF <- K9DF[,2:11]

MeltK9DF <- melt(K9DF, id.vars="SampleID")

K9plot <- ggplot(MeltK9DF, aes(factor(SampleID, level = SampleNames), value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity", width=1) +
  scale_y_continuous(labels = percent) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Admixture proportion") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "none") +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(title = element_blank()) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  geom_vline(xintercept = c(5.5, 15.5, 26.5, 36.5, 46.5, 56.5, 65.5, 73.5, 83.5, 93.5), size = 1, color = "black", linetype = 2) +
  geom_vline(xintercept = c(seq(1.5,4.5), seq(6.5,14.5), seq(16.5,25.5), seq(27.5,35.5), seq(37.5,45.5), seq(47.5,55.5), seq(57.5,64.5), seq(66.5,72.5),
                            seq(74.5,82.5), seq(84.5,92.5), seq(94.5,97.5)),
             size = 0.1, color = "black", linetype = 1) +
  scale_fill_manual(values = c("#30123BFF", "#3E9BFEFF", "#FEA632FF", "#18D6CBFF", "#46F884FF", "#C42503FF", "#7A0403FF", "#F05B12FF", "#455BCDFF"))

K9plot

### Structure analysis, K10
ngsadmixK10 <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/Analysis_Data/ngsAdmix_K10_REP_50.qopt")
K10DF <- cbind(SampleIdentities, ngsadmixK10)
colnames(K10DF) <- c("Population", "SampleID", "GT1", "GT2", "GT3", "GT4", "GT5", "GT6", "GT7", "GT8", "GT9", "GT10")

K10DF[56,1] <- "SOQ"
K10DF[56,2] <- "SOQ414"
K10DF <- K10DF[order(K10DF$SampleID),]
K10DF$Population <- factor(K10DF$Population, levels = PopOrder)
K10DF <-  K10DF[order(K10DF$Population),]

K10DF <- K10DF[,2:12]

MeltK10DF <- melt(K10DF, id.vars="SampleID")

K10plot <- ggplot(MeltK10DF, aes(factor(SampleID, level = SampleNames), value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity", width=1) +
  scale_y_continuous(labels = percent) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Admixture proportion") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "none") +
  theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank()) +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(title = element_blank()) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  geom_vline(xintercept = c(5.5, 15.5, 26.5, 36.5, 46.5, 56.5, 65.5, 73.5, 83.5, 93.5), size = 1, color = "black", linetype = 2) +
  geom_vline(xintercept = c(seq(1.5,4.5), seq(6.5,14.5), seq(16.5,25.5), seq(27.5,35.5), seq(37.5,45.5), seq(47.5,55.5), seq(57.5,64.5), seq(66.5,72.5),
                            seq(74.5,82.5), seq(84.5,92.5), seq(94.5,97.5)),
             size = 0.1, color = "black", linetype = 1) +
  scale_fill_manual(values = c("#F05B12FF", "#3E9BFEFF", "#455BCDFF", "#E1DD37FF", "#C42503FF", "#7A0403FF", "#FEA632FF", "#46F884FF", "#18D6CBFF", "#30123BFF"))

K10plot

### Structure analysis, K11
ngsadmixK11 <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/Analysis_Data/ngsAdmix_K11_REP_49.qopt")
K11DF <- cbind(SampleIdentities, ngsadmixK11)
colnames(K11DF) <- c("Population", "SampleID", "GT1", "GT2", "GT3", "GT4", "GT5", "GT6", "GT7", "GT8", "GT9", "GT10", "GT11")

K11DF[56,1] <- "SOQ"
K11DF[56,2] <- "SOQ414"
K11DF <- K11DF[order(K11DF$SampleID),]
K11DF$Population <- factor(K11DF$Population, levels = PopOrder)
K11DF <-  K11DF[order(K11DF$Population),]

K11DF <- K11DF[,2:13]

MeltK11DF <- melt(K11DF, id.vars="SampleID")

K11plot <- ggplot(MeltK11DF, aes(factor(SampleID, level = SampleNames), value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity", width=1) +
  scale_y_continuous(labels = percent) +
  expand_limits(y=0) +
  scale_y_continuous(expand = c(0, 0)) +
  ylab("Admixture proportion") +
  xlab("Sample ID") +
  theme(text=element_text(size=16,  family="Avenir Regular")) +
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) +
  theme(legend.position = "none") +
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(), axis.ticks.y = element_blank()) +
  theme(axis.title = element_blank()) +
  theme(title = element_blank()) +
  theme(plot.margin = unit(c(0,0.5,0,1.5), "cm")) +
  geom_vline(xintercept = c(5.5, 15.5, 26.5, 36.5, 46.5, 56.5, 65.5, 73.5, 83.5, 93.5), size = 1, color = "black", linetype = 2) +
  geom_vline(xintercept = c(seq(1.5,4.5), seq(6.5,14.5), seq(16.5,25.5), seq(27.5,35.5), seq(37.5,45.5), seq(47.5,55.5), seq(57.5,64.5), seq(66.5,72.5),
                            seq(74.5,82.5), seq(84.5,92.5), seq(94.5,97.5)),
             size = 0.1, color = "black", linetype = 1) +
  scale_fill_manual(values = c("#18D6CBFF", "#455BCDFF", "#A2FC3CFF", "#F05B12FF", "#30123BFF", "#C42503FF", "#FEA632FF", "#7A0403FF", "#E1DD37FF", "#46F884FF", "#3E9BFEFF"))

K11plot

### Combining structure plots

CombinedPlots <- ggarrange(K2plot, K3plot, K4plot, K5plot, K6plot, K7plot, K8plot, K9plot, K10plot, K11plot,
                           labels = c("K2", "K3", "K4", "K5", "K6", "K7", "K8", "K9", "K10", "K11"),
                           hjust = c(-1.2, -1.2, -1.2, -1.2, -1.2, -1.2, -1.2, -1.2, -0.5, -0.5),
                           vjust = c(2.3, rep(1, 9)),
                           ncol = 1, nrow = 10, heights = c(1.2,1,1,1,1,1,1,1,1,1.55),
                           font.label = list(family="Avenir Regular")
                           )
CombinedPlots

########################
### Plotting Delta K ###
########################

### Loglikelihood plot for different K-values

#Log-values from NGSandmix output files
logvalues <- c(-13434414.752069, -11407035.498626,	-10825056.099992,	-10689275.336975,	-10566058.166375,	-10445232.488835,	-10329372.338656,	-10224242.249809,	-10134453.637621,	-10035128.950446,	-9945134.677072)

Klabels <- c("K1","K2","K3","K4","K5","K6","K7","K8","K9","K10","K11")

KLLikFrame <- data.frame(Klabels, logvalues)
KLLikFrame$Klabels <- as.factor

#Plotting log-likelihood values
ggplot(KLLikFrame, aes(x = factor(Klabels, levels = Klabels), y = logvalues, group = 1)) +
  geom_line(linetype = 1, color = "red", size = 0.8) +
  geom_point(size = 5, shape = 18) +
  ggtitle("Log-likelihood of varying K-values") +
  theme(plot.title = element_text(size = 24)) +
  ylab("Log-likelihood") +
  xlab("K-value") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) 

###Plotting Delta K

#Delta K calculated as in Evanno et al. 2005
DeltaK <- c(30067512.182329, 3.04030877924794, 6.06834261019457, 1.44972951482102, 0.917013893584489, 0.085146474798273,
            0.431157938251198, 0.362151226897628, 0.161020647608882, 5.16538542317421)
DeltaKlabels <- c("K2","K3","K4","K5","K6","K7","K8","K9","K10","K11")

DeltaKFrame <- data.frame(DeltaKlabels, DeltaK)

ggplot(DeltaKFrame, aes(x = factor(DeltaKlabels, levels = DeltaKlabels), y = DeltaK, group = 1)) +
  geom_line(linetype = 1, color = "red", size = 0.8) +
  geom_point(size = 5, shape = 18) +
  ggtitle("DeltaK Plot") +
  theme(plot.title = element_text(size = 24)) +
  ylab("DeltaK") +
  xlab("K") +
  theme(text=element_text(size=16,  family="Avenir Regular"))+
  theme(axis.text.x = element_text(size = 8, vjust = 0.5, hjust=0.45, family = "Avenir LT Std 65 Medium")) 

################################################
### Neutral Diffusion Model & Ancestry cline ###
################################################

###Neutral diffusion model

#From Gay et al. 2008:

#If a barrier to gene flow is absent or weak and involves few
#genes, allelic clines at neutral loci are expected to decay after the
#secondary contact. In this simple scenario, the width of a neutral
#cline (w) depends only on the dispersal rate (sig) and the number
#of generations since contact (t) (Endler 1977)

#w = sqrt(2*pi)*sig*sqrt(t) ||/sqrt(2*pi)*sig

#Then:
#sqrt(t) = w/(sqrt(2*pi)*sig) ||^2
#t = (w/(sqrt(2*pi)*sig))^2

w = 4.15329
sig = 0.030 #(Hewitt 1993)
t 

sqrt(2*pi)*sig*sqrt(9000)

#9000 gen
#7.133989

#15000 gen
#9.20994

(w/(sqrt(2*pi)*sig))^2

###Probability of ancestry (Q) along distance graph, K=2

Distances <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/TranscriptomeStats/NGSadmix/Distances_From_Gabas.csv", header = T, sep = ";", dec = ",")

AdmixGeoK2DF <- data.frame(Distances[,2], stringsAsFactors = T)
AdmixGeoK2DF[,2:3] <- data.frame(K2DF[,1:2], stringsAsFactors = T)
AdmixGeoK2DF[,4] <- Distances[,3]

#Observed cline width and center estimation

hzar.dataframe <- AdmixGeoK2DF
hzar.dataframe[,5] <- 196
hzar.obs <- hzar.doMolecularData1DPops(hzar.dataframe$V4,
                                         + hzar.dataframe$GT1,
                                         + hzar.dataframe$V5)
hzar.obs
hzar.plot.obsData(hzar.obs)
hzar.model <- hzar.makeCline1DFreq(hzar.obs, "fixed", "none")
print(hzar.model)
hzar.fitRequest <- hzar.first.fitRequest.old.ML(obsData = hzar.obs, model = hzar.model)
print(hzar.fitRequest)
hzar.chain <- hzar.doFit(hzar.fitRequest)
plot(hzar.mcmc.bindLL(hzar.chain))
hzar.plot.cline(hzar.chain)
print(hzar.get.ML.cline(hzar.chain))

#Results:
#Center
#12.68288
#Width
#4.15329
#Min probability of ancestry
#1e-09
#Max probability of ancestry
#1

#Plotting a cline using hzar results

center <- 12.68278
width <- 4.153781
pMin <- 1e-09
pMax <- 1

#Function to calculate data points
datapoints <- function (x) {
  value <- pMin + (pMax - pMin) * (1/(1 + exp(-((x - center) * -4/width))))
  print(value)
  }

#Calculating datapoints
clinevector <- datapoints(hzar.dataframe$V4)

#Data frame to plot
clineframe <- data.frame(hzar.dataframe$SampleID, hzar.dataframe$V4, clinevector)

#Plotting cline
ggplot(clineframe, aes(y = clinevector, x = hzar.dataframe.V4)) +
  geom_smooth(se = FALSE, method = "gam", colour = "black") +
  geom_point(data = hzar.dataframe, aes(y = GT1, x = V4), size = 3, shape = 21, fill = "white") +
  geom_vline(xintercept = 12.68288, linetype = 1, colour = "red", size = 0.8) +
  geom_vline(xintercept = 12.68288 - 4.15329/2, linetype = 1, colour = "black", size = 0.5) +
  geom_vline(xintercept = 12.68288 + 4.15329/2, linetype = 1, colour = "black", size = 0.5) +
  ggtitle("Probability of ancestry along distance from Gabas") +
  theme(plot.title = element_text(size = 18)) +
  ylab("Probability of ancestry") +
  xlab("Distance from Gabas (km)") +
  theme(text=element_text(size=16,  family="Avenir Regular")) +
  theme(axis.text.x = element_text(size = 10, family = "Avenir LT Std 65 Medium"))

#Optional vertical lines to input into plot script to show NDM expected width for
#9000 generations since contact
#  geom_vline(xintercept = 12.68288 - 7.133989/2, linetype = 5, colour = "deeppink", size = 0.7) +
#  geom_vline(xintercept = 12.68288 + 7.133989/2, linetype = 5, colour = "deeppink", size = 0.7) +
#15 000 generations since contact
#  geom_vline(xintercept = 12.68288 - 9.20994/2, linetype = 5, colour = "blue", size = 0.7) +
#  geom_vline(xintercept = 12.68288 + 9.20994/2, linetype = 5, colour = "blue", size = 0.7) +
