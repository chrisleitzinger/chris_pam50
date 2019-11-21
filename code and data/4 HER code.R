Array50[1:3, 1:6]
# A tibble: 4 x 6
# `TCGA-2A-A8VL-0~ `TCGA-2A-A8VO-0~ `TCGA-2A-A8VT-0~ `TCGA-2A-A8VV-0~ `TCGA-2A-A8VX-0~
#   <dbl>            <dbl>            <dbl>            <dbl>            <dbl>
#   1             7.54             7.69             8.16             8.22             8.15
# 2             4.17             5.01             6.30             5.54             7.02
# 3            10.8             10.9             10.4             10.7             10.7 

rownames(Array50)
rownames(Array50)[17]   #ER
rownames(Array50)[16]   #HER
###################### PLOT
hist((Array50)[17,2:5])
str((Array50)[17,2:ncol(Array50)])
boxplot(Array50[17,2:100])
plot(Array50[17,2:10],Array50[16,2:10])

hist(Array50$`TCGA-2A-A8VO-01`, freq = F)
barplot(Array50$`TCGA-2A-A8VO-01`)

pairs(Array50[16:17, 2:10])


library(lattice)
bwplot(Array50[17,2:10] ~ Array50[16,2:10])
# Error: Must use a vector in `[`, not an object of class matrix.

bwplot(Array50$`TCGA-2A-A8VO-01` ~ Array50$`TCGA-2A-A8VT-01`)
dotplot(Array50$`TCGA-2A-A8VO-01` ~ Array50$`TCGA-2A-A8VT-01`)
xyplot(Array50$`TCGA-2A-A8VO-01` ~ Array50$`TCGA-2A-A8VT-01`)
xyplot(Array50$`TCGA-2A-A8VO-01`[16:17] ~ Array50$`TCGA-2A-A8VT-01`[16:17])



# Gene-by-gene analysis revealed a positive correlation between TTR and the magnitude of change 
# of genes implicated in cell proliferation (CEP55: corr = 0.244, P = 0.024), mitogenesis, and 
# differentiation biological process (FGFR4: corr = 0.211, P = 0.044). In contrast, a negative 
# correlation was observed with genes that participate in cell-to-cell adhesion (CLDN4: corr = −0.207, 
#  P = 0.027; F11R: corr = −0.237, P = 0.01), regulation of DNA damage repair (RAD17: corr: −0.226, 
# P = 0.017), tumor suppression (GRHL2: corr = −0.186, P = 0.05), mammary gland development 
#(PGR: corr = −0.203, P = 0.045), and that attenuate cell migration (ESRP1: corr = −0.252, P = 0.006).

# response to hormone stimulus (e.g., BCL2 and PGR; Fig. 2), differentiation (e.g., GATA3) 
# and chromatin regulation (e.g., CXXC5).



##############################################################################################
# Do we need to reassign calls witout HER2
head(calls_array50)
colnames(calls_array50)
rownames(calls_array50)

# want to see the gene in her compare by group of calls
# access columns
calls_array50[rownames == "Cellular_process"]

calls_array50[1,] == "HER2-related" 


DF <- calls_array50[1,] == "HER2-related" 
DF

########################################################################







