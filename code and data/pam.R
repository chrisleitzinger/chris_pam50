##################################
# import library
##################################

library(readr)


##################################
# STEP1
# import PAM50 data
##################################

Patient_Preclin <- read_delim("code and data/data/data_clinical.txt", delim = "\t", skip = 5)

Patient_Post <- read_delim("code and data/data/data_bcr_clinical_data_patient.txt", delim = "\t", skip = 4)

pam50_score <- read_delim("code and data/data/tcgaPAM50_pam50scores.txt", delim = "\t")


##################################
# MERGE PRE AND POST DATA
##################################


# other way = merge.data.frame(Patient_Preclin, Patient_Post, by.x = 2, by.y = 2)
PandPClin <- merge.data.frame(Patient_Preclin[, c(1:3,14,85)], 
                              Patient_Post[, c(1:2,17:18,32,37,41:43,67,70,72)], 
                              by.x = "PATIENT_ID", by.y = "PATIENT_ID", 
                              all.x=TRUE, all.y = TRUE)
head(PandPClin)
dim(PandPClin)
PandPClin$"PATIENT_ID"
PandPClin$PATIENT_ID <- substr(PandPClin$PATIENT_ID,start = 6,stop = 12)
PandPClin$PATIENT_ID
colnames(PandPClin)
rownames(PandPClin)
PandPClin


##################################
# Data Prep
##################################

colnames(pam50_score) [1] <- "Patient_ID"
colnames(pam50_score)
pam50_score$Patient_ID <- substr(pam50_score$Patient_ID,start = 6,stop = 12)
pam50_score$Patient_ID
pam50_score


# reassign Calls to only normal, basal, luminal A/B
pam50_score$Call2 <- colnames(pam50_score[,c(2,4:6)])[apply(pam50_score[,c(2,4:6)],1,which.max)]
pam50_score$Call2
pam50_score[,(14:16)]
dim(pam50_score)

# merge pam50 calls with clinical info 
colnames(PandPClin)
Dat_Patient_Calls <- merge.data.frame(PandPClin, pam50_score[, c(1,16)], 
                                      by.x = "PATIENT_ID", by.y = "Patient_ID", 
                                      all.x=TRUE, all.y = TRUE)
Dat_Patient_Calls

