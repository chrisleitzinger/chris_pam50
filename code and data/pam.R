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

Array50 <- read_delim("code and data/data/tcgaPAM50.txt", delim = "\t")

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

##################################
head(Array50)[1:5,1:5]
colnames(Array50)[1:5]
rownames(Array50)[1:5]
#Array50$Hugo_Symbol
# rownames(Array50) <- Array50$Hugo_Symbol
# rownames(Array50)
head(Array50)
array50 <- as.data.frame(Array50[,2:ncol(Array50)])

t_array50 <- as.data.frame(t(array50))
head(t_array50)
colnames(t_array50) <- rownames(Array50)
colnames(t_array50)
head(t_array50)
t_array50[2,2]*t_array50[2,2]
actine_reported_expression <- t_array50/t_array50$ACTR3B
actine_reported_expression

##################################

# MERGING


# Lets see if i dont create a id column
# actine_reported_expression$Patient_ID <- rownames(actine_reported_expression)
# dim(actine_reported_expression)
# head(actine_reported_expression)

# DF_Patient_A50 <- merge(DF_Patient_Calls, Array50
#                         , by.x = "PATIENT_ID", by.y = 1, all.x=TRUE, all.y = TRUE)
# DF_Patient_A50
