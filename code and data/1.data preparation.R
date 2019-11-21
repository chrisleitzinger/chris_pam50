##################################
# import library
##################################
#install.packages("readr")
library(readr)


##################################
# STEP1
# import data
##################################
# data sample after resection
Sample_data <-
  read_delim("data/data_clinical.txt", delim = "\t", skip = 5)
# data patient after resection
Patient_data <-
  read_delim("data/data_bcr_clinical_data_patient.txt",
             delim = "\t",
             skip = 4)
# score evaluation and call
pam50_score <-
  read_delim("data/tcgaPAM50_pam50scores.txt", delim = "\t")
# microarray data
Array50 <- read_delim("data/tcgaPAM50.txt", delim = "\t")

##################################
# MERGE PRE AND POST DATA
##################################

# other way = merge.data.frame(Sample_data, Patient_data, by.x = 2, by.y = 2)
dataSandP <- merge.data.frame(
  Sample_data[, c(2:3, 81, 85)],
  Patient_data[, c(1:2, 17:18, 32, 37, 41:43, 67, 70, 72)],
  by.x = "PATIENT_ID",
  by.y = "PATIENT_ID",
  all.x = TRUE,
  all.y = TRUE
)


##################################
# Data Prep
##################################
dataSandP$"PATIENT_ID"
dataSandP$PATIENT_ID <-
  substr(dataSandP$PATIENT_ID, start = 6, stop = 12)

dataSandP$PATIENT_ID
colnames(dataSandP)
# reassign Calls to only normal, basal, luminal A/B
pam50_score$Call2 <-
  colnames(pam50_score[, c(2, 4:6)])[apply(pam50_score[, c(2, 4:6)], 1, which.max)]
colnames(pam50_score) [1] <- "Patient_ID"
sapply(pam50_score, class)
pam50_score
# Transpose Array50
head(Array50)
rownames(Array50) <- Array50$Hugo_Symbol
colnames(Array50)
rownames(Array50)
tarray50 <- t(Array50)
tarray50[1:5, 1:6]


tarray50 <- cbind(Row.Names = rownames(tarray50), tarray50)
rownames(tarray50)
# rownames(tarray50) <- NULL
# colnames(tarray50) [1] <- "Patient_ID"
# sapply(tarray50, class)


##################################
# MERGING 2 big data frame

# merge pam50 calls with clinical info
Dat_Patient_Calls <-
  merge.data.frame(
    dataSandP,
    pam50_score[, c(1, 16)],
    by.x = "PATIENT_ID",
    by.y = "Patient_ID",
    all.x = TRUE,
    all.y = TRUE
  )

# merge
tarray50$Patient_ID <- rownames(tarray50)

tarray50$Patient_ID <-
    substr(tarray50$Patient_ID,
            start = 6,
            stop = 12) 
pam50_score$Patient_ID <-
     substr(pam50_score$Patient_ID, start = 6, stop = 12)


dfpatient_A50 <-
  merge.data.frame(
    Dat_Patient_Calls,
    tarray50
    ,
    by.x = "PATIENT_ID",
    by.y = "Patient_ID",
    all.x = TRUE,
    all.y = TRUE
  )

colnames(dfpatient_A50)
summary(dfpatient_A50)
summary(Dat_Patient_Calls)

# MERGE

colnames(tarray50)
colnames(pam50_score)

calls_array50 <-
  merge.data.frame(
    tarray50,
    pam50_score[, c(1, 7, 16)],
    by.x = "Patient_ID",
    by.y = "Patient_ID",
    all.x = TRUE,
    all.y = TRUE
  )

head(calls_array50)
sapply(calls_array50, class)






##################################
# END part 1
##################################




##################################
# Prep array50

SAVE_Array50 <- Array50
Array50$Cellular_process <- rownames(Array50)
# Add column for gene role

# "ACTR3B"     "ANLN"       "BAG1"       "BCL2"       "BIRC5"      "BLVRA"      "CCNB1"      "CCNE1"     
# [9] "CDC20"      "CDC6"       "CDH3"       "CENPF"      "CEP55"      "CXXC5"      "EGFR"       "ERBB2"     
# [17] "ESR1"       "EXO1"       "FGFR4"      "FOXA1"      "FOXC1"      "GPR160"     "GRB7"       "KIF2C"     
# [25] "KRT14"      "KRT17"      "KRT5"       "MAPT"       "MDM2"       "MELK"       "MIA"        "MKI67"     
# [33] "MLPH"       "MMP11"      "MYBL2"      "MYC"        "NAT1"       "KNTC2"      "CDCA1"      "ORC6L"     
# [41] "PGR"        "PHGDH"      "PTTG1"      "RRM2"       "SFRP1"      "SLC39A6"    "TMEM45B"    "TYMS"      
# [49] "UBE2C"      "UBE2T"      "Patient_ID"


# Prosigna 5 reference genes (ACTB, GAPDH, RPLPO, GUS, TFRC)
# Gene identified to be involved in proliferation
# BIRC5, CCNB, CDC20, NUF2=CDCA1, CEP55, KNTC2, MKI67, PTTG1, RRM2, TYMS, UBEC2
# other proliferation-related genes (Ki67,STK15, Survivin, 7- CCNB1, 35-MYBL2), 
Array50$Cellular_process[c(5,7,9,39,13,38,32,43,44,48,49)] <- "proliferation"

# estrogen-related genes (ER(17-ESR1),42-PGR, 4-BCL2, SCUBE2)
Array50$Cellular_process[c(4,17,41)] <- "estrogen-related"

# HER2-related genes (HER2(16-ERBB2), 23-GRB7)
Array50$Cellular_process[c(16,23)] <- "HER2-related"

# invasion-related genes (34-MMP11, CTSL2) and 3 others (GSTM1, CD68, BAG1) 
Array50$Cellular_process[c(34)] <- "invasion-related"

# angiogenesis FGFR4
Array50$Cellular_process[c(19)] <- "angiogenesis"

Array50$Cellular_process

##################################
# MERGE SCORE DATA AND ARRAY50
##################################

# Prep Array50 for merge
Array50[1:6,1:3]
Array50[, 495:ncol(Array50)]
rownames(Array50) 
Array50[1] <- NULL
# transpose to character
t1 <- t(Array50[,1:ncol(Array50)])
head(t1)
t1[495:nrow(t1), ]
sapply(t1, class)
t1
t1
t2 <- Array50[, 495:ncol(Array50)-1]
t3 <- t(t2)
str(t3)
sapply(t3, class)
#then can merge...should stay num


t3array50 <- as.data.frame(Array50[, 2:ncol(Array50)]) 
#because i dont want genename as column overwise become a vector
head(t3array50)
sapply(t3array50, class)
# all is numeric




