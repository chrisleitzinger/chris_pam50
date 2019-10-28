library(tidyverse)

##################################
# STEP1
# import PAM50 data
##################################

Array50 <- read_delim("code and data/data/tcgaPAM50.txt", delim = "\t")
head(Array50)[1:5,1:5]
colnames(Array50) [1:5]
rownames(Array50)
rownames(Array50) <- Array50$Hugo_Symbol
head(Array50)[1:5,1:5]

t_array50 <- as.data.frame(t(Array50))
head(t_array50)[1:5,1:5]

colnames(t_array50)[1:5]
rownames(t_array50)[1:5]


#rownames(t_array50) [1] <- "Patient_ID"
rownames_to_column(t_array50, var = "Patient_ID")
t_array50$Patient_ID <-  rownames(t_array50)
t_array50$Patient_ID
colnames(t_array50)


#pam50_score$Patient_ID <- substr(pam50_score$Patient_ID,start = 6,stop = 12)

rm(t_array50)




######################
t_array50[2:499,1]
t_array50[X1]
mutate(t_array50, act = t_array50[2:499,1]/t_array50[2:499,1])







# rownames(Array50)[1]
# test <- Array50[2:5,2]
# Array50$`TCGA-2A-A8VL-01`
# mutate(Array50, act = Array50$`TCGA-2A-A8VL-01`/Array50$`TCGA-2A-A8VL-01`)
# colnames(Array50)
# Array50['act']
# Array50$act
# #act = Array50[1,2:5]/Array50[1,2:5]

test <- Array50[2:5,2]
test
test$`TCGA-2A-A8VL-01`
mutate(test, act = test$`TCGA-2A-A8VL-01`/test$`TCGA-2A-A8VL-01`)

##################################

##################################

# MERGING

# DF_Patient_A50 <- merge(DF_Patient_Calls, Array50
#                         , by.x = "PATIENT_ID", by.y = 1, all.x=TRUE, all.y = TRUE)
# DF_Patient_A50



#dat$high_quality <- ifelse(dat$PATIENT_ID %in% clinical_pub$PATIENT_ID,1,0)


#write.csv(datafile,"data/merged.csv")
