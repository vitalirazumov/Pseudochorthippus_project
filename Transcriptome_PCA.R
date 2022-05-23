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

#Avenir fonts:
#Avenir Regular
#Avenir LT Std 65 Medium
#Avenir LT Std 45 Book
#Avenir LT Std 55 Roman

#Reading in the data
CovarFile <- read.csv(file = "~/Bilsajuttuja/Gradu/Stats/Plots/PCA/98indpv1e-2.covar", header = F, sep = "\t", dec = ".")
CovarFile <- CovarFile[1:98]
SampleIdentities <- read.table(file = "~/Bilsajuttuja/Gradu/Stats/Plots/PCA/plink_all98.clst", sep="\t", header=T); 
# Identities file is in plink cluster format
# Note that plink cluster files are usually tab-separated

# Reassigning MUL414 as SOQ414
SampleIdentities[56,3] <- "SOQ"
SampleIdentities[56,3]

################################
# Principal Component Analysis #
################################

# Parse components to analyze
comp <- as.numeric(strsplit("1-2", "-", fixed=TRUE)[[1]])

# Eigenvalues
eig <- eigen(CovarFile, symm=TRUE);
eig$val <- eig$val/sum(eig$val);
cat(signif(eig$val, digits=3)*100,"\n");

# Plot
PC <- as.data.frame(eig$vectors)

colnames(PC) <- gsub("V", "PC", colnames(PC))
PC$Pop <- factor(SampleIdentities$CLUSTER)
DoubleCheckPop <- PC$Pop
DoubleCheckPop

title <- paste("PC",comp[1]," (",signif(eig$val[comp[1]], digits=3)*100,"%)"," / PC",comp[2]," (",signif(eig$val[comp[2]], digits=3)*100,"%)",sep="",collapse="")

PC$Pop <- factor(PC$Pop, levels = unique(PC$Pop))
PC <- arrange(PC, desc(Pop))

ggplot(data = PC, aes(x = PC1, y = PC2)) +
  geom_point(aes(fill = Pop), size = 5, shape = 21) +
  ggtitle(title) +
  #  scale_colour_manual(values=cbPalette) +
  theme(text=element_text(size=16,  family="Avenir Regular")) +
  theme(axis.text.x = element_text(size = 8, angle = 90, vjust = 0.5, hjust=0.45)) +
  scale_fill_manual(values = c("#30123BFF", "#455BCDFF", "#3E9BFEFF", "#18D6CBFF", "#46F884FF", "#A2FC3CFF", "#E1DD37FF", "#FEA632FF", "#F05B12FF", "#C42503FF", "#7A0403FF"),
                    breaks = c("GAB", "HER", "SOQ", "TOU", "ARA", "POR", "MUL", "FOR", "PAZ", "LAN", "ESC"))

###Plot with sample IDs (Not reassigned)

PC1and2 <- PC[,1:2]
SampleIdentities <- read.table("~/Bilsajuttuja/Gradu/Stats/Plots/NGSadmix/PopSampleID.info",as.is=T)

NamedFrame <- cbind(DoubleCheckPop, SampleIdentities, PC1and2)

ggplot(data=NamedFrame, aes(x=PC1, y=PC2, color="DoubleCheckPop", label = V2)) +
  geom_point(data=NamedFrame, aes(x=PC1, y=PC2, color="DoubleCheckPop")) +
  ggtitle(title) +
  scale_colour_manual(values=cbPalette) +
  geom_text(aes(label = NamedFrame$V2),hjust=0, vjust=0)