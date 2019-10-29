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
array50 <- as.data.frame(Array50[, 2:ncol(Array50)])

t_array50 <- as.data.frame(t(array50))
colnames(t_array50) <- rownames(Array50)

t_array50 / t_array50$ACTR3B
actine_reported_expression <- t_array50 / t_array50$ACTR3B
actine_reported_expression$Patient_ID <-
  rownames(actine_reported_expression)
actine_reported_expression$Patient_ID <-
  substr(actine_reported_expression$Patient_ID,
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
    actine_reported_expression
    ,
    by.x = "PATIENT_ID",
    by.y = "Patient_ID",
    all.x = TRUE,
    all.y = TRUE
  )
colnames(dfpatient_A50)
summary(dfpatient_A50)
