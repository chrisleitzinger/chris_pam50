##################################
# import library
##################################
#install.packages("corrplot")

library(dplyr)
library(ggplot2)
library(stringr)
library(corrplot)

####################################################
# SAVE_Array50 plot
####################################################
str(SAVE_Array50)
sapply(SAVE_Array50, class)
head(SAVE_Array50)
Array50[,497:ncol(Array50)-1]

Ccor_Array50 <- cor(SAVE_Array50[,350:ncol(SAVE_Array50)])
cor_Array50 <- cor(SAVE_Array50[,2:ncol(SAVE_Array50)])
c1 <- cor(x = SAVE_Array50[,2:250], y = SAVE_Array50[,250:ncol(SAVE_Array50)])
c2 <- cor(x = SAVE_Array50[6:9,480:ncol(SAVE_Array50)], y= SAVE_Array50[2:5,480:ncol(SAVE_Array50)])

corrplot(Ccor_Array50)
corrplot(cor_Array50)
corrplot(c1)
corrplot(c2)

##################################


Alive <- grep('Alive', Dat_Patient_Calls$VITAL_STATUS)
str_count(Dat_Patient_Calls, "Alive")

Dead <- grep('Dead', Dat_Patient_Calls$VITAL_STATUS)
str_count(Dat_Patient_Calls, "Dead")
D <- Dat_Patient_Calls$VITAL_STATUS == "Dead"


dead_index_in_Vital_status <-
   which(Dat_Patient_Calls$VITAL_STATUS == "Dead")
Dat_Patient_Calls$PATIENT_ID[dead_index_in_Vital_status]
Dat_Patient_Calls$SUBTYPE[dead_index_in_Vital_status]
Dat_Patient_Calls$CLINICAL_GLEASON_SUM[dead_index_in_Vital_status]
Dat_Patient_Calls$TUMOR_STATUS[dead_index_in_Vital_status]
Dat_Patient_Calls$Call2[dead_index_in_Vital_status]
Dat_Patient_Calls$HISTORY_OTHER_MALIGNANCY[dead_index_in_Vital_status]
Dat_Patient_Calls$HISTORY_NEOADJUVANT_TRTYN[dead_index_in_Vital_status]
Dat_Patient_Calls$RADIATION_TREATMENT_ADJUVANT[dead_index_in_Vital_status]
Dat_Patient_Calls$TREATMENT_OUTCOME_FIRST_COURSE[dead_index_in_Vital_status]
Dat_Patient_Calls$NEW_TUMOR_EVENT_AFTER_INITIAL_TREATMENT[dead_index_in_Vital_status]
Dat_Patient_Calls$TARGETED_MOLECULAR_THERAPY[dead_index_in_Vital_status]

Death_outcome_DF <-
   Dat_Patient_Calls[c(189, 263, 311, 317, 347, 350, 416, 446, 462, 473), ]
Death_outcome_DF
##############weird
a <-
   sum(
      Death_outcome_DF$DFS_STATUS == "Recurred/Progressed",
      yes = 1,
      no = 0
   )
b <-
   sum(
      Death_outcome_DF$NEW_TUMOR_EVENT_AFTER_INITIAL_TREATMENT == "YES",
      yes = 1,
      no = 0
   )
c <-
   sum(
      Death_outcome_DF$TREATMENT_OUTCOME_FIRST_COURSE == "%Progression%",
      yes = 1,
      no = 0
   )
a
b
c

table(a, b, c)
Dat_Patient_Calls$PATIENT_ID
ggplot(N, aes(x = a, y = b))
hist(Dat_Patient_Calls, x = 1, y = 2)

ggplot(Dat_Patient_Calls[Death_outcome_DF == 1, ], aes(x = a, y = b)) +
   scale_fill_manual(values = rep("white", 5)) +
   geom_jitter(
      position = position_jitterdodge(
         jitter.width = 0.5,
         jitter.height = 0,
         dodge.width = 0.75
      ),
      aes(fill = a, col = b),
      alpha = 0.7
   ) +
   geom_boxplot(outlier.shape = NA, alpha = 0) +
   theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_blank(),
      axis.line = element_line(colour = "black")
   ) +
   guides(fill = FALSE, colour = FALSE)

ggplot(dat[dat$high_quality == 1, ], aes(x = Call, y = Confidence, fill =
                                            Call)) +
   scale_fill_manual(values = rep("white", 5)) +
   geom_jitter(
      position = position_jitterdodge(
         jitter.width = 0.5,
         jitter.height = 0,
         dodge.width = 0.75
      ),
      aes(fill = Call, col = Call),
      alpha = 0.7
   ) +
   geom_boxplot(outlier.shape = NA, alpha = 0) +
   theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.background = element_blank(),
      axis.line = element_line(colour = "black")
   ) +
   guides(fill = FALSE, colour = FALSE)


table(
   dead_index_in_Vital_status +
      Dat_Patient_Calls$PATIENT_ID[dead_index_in_Vital_status] +
      Dat_Patient_Calls$SUBTYPE[dead_index_in_Vital_status] +
      Dat_Patient_Calls$CLINICAL_GLEASON_SUM[dead_index_in_Vital_status] +
      Dat_Patient_Calls$TUMOR_STATUS[dead_index_in_Vital_status] +
      Dat_Patient_Calls$Call2[dead_index_in_Vital_status]
)


table()
xtabs()
ggplot2



####################################################
pairs(calls_array50[,2:10])
heatmap(Array50)
####################################################
#cor
####################################################
str(calls_array50[5:10])
str(calls_array50$ACTR3B[3:10]) 
N <- calls_array50[2:nrow(calls_array50),4:ncol(calls_array50)-2]
M <- calls_array50$ACTR3B[1:20]


head(M)
str(M)
O <- as.character(N)
str(O)
P <- as.numeric(M)
str(P)
cor(Q,Q)
cor(P)
heatmap(P)


calls_array50$ACTR3B[10:20]
P <- as.numeric(calls_array50$ACTR3B[10:20], calls_array50$ANLN[10:20])
O <- as.data.frame.matrix(calls_array50[2:nrow(calls_array50),4:ncol(calls_array50)-2])
M <- as.numeric(calls_array50[2:nrow(calls_array50),4:ncol(calls_array50)-2])
sapply(M, class)
N
Q
calls_array50[2:nrow(calls_array50),4:ncol(calls_array50)-2]

rm(N)



cor(calls_array50[5,10], y=calls_array50[5,5])
cor(calls_array50[2:nrow(calls_array50),2:ncol(calls_array50)-2])
cor.test(calls_array50[2:nrow(calls_array50),2:ncol(calls_array50)-2], y= NULL)


