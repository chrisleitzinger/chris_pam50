# 
# rownames(Array50)=="PR"
# Array50$Gene_involved
# 
# # set <- Array50$Gene_involved == "proliferation|estrogen-related|HER2-related|invasion-related|angiogenesis"
# 
# 
# # Array50$Gene_involved <- ifelse(set, yes = yes, no = "nopro")
# 
# 
# 
# Array50$Gene_involved
# 
# Array50[1:2,498:500]
# head(Array50)

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







