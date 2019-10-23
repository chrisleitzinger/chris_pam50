##################################
# STEP1
# import PAM50 data
##################################

Array50 <- read_delim("data/tcgaPAM50.txt", delim = "\t")

##################################


Array50
##################################
##################################
##################################
dim(Array50)
rownames(Array50)
colnames(Array50)[2:499]


#Array50


# colnames(Array50) [1] <- P_id
# colnames(Array50)
# rownames(Array50) <- "Patient_ID"
# Array50
# rownames()

colnames(Array50) [1] <- "genes"
colnames(Array50)
Array50$genes
rownames(Array50) <- Array50$genes
rownames(Array50)
P_id <- substr(colnames(Array50)[2:499],start = 6,stop = 12)
P_id
Array50

##################################

##################################

# MERGING

# DF_Patient_A50 <- merge(DF_Patient_Calls, Array50
#                         , by.x = "PATIENT_ID", by.y = 1, all.x=TRUE, all.y = TRUE)
# DF_Patient_A50



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
