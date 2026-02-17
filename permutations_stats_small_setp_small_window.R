#observed vs expected generic permutation R script,from Kiaser area ()
#(/exports/igmm/eddie/semple-lab/vkaiser2/ATAC-Seq_analysis/sperm/Circular_Perms_H7.3_10.2/generic.R)


#!/R/

library('BiocManager', lib="/exports/igmm/eddie/semple-lab/stimmins/R")
library('regioneR', lib="/exports/igmm/eddie/semple-lab/stimmins/R")
library('genomation', lib="/exports/igmm/eddie/semple-lab/stimmins/R")
library('BSgenome', lib="/exports/igmm/eddie/semple-lab/stimmins/R")
library("BSgenome.Hsapiens.UCSC.hg38.masked", lib="/exports/igmm/eddie/semple-lab/stimmins/R")


options(scipen=999)
cli <- commandArgs(trailingOnly = TRUE)
args <- strsplit(cli, "=", fixed = TRUE)
vcf<- paste(args[1]) #full path to vcf
name<-args[2] #name for test
print(vcf)
atac_input<- paste(args[3]) #full path to footprint/atac peak bed/narrowPeak file
atac_granges <- readBed(atac_input, remove.unusual=TRUE)
vcf_granges<- readBed(vcf, remove.unusual=TRUE)

print(head(atac_input))
print(head(atac_granges))
print(vcf)
print(head(vcf_granges))

#use masked version of hg38
hg38_masked = getBSgenome("BSgenome.Hsapiens.UCSC.hg38.masked")

#do permutation test
pt_name<- paste(name, "pt", sep = "_")
pt<- permTest(A = atac_granges, B = vcf_granges, ntimes=10000, randomize.function=circularRandomizeRegions,
              evaluate.function=numOverlaps, count.once=TRUE,
              genome=hg38_masked, force.parallel = FALSE, mc.set.seed=FALSE) #10000 used for circular permutations in Kaiser 2021, maybe do less if non circular permutations
print(c(pt_name, pt))
png(file=paste(pt_name, ".png", sep="_"))
plot(pt)
dev.off()




#sink(args[4])
print(c(pt$numOverlaps$observed, median(pt$numOverlaps$permuted), pt$numOverlaps$observed/median(pt$numOverlaps$permuted), pt$numOverlaps$pval , pt$numOverlaps$zscore, pt$numOverlaps$ntimes ))
#sink()

list_values<- c(pt$numOverlaps$observed, median(pt$numOverlaps$permuted), pt$numOverlaps$observed/median(pt$numOverlaps$permuted), pt$numOverlaps$pval , pt$numOverlaps$zscore, pt$numOverlaps$ntimes )
df_values <- data.frame(list_values)

write.csv(df_values, file=paste0(args[2], '_stats_output.csv'))

lz_test_name<- paste(pt_name, "lz", sep = "_")
lz_test <- localZScore(A = atac_granges, B = vcf_granges, pt = pt, window = 1000, step = 10)
print(c(paste(pt_name, "lz", sep = "_"), lz_test, lz_test_name))
lz_test_name_plot<- paste(lz_test_name, '_plot.png')
png(file=lz_test_name_plot)
plot(lz_test)
dev.off()

