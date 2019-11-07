##################################
# import library
##################################

library(readr)


##################################
# STEP1
# import data
##################################

Patient_Preclin <-
  read_delim("data/data_clinical.txt", delim = "\t", skip = 5)

Patient_Post <-
  read_delim("data/data_bcr_clinical_data_patient.txt",
             delim = "\t",
             skip = 4)

pam50_score <-
  read_delim("data/tcgaPAM50_pam50scores.txt", delim = "\t")

Array50 <- read_delim("data/tcgaPAM50.txt", delim = "\t")

##################################
# MERGE PRE AND POST DATA
##################################

# other way = merge.data.frame(Patient_Preclin, Patient_Post, by.x = 2, by.y = 2)
PandPClin <- merge.data.frame(
  Patient_Preclin[, c(1:3, 14, 85)],
  Patient_Post[, c(1:2, 17:18, 32, 37, 41:43, 67, 70, 72)],
  by.x = "PATIENT_ID",
  by.y = "PATIENT_ID",
  all.x = TRUE,
  all.y = TRUE
)


##################################
# Data Prep
##################################
PandPClin$"PATIENT_ID"
PandPClin$PATIENT_ID <-
  substr(PandPClin$PATIENT_ID, start = 6, stop = 12)


# Prep pam50_score
colnames(pam50_score) [1] <- "Patient_ID"
pam50_score$Patient_ID <-
  substr(pam50_score$Patient_ID, start = 6, stop = 12)


# reassign Calls to only normal, basal, luminal A/B
pam50_score$Call2 <-
  colnames(pam50_score[, c(2, 4:6)])[apply(pam50_score[, c(2, 4:6)], 1, which.max)]

##################################
# Prep array50
rownames(Array50) <- Array50$Hugo_Symbol
Array50$Gene_involved <- rownames(Array50)
# Add column for gene role

# "ACTR3B"     "ANLN"       "BAG1"       "BCL2"       "BIRC5"      "BLVRA"      "CCNB1"      "CCNE1"     
# [9] "CDC20"      "CDC6"       "CDH3"       "CENPF"      "CEP55"      "CXXC5"      "EGFR"       "ERBB2"     
# [17] "ESR1"       "EXO1"       "FGFR4"      "FOXA1"      "FOXC1"      "GPR160"     "GRB7"       "KIF2C"     
# [25] "KRT14"      "KRT17"      "KRT5"       "MAPT"       "MDM2"       "MELK"       "MIA"        "MKI67"     
# [33] "MLPH"       "MMP11"      "MYBL2"      "MYC"        "NAT1"       "KNTC2"      "CDCA1"      "ORC6L"     
# [41] "PGR"        "PHGDH"      "PTTG1"      "RRM2"       "SFRP1"      "SLC39A6"    "TMEM45B"    "TYMS"      
# [49] "UBE2C"      "UBE2T"      "Patient_ID"

Array50$Gene_involved

# Prosigna 5 reference genes (ACTB, GAPDH, RPLPO, GUS, TFRC)
# Gene identified to be involved in proliferation
# BIRC5, CCNB, CDC20, NUF2=CDCA1, CEP55, KNTC2, MKI67, PTTG1, RRM2, TYMS, UBEC2
# other proliferation-related genes (Ki67,STK15, Survivin, 7- CCNB1, 35-MYBL2), 
Array50$Gene_involved[c(5,7,9,39,13,38,32,43,44,48,49)] <- "proliferation"

# estrogen-related genes (ER(17-ESR1),42-PGR, 4-BCL2, SCUBE2)
Array50$Gene_involved[c(4,17,41)] <- "estrogen-related"

# HER2-related genes (HER2(16-ERBB2), 23-GRB7)
Array50$Gene_involved[c(16,23)] <- "HER2-related"

# invasion-related genes (34-MMP11, CTSL2) and 3 others (GSTM1, CD68, BAG1) 
Array50$Gene_involved[c(34)] <- "invasion-related"

# angiogenesis FGFR4
Array50$Gene_involved[c(19)] <- "angiogenesis"

rownames(Array50)=="PR"
Array50$Gene_involved
 
# set <- Array50$Gene_involved == "proliferation|estrogen-related|HER2-related|invasion-related|angiogenesis"


# Array50$Gene_involved <- ifelse(set, yes = yes, no = "nopro")



Array50$Gene_involved

Array50[1:2,498:500]
head(Array50)

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
array50 <- as.data.frame(Array50[, 2:ncol(Array50)])

t_array50 <- as.data.frame(t(array50))
colnames(t_array50) <- rownames(Array50)


t_array50$Patient_ID <-
  rownames(t_array50)
t_array50$Patient_ID <-
  substr(t_array50$Patient_ID,
         start = 6,
         stop = 12)

##################################
# MERGING

# merge pam50 calls with clinical info
Dat_Patient_Calls <-
  merge.data.frame(
    PandPClin,
    pam50_score[, c(1, 16)],
    by.x = "PATIENT_ID",
    by.y = "Patient_ID",
    all.x = TRUE,
    all.y = TRUE
  )

# merge
dfpatient_A50 <-
  merge.data.frame(
    Dat_Patient_Calls,
    t_array50
    ,
    by.x = "PATIENT_ID",
    by.y = "Patient_ID",
    all.x = TRUE,
    all.y = TRUE
  )
colnames(dfpatient_A50)
summary(dfpatient_A50)
