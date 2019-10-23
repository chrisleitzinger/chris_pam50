##################################
# import library
##################################

library(readr)


##################################
# STEP1
# import PAM50 data
##################################

Patient_Preclin <- read_delim("data/data_clinical.txt", delim = "\t", skip = 5)

Patient_Post <- read_delim("data/data_bcr_clinical_data_patient.txt", delim = "\t", skip = 4)

pam50_score <- read_delim("data/tcgaPAM50_pam50scores.txt", delim = "\t")

Array50 <- read_delim("data/tcgaPAM50.txt", delim = "\t")


##################################
# Data Prep
##################################

Patient_Preclin$Patient_Id <- substr(Patient_Preclin$PATIENT_ID,start = 6,stop = 12)
Patient_Preclin$Patient_Id
colnames(Patient_Preclin)
rownames(Patient_Preclin) <- Patient_Preclin$Patient_Id
rownames(Patient_Preclin)

P_Id <- substr(Patient_Post$PATIENT_ID,start = 6,stop = 12)
Patient_Post$P_Id
colnames(Patient_Post)
rownames(Patient_Post) <- Patient_Post$P_Id
rownames(Patient_Post)
##################################
#Merging
dim(Patient_Preclin)
dim(Patient_Post)



# other way = merge.data.frame(Patient_Preclin, Patient_Post, by.x = 2, by.y = 2)
PandPClin <- merge.data.frame(Patient_Preclin, Patient_Post, by.x = "PATIENT_ID", by.y = "PATIENT_ID", 
                              all.x=TRUE, all.y = TRUE)
PandPClin



##################################
# Data Prep
##################################

colnames(pam50_score) [1] <- "P_ID"
colnames(pam50_score)
pam50_score$Patient_ID <- substr(pam50_score$P_ID,start = 6,stop = 12)
pam50_score$Patient_ID
colnames(pam50_score)
rownames(pam50_score) <- pam50_score$Patient_ID
rownames(pam50_score)
pam50_score

##################################
# reassign Calls to only normal, basal, luminal A/B
pam50_score$Call2 <- colnames(pam50_score[,c(2,4:6)])[apply(pam50_score[,c(2,4:6)],1,which.max)]
pam50_score$Call2
pam50_score[,2]
pam50_score[,(4:6)]
pam50_score[,(14:16)]
pam50_score

##################################

Array50
P_id <- substr(colnames(Array50),start = 6,stop = 12)
P_id
Array50$Hugo_Symbol
rownames(Array50) <- Array50$Hugo_Symbol
rownames(Array50)
colnames(Array50) <- P_id
colnames(Array50)
Array50

##################################
# STEP2
# Cleaning
##################################
dim(pam50_score)
dim(Array50)


##################################
# MERGING
# merge pam50 calls with clinical info 
pam50_score$"P_ID"
all_data_merged <- merge(PandPClin, pam50_score, by.x = "PATIENT_ID", by.y = "P_ID",all.x=TRUE, all.y = TRUE)
all_data_merged


dat <- merge(Patient_Preclin,pam50_score,by.x="PATIENT_ID",by.y="P_ID",all.x=TRUE)
dat

#dat$high_quality <- ifelse(dat$PATIENT_ID %in% clinical_pub$PATIENT_ID,1,0)









                 
                # = intersect(PATIENT_ID(Patient_Preclin), by.y(pam50_score))

#write.csv(datafile,"data/merged.csv")




# PatientId <- colnames(pam50_score, chr=2:499)
# 
# 
# PatientId
# pam50_score$PatientId
# 
# pam50_score$PatientId <- read.delim("data/tcgaPAM50.txt", nrow = 1:5)
# pam50_score$PatientId
