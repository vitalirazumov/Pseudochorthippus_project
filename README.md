# Pseudochorthippus_project
Master's thesis project on a Pseudochorthippus parallelus hybrid zone in the pyrenees.

___

## Abstract

Climatic cycles lead to changes in habitat suitability, which in turn can lead to allopatry, i.e. isolation, between populations. Lack of gene flow between allopatric populations causes them to diverge through accumulation of genetic differences that can create incompatibilities between lineages upon secondary contact in the form of lowered survivability or reproduction rate in hybrids. Incompatible genes act as reproductive barriers and keep lineages isolated by selection against hybrids, while gene flow and recombination work as a counterforce to selection promoting admixture. Reproductive barriers like these are most often found inside hybrid zones and are well demonstrated in nature, but the isolating effect of individual genetic incompatibilities on genome-wide gene flow is still an open question. Here we test if selection counteracting gene flow maintains a narrow hybrid zone between two subspecies of the meadow grasshopper Pseudochorthippus parallelus. We targeted 0,01 % of the 13 GB genome, recovering a 29,1 mean coverage per locus per individual in targeted regions, when mapping against a transcriptome. We find that, for the nuclear markers, the hybrid zone is narrower than expected under a neutral scenario of no selection, suggesting that it is maintained by selection against hybrids. We also find significant isolation by distance, suggesting gene flow across the hybrid zone despite selection against hybrids. Different parts of the genome show significant excess or deficit of heterozygotes, suggesting that selection and gene flow are heterogeneous throughout the genome. Combined, our results show that reproductive isolation between recently diverged lineages can evolve quickly despite gene flow in neutral and positively selected sites.

___

<!-- Supplementary materials -->

# Supplementary materials

This is a bioinformatic appendix to describe the programs and codes used in my thesis. R scripts used to plot the results are available on my [GitHub](https://github.com/vitalirazumov/Pseudochorthippus_project).

## SLURM jobs

Slurm is a job scheduler that distributes server resources and prioritizes submitted jobs. This ensures e.g. that the server limits are not exceeded and new jobs don't cut in line. Many servers, including BioHPC used in this thesis, demand the use of SLURM or other workload managers when running large jobs.

To submit a SLURM job you need to create a SLURM script (.sh), which contains settings for SLURM and the job to be run itself.

>``#! /bin/bash``
>
>``#SBATCH --get-user-env``\
>``#SBATCH --mail-user=example.email@mailbox.fi``\
>``#SBATCH --clusters=example_cluster``\
>``#SBATCH --partition=example_partition``\
>``#SBATCH --cpus-per-task=n_of_cpus``\
>``#SBATCH --mem-per-cpu=n_of_mb``\
>``#SBATCH --time=hh:mm:ss``\
>``#SBATCH --mail-type=ALL``\
>``#SBATCH -o name_for_output_logfile.out``\
>``#SBATCH -J job_name``
>
>``STARTTIME=$(date +%s)``
>
>``echo "Job name: $SLURM_JOB_NAME, job ID: $SLURM_JOB_ID"``
>
>``echo " Job started at $(date)."``
>
>``module load example_module # Load any modules the job might require``\
>``source activate example_env # Enter the environment if needed``
>
>``srun write_the_job_and_commands_here_as_you_would_normally``
>
>``ENDTIME=$(date +%s)``
>
>``TIMESPEND=$(($ENDTIME - $STARTTIME))``
>
>``((sec=TIMESPEND%60, TIMESPEND/=60, min=TIMESPEND%60, hrs=TIMESPEND/60))``
>
>``timestamp=$(printf "%d:%02d:%02d" $hrs $min $sec)``
>
>``echo "Job ended at $(date). Took $timestamp hours:minutes:seconds to complete."``

Submit the job to using the following command:
>``sbatch example.sh``

To see the status of your job use:
>``squeue -M example_cluster -l``

To cancel your job use:
>``scancel --cluster=example_cluster $JOBID``

Full documentation of SLURM is found at https://slurm.schedmd.com/
___

## Paleomix

Paleomix is a set of pipelines meant to process sequencing data. In short, the BAM pipeline used here cleans the sequencing data for further downstream analyses and saves it in .bam files. The pipeline consists of two parts: first, trimming and filtering, and second, mapping. The pipeline settings are filled into a "makefile" (.yaml), which is then used to execute the pipeline.

A makefile can be generated using the following command:
>``paleomix bam makefile > makefile.yaml``

The BAM pipeline allows to choose between two short read aligners: BWA and Bowtie2. We chose to use BWA with following settings:

>``# Settings for aligners supported by the pipeline``\
>``Aligners:``\
> &nbsp; ``# Choice of aligner software to use, either "BWA" or "Bowtie2"``\
> &nbsp; ``Program: BWA``
>
> &nbsp; ``# Settings for mappings performed using BWA``\
> &nbsp; ``BWA:``\
> &nbsp; &nbsp; ``# One of "backtrack", "bwasw", or "mem"; see the BWA documentation``\
> &nbsp; &nbsp; ``# for a description of each algorithm (defaults to 'backtrack')``\
> &nbsp; &nbsp; ``Algorithm: mem``\
> &nbsp; &nbsp; ``# Filter aligned reads with a mapping quality (Phred) below this value``\
> &nbsp; &nbsp; ``MinQuality: 30``\
> &nbsp; &nbsp; ``# Filter reads that did not map to the reference sequence``\
> &nbsp; &nbsp; ``FilterUnmappedReads: yes``\
> &nbsp; &nbsp; ``# May be disabled ("no") for aDNA alignments with the 'aln' algorithm.``\
> &nbsp; &nbsp; ``# Post-mortem damage localizes to the seed region, which BWA expects to``\
> &nbsp; &nbsp; ``# have few errors (sets "-l"). See http://pmid.us/22574660``
> &nbsp; &nbsp; ``UseSeed: yes``\
> &nbsp; &nbsp; ``# Additional command-line options may be specified below. For 'backtrack' these``\
> &nbsp; &nbsp; ``# are applied to the "bwa aln". See Bowtie2 for more examples.``\
>``#`` &nbsp; &nbsp; ``-n: 0.04``

Other settings were kept as default.

Path to reference was set as below. When using de novo reference path was simply changed to that of the de novo reference.

>``# Map of prefixes by name, each having a Path, which specifies the location of the``\
>``# BWA/Bowtie2 index, and optional regions for which additional statistics are produced.``\
>``Prefixes:``\
> &nbsp; ``# Replace 'NAME_OF_PREFIX' with name of the prefix; this name is used in summary``\
> &nbsp; ``# statistics and as part of output filenames.``\
> &nbsp; ``FullPaleoPipeline:``\
> &nbsp; &nbsp; ``# Replace 'PATH_TO_PREFIX' with the path to .fasta file containing the references``\
> &nbsp; &nbsp; ``# against which reads are to be mapped. Using the same name as filename is strongly``\
> &nbsp; &nbsp; ``# recommended (e.g. /path/to/Human_g1k_v37.fasta should be named 'Human_g1k_v37').``\
> &nbsp; &nbsp; ``Path: /dss/dsslegfs01/pr53da/pr53da-dss-0029/GrassWolbGenRef/grasshopperWolbRef.fasta``

Path to .bam files was set as below. When using de novo reference path was simply changed to that of the de novo .bam files.

>``# Mapping targets are specified using the following structure. Replace 'NAME_OF_TARGET'``\
>``# with the desired prefix for filenames.``\
>``GAB512:``\
> &nbsp; ``# Replace 'NAME_OF_SAMPLE' with the name of this sample.``\
> &nbsp; &nbsp; ``# Replace 'NAME_OF_LIBRARY' with the name of this sample.``\
> &nbsp; &nbsp; &nbsp; ``# Replace 'NAME_OF_LANE' with the lane name (e.g. the barcode) and replace``\
> &nbsp; &nbsp; &nbsp; ``# 'PATH_WITH_WILDCARDS' with the path to the FASTQ files to be trimmed and mapped``\
> &nbsp; &nbsp; &nbsp; ``# for this lane (may include wildcards).``\
> &nbsp; ``GAB512:``\
> &nbsp; &nbsp; ``GAB512:``\
> &nbsp; &nbsp; &nbsp; ``GAB512: /dss/dsslegfs01/pr53da/pr53da-dss-0029/raw_data/capture_RapidGenomics/RapidGenomics_F193_LMU_158401_P001_WA01_i5-533_i7-*_S347_L001_R{Pair}_001.fastq.gz``\
>``GAB513:``\
> &nbsp; ``GAB513:``\
> &nbsp; &nbsp; ``GAB513:``
> &nbsp; &nbsp; &nbsp; ``GAB513: /dss/dsslegfs01/pr53da/pr53da-dss-0029/raw_data/capture_RapidGenomics/RapidGenomics_F193_LMU_158401_P001_WA02_i5-533_i7-*_S348_L001_R{Pair}_001``\
>``.``\
>``.``\
>``.``

Once the makefile is filled the pipeline can be run with following command:
>``paleomix bam run makefile.yaml``

Detailed information on makefile composition and Paleomix documentation is available at https://paleomix.readthedocs.io/en/stable/index.html
___

## bedtools

bedtools is a useful program to edit and transform your date in many ways. We used it to merge our .bam files, handle base pair coordinates, and calculate coverage.

Bam files can be merged using bedtools as follows:

>``~/bedtools2/bin/bedtools \``\
>``merge \ # Command to merge files``\
>``-i /dss/dsslegfs01/pr53da/pr53da-dss-0029/DeNovoRef/1.Paleomix/BamFiles/*.bam \ # Input files``\
>``> /dss/dsslegfs01/pr53da/pr53da-dss-0029/DeNovoRef/Output_Folder/Output_File # Path to output file``

To calculate coverage you need to have coordinates for the regions of interest in .bed files in a correct form. In our case there were several steps to transform the hits against references in .bam files into coordinates usable to calculate coverage:

First, each .bam file needs to be transformed into a .bed coordinate file. This was done as follows:

>``for i in /dss/dsslegfs01/pr53da/pr53da-dss-0029/DeNovoRef/1.Paleomix/BamFiles/*.bam``\
>``do # Set i variable and open for-loop.``
>
>``srun ~/bedtools2/bin/bedtools \ # When using a for-loop in SLURM the "srun" is inside the loop.``\
>``bamtobed \ # Command to transfer the .bam files to .bed files.``\
>``-i "$i" \ # Input files as a variable in for-loop``\
>``> "$i.bed" # Output file.``\
>
>``done # Close for-loop.``

When using for-loop it's easiest to use the same path for output files. Otherwise setting the path can get complicated and you can even overwrite input files if you're not careful. The $i holds the whole path, not only the file. If you add a path after the ">" the two paths will combine.(I.e. /dss/dsslegfs01/pr53da/BamFiles//dss/dsslegfs01/pr53da/BamFiles/).

Next the individual .bed files need to be compiled into one file. This can be easily done using a deafult Unix command ``cat`` as follows:

>``cat /dss/dsslegfs01/pr53da/pr53da-dss-0029/DeNovoRef/1.Paleomix/BamFiles/*.bed \``\
>``>> /dss/dsslegfs01/pr53da/pr53da-dss-0029/DeNovoRef/Coverage_Folder/CompiledBeds.bed``\
>``# Be sure to use ">>" instead of ">". The former saves the new data at the end of the output file, while the latter replaces the previous data with the new data.``

This results in a file which contains hits against the reference from every sample all in one file but unordered. When calculating coverage the coordinates must be in an aplhabetical order. This can be acheived using the sorting function in bedtools:

>``~/bedtools2/bin/bedtools \``\
>``sort \ # Command to sort file contents alphabetically.``\
>``-i /dss/dsslegfs01/pr53da/pr53da-dss-0029/DeNovoRef/Coverage_Folder/CompiledBeds.bed \``\
>``> CompiledSortedBeds.bed``

Now the ``CompiledSortedBeds.bed`` file contains coordinates of regions that have mapped against a reference from each individual in alphabetical order, but these coordinates are in short chuncks. The overlapping regions have to be collapsed, which can be done using the same ``merge`` function as when merging .bam files:

>``~/bedtools2/bin/bedtools \``\
>``merge \``\
>``-i /dss/dsslegfs01/pr53da/pr53da-dss-0029/DeNovoRef/Coverage_Folder/CompiledSortedBeds.bed \``\
>``> CompiledSortedMergedBeds.bed``

This file can now be used to calculate coverages for regions specified by each line in the .bed file. When calculating coverage in baited regions for transcriptome
___

## ANGSD

ANGSD, Analysis of Next Generation Sequencing Data, is a software that can perform various downstream analyses and calculate useful population statistics. ANGSD is very versatile and was used in most of our analyses. As input it most commonly takes .bam files, provided in a list containing paths to the files of interest.

Below, I will first introduce most common ANGSD commands, and later show jobs used to run each analysis.

### Common ANGSD options

|Option   | Description  |
|----------|-----------|
|``-b ~/bamlist.txt``    | Path to the infile list (Different for the de novo and transcriptome .bam files).     |
|``-out ~/output.file``    | Set path and name for the output file.     |
|``-ref ~/reference.fasta``    | Path to the reference file used.     |
|``-nThreads 4``    | Set number of threads allocated for the job.     |
|``-r chr1:``   | Determine the region analysed (Used only with transcriptome reference).     |
|``-rf ~/DeNovoChromosomes.txt``   | Path to a file containing chromosome coordinates (Used only with de novo reference).     |
|``-minMapQ 15``    | Minimum mapQ quality.     |
|``-minQ 20``    | Minimum base quality score.      |
|``-minInd 59``    | Remove stites appearing in less than set number of individuals (60 %).     |
|``-setMaxDepth 16146``    | Remove sites with coverage above set threshold (1 mean + 1 SD, 13556 for de novo reference).     |
|``-SNP_pval 1e-2``    | Filter out sites above set p-value threshold.     |
|``-only_proper_pairs 0``    | Include unpaired reads.     |
|``-baq 1``    | Perform BAQ analysis in SAMtools.     |
|``-remove_bads 1``    | Filter sites containing SAMtools flags greater than 255 (poor alignments, duplicate reads, etc.).     |
|``-C 50``    | Reduce the mapping quality score of a read based on the probability of sites being misaligned as per BAQ. Reduce reliance on reads with poor mapping quality.     |
|``-uniqueOnly 1``    | Remove hits with multiple best hits.     |
|``-GL 1``    | Estimate genotype likelhoods from the mapped reads.     |
|``-doMajorMinor 1``    | Determine major and minor alleles based on genotype likelihoods.     |
|``-doMaf 1``    | Obtain major and minor allele frequencies assuming known major and known minor alleles.     |
|``-doCounts 1``    | Calculate frequency of different bases.      |

### .beagle file

The downstream analyses performed in ANGSD NGSadmix use .bealge files that contain genotype likelihoods as input. They can be created in ANGSD using the .bam files as an input. To create the files, three new commands are needed:

|Option   | Description  |
|----------|-----------|
|``-doGLF 2``    | Output the log genotype likelihoods to a .beagle file.      |
|``-doGeno 32``    | Dump the binary posterior for all samples, encoded as 3*nind double.     |
|``-doPost 2``    | Estimate the posterior genotype probability assuming a uniform prior.     |

The command used to create a .beagle file for the trenscriptome analyses looked as follows (for de novo change necessary options):

>``angsd -b /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/bamlist98.txt -ref /dss/dsslegfs01/pr53da/pr53da-dss-0029/GrassWolbGenRef/grasshopperWolbRef.fasta -GL 1 -doGlf 2 -doMajorMinor 1 -doMaf 1 -r chr1: -SNP_pval 1e-2 -nThreads 4 -baq 1 -remove_bads 1 -uniqueOnly 1 -C 50 -minMapQ 15 -only_proper_pairs 0 -minQ 20 -doCounts 1 -doPost 2 -doGeno 32 -minInd 59 -setMaxDepth 16146 -out 01.output/noSites_pval1e-2.beagle``

### Site Frequency Spectrum

In order to choose the correct p-value filter to be used in further analyses we created several site frequency spectra (SFS) using varying p-values. The SFSs are created in two steps using ANGSD and a program called RealSFS. First, the site allele frequency likelihoods are calculated and put in a .saf file in ANGSD, and then the SFS is estimated in RealSFS.

The first part contains three additional options:

|Option   | Description  |
|----------|-----------|
|``-anc ~/pathto/anc.file``    | File used as an ancestral reference (same as reference, except when used with -doHWE).     |
|``-doSaf 1``    | Calculate the site allele frequency likelihood based on individual genotype likelihoods assuming HWE.     |
|``-fold 1``    | Estimate the folded SFS (used when no ancestral reference available by using same reference in -anc).     |

The command used to create the .saf files looks as follows (change ``-SNP_pval`` to alter the p-value):

>``angsd -b /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSD/bamlist98.txt -ref /dss/dsslegfs01/pr53da/pr53da-dss-0029/GrassWolbGenRef/grasshopperWolbRef.fasta -anc /dss/dsslegfs01/pr53da/pr53da-dss-0029/GrassWolbGenRef/grasshopperWolbRef.fasta -doSaf 1 -doCounts 1 -doMaf 1 -doMajorMinor 1 -GL 1 -fold 1 -r chr1: -minInd 59 -minQ 20 -minMapQ 15 -only_proper_pairs 0 -remove_bads 1 -uniqueOnly 1 -C 50 -baq 1 -setMaxDepth 16146 -nThreads 4 -SNP_pval 1e-6 -out 01.output/SAFsiteless_98ind_pval1e-6``

Next, RealSFS was used to create .sfs.em files containing the SFSs. Following commands were used:

|Option   | Description  |
|----------|-----------|
|``-r chr1``    | Determine the region analysed (Used only with transcriptome reference).     |
|``-P 4``    | Number of threads used for the job.     |

The command used looked as follows (input and output file was changed according to the p-value used in first stage):

>``realSFS /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/01.output/SAFsiteless_98ind_pval1e-6.saf.idx -r chr1 -P 4 > /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/01.output/SFS/SAFsiteless_98ind_pval1e-6.sfs.em``

### Principal Component Analysis

To run a PCA the .geno file created alongside the .beagle file is used. First, the file needs to be unzipped using using the ``gzip -d file.geno`` command. Next, you will need the number of variable sites to run the job. This can be obtained using ``zcat ~/nameofmafsfile.mafs.gz | tail -n+2 | wc -l``. Finally using ngsCovar which is part of ANGSD you create a covariance table containing data necessary to plot a PCA. This uses following commands:

|Option   | Description  |
|----------|-----------|
|``-probfile ~/inputfile.geno``    | Path to .geno file used.     |
|``-outfile ~/output.covar``   | Path to and name of output file.     |
|``-nind 98``    | Number of individuals.     |
|``-nsites 421863``   | Number of variable sites.     |
|``-call 0``    | Call genotypes based on the maximum posterior probability.     |
|``-norm 0``    | Normalization procedure: 0 for no normalization (recommended if no SNP calling was performed).     |

Command used looked as follows:

>``/dss/dsshome1/lxc0C/ra73fig/ngsTools/ngsPopGen/ngsCovar -probfile /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/beagle/01.output/noSites_pval1e-2.beagle.geno -outfile /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/PCA/98indpv1e-2.covar -nind 98 -nsites 421863 -call 0 -norm 0``

### Fst

In order to calculate pairwise Fst for each locality, a separate bamlist.txt had to be created for each location. The Fst values are calculated in four parts:

1. Creating a .saf file for each population in ANGSD.
2. Calculating 2D SFS in RealSFS.
3. Calculating binary Fst files using outputs of part 1. and 2. in RealSFS
4. Calculating Fst values in RealSFS.

Command for the first part looked as follows:

>``for i in {1..11}``
>``do``
>
>``srun angsd -b /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Fst/PopBamlists/${i}Bamlist.txt -ref /dss/dsslegfs01/pr53da/pr53da-dss-0029/GrassWolbGenRef/grasshopperWolbRef.fasta -anc /dss/dsslegfs01/pr53da/pr53da-dss-0029/GrassWolbGenRef/grasshopperWolbRef.fasta -doSaf 1 -GL 1 -doCounts 1 -r chr1: -setMaxDepth 1490 -minInd 4 -minQ 20 -minMapQ 15 -only_proper_pairs 0 -remove_bads 1 -uniqueOnly 1 -C 50 -baq 1 -nThreads 4 -out /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Fst/SafFiles/01.output/Test``
>
>``Pop${i}_FstSaf``
>
>``done``

Command for the second part looked as follows:

>``for i in {1..10}``\
>``do``\
>&nbsp;``for y in {2..11}``\
>&nbsp;``do``
>
>&nbsp;``srun realSFS /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Fst/SafFiles/01.output/Pop${i}_FstSaf.saf.idx /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Fst/SafFiles/01.output/Pop${y}_FstSaf.saf.idx -r chr1 -P 4``\
>&nbsp;``> Outputs/2DSFS_Pop${i}_Pop${y}.ml``
>
>&nbsp;``done``\
>``done``

Command for the third part looked as follows:

>``for i in {1..10}``\
>``do``\
>&nbsp;``for y in {2..11}``\
>&nbsp;``do``
>
>&nbsp;``srun realSFS fst index /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Fst/SafFiles/01.output/Pop${i}_FstSaf.saf.idx /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Fst/SafFiles/01.output/Pop${y}_FstSaf.saf.idx -sfs /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Fst/2dSFS/Outputs/2DSFS_Pop${i}_Pop${y}.ml -r chr1 -P 4 -fstout Outputs/Pop${i}_Pop${y}``
>
>&nbsp;``done``\
>``done``

Command for the fourth part looked as follows:

>``for i in {1..10}``\
>``do``\
>&nbsp;``for y in {2..11}``\
>&nbsp;``do``
>
>&nbsp;``x=$(srun realSFS fst stats /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Fst/PreparationForWindowAna/Outputs/Pop${i}_Pop${y}.fst.idx)``
>
>&nbsp;``echo -e "Pop${i} vs. Pop${y}\nUnweighted	Weighted\n${x}" >> Outputs/AllPopsCompiled_GlobEst.txt``
>
>&nbsp;``done``\
>``done``

### Heterozygosity

To calculate perindividual heterozygosity we used the same method as for the SFS to calculate a spectrum for each individual and extracted the fraction of polymorphic sites. For this we first created a bamlist for each individual separately.

For the .saf file creation the following code was used:

>``for i in {1..98}``\
>``do``
>
>``srun angsd -b /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Heterozygosity/PerIndividual/SafFiles/Bamlists/${i}Bamlist.txt -ref /dss/dsslegfs01/pr53da/pr53da-dss-0029/GrassWolbGenRef/grasshopperWolbRef.fasta -anc /dss/dsslegfs01/pr53da/pr53da-dss-0029/GrassWolbGenRef/grasshopperWolbRef.fasta -doSaf 1 -doCounts 1 -r chr1: -setMaxDepth 166 -minQ 20 -minMapQ 15 -GL 1 -only_proper_pairs 0 -remove_bads 1 -uniqueOnly 1 -C 50 -baq 1 -nThreads 160 -out /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Heterozygosity/PerIndividual/SafFiles/Outputs/Ind${i}_HZSaf``
>
>``done``

For the RealSFS part the following code was used:

>``for i in {1..98}``\
>``do``
>
>``srun realSFS /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Heterozygosity/PerIndividual/SafFiles/Outputs/Ind${i}_HZSaf.saf.idx -r chr1 -P 160 \``\
>``> Outputs/Ind${i}_HZSrealSFS.ml``
>
>``done``

### Inbreeding Coefficient

To scan the sequences for variation in heterozygosity per site per locality, we calculated the inbreeding coefficient using the ``-doHWE`` command in ANGSD. This command calculates the deviation from Hardy-Weinberg Equilibrium per site and presents it as an F-value that shows the deviation and it's direction as a value between -1 and 1. As the job was was run per locality, per locality bamlists were again used for the analysis. For this analysis we used an ancestral state reference merged from Gabas individuals, as the transcriptome reference consists of a mix of sequences between both subspecies. For the The only new command included in the job is the ``-doHWE`` itself, which runs the HWE analysis.

Code used for the analysis looks as follows:

>``for i in {1..11}``\
>``do``
>
>``srun angsd -b /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/HWE/Bamlists/${i}Bamlist.txt \``\
>``-ref /dss/dsslegfs01/pr53da/pr53da-dss-0029/GrassWolbGenRef/grasshopperWolbRef.fasta \``\
>``-anc /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/Heterozygosity/CreatingNewAnc/MergingBams/MergedGABFasta.fa \``\
>``-doHWE 1 -GL 1 -domajorminor 1 -doMaf 1 -doCounts 1 -r chr1: -setMaxDepth 1490 -minInd 4 -minQ 20 \``\
>``-minMapQ 15 -only_proper_pairs 0 -remove_bads 1 -uniqueOnly 1 -C 50 -baq 1 -SNP_pval 1e-2 -nThreads 80 \``\
>``-out /dss/dsslegfs01/pr53da/pr53da-dss-0029/ANGSDohneSites/HWE/NewAncestralOutputs/Pop${i}_HWE_newANC``
>
>``done``

___

## Captus

To include the regions omitted by mapping against a transcriptome we assembled a de novo reference using a program called Captus, build by Edgardo Ortiz. This program consists of four main functions: ``clean``, ``assemble``, ``extract`` and ``align``. The first function, ``clean``, trims and filters sequences, doing essentially the same job as PALEOMIX. Second, ``assemble``, performs the assembly and third, ``extract``, recovers the targeted markers. The final function, ``align``, aligns the extracted markers, but was not used for our assembly.

The commands used by me in the assembly steps are explained below.
A full documentation of Captus is availeble on its GitHub page, https://github.com/edgardomortiz/Captus.

|Option   | Description  |
|----------|-----------|
|``-r``    | Inputfile folder containing the raw .fastq files.     |
|``-o``    | Directory for output files.     |
|``--threads 64``    | Number of threads allocated for the job.     |
|``--ram 128``    | Ram memory allocated for the job.     |
|``--cluster_leftovers``    | Clusters contigs not mapped against reference.     |
|``--cl_min_samples 49``    | Excludes contigs present in less than given number of samples.     |
|``--dna_min_identity 85``    | Excludes contigs with less than given percent of identity to the reference.     |

The ``clean`` function was run with default options as recommended by Edgardo with the following code:

>``captus_assembly clean -r /dss/dsslegfs01/pr53da/pr53da-dss-0029/RawDataRenamed \``\
>``-o /dss/dsslegfs01/pr53da/pr53da-dss-0029/CaptusDeNovo \``\
>``--threads 64 --ram 128``

The ``assemble`` function was run with default options as recommended by Edgardo with the following code:

>``captus_assembly assemble -r /dss/dsslegfs01/pr53da/pr53da-dss-0029/CaptusDeNovo/Clean \``\
>``-o /dss/dsslegfs01/pr53da/pr53da-dss-0029/CaptusDeNovo/Assemble \``\
>``--threads 64 --ram 128``

The ``extract`` function was run with removal of contigs present in less than 49 samples and less than 85 % identity to the reference with the following code:

>``captus_assembly extract -a /dss/dsslegfs01/pr53da/pr53da-dss-0029/CaptusDeNovo/Assemble \``\
>``-o /dss/dsslegfs01/pr53da/pr53da-dss-0029/CaptusDeNovo/Extract_without_reference \``\
>``--cluster_leftovers --threads 64 --ram 128 --cl_min_samples 49 --dna_min_identity 85``

The remaining steps of assembly were performed by Edgardo Ortiz according to his documentation in ``make_denovo_reference_Ortiz.html`` available on my [GitHub](https://github.com/vitalirazumov/Pseudochorthippus_project).
