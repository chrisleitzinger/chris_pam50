##################################
# import library
##################################

library(dplyr)
library(ggplot2)
library(stringr)

##################################


Alive <- grep('Alive', Dat_Patient_Calls$VITAL_STATUS)
str_count(Dat_Patient_Calls, "Alive")

Dead <- grep('Dead', Dat_Patient_Calls$VITAL_STATUS)
str_count(Dat_Patient_Calls, "Dead")
D <- Dat_Patient_Calls$VITAL_STATUS=="Dead"
dead_index_in_Vital_status

dead_index_in_Vital_status <- which(Dat_Patient_Calls$VITAL_STATUS== "Dead")
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

Death_outcome_DF <- Dat_Patient_Calls[c(189, 263, 311, 317, 347, 350, 416, 446, 462, 473),]
Death_outcome_DF
##############weird
a <- sum(Death_outcome_DF$DFS_STATUS=="Recurred/Progressed", yes = 1, no = 0)
b <- sum(Death_outcome_DF$NEW_TUMOR_EVENT_AFTER_INITIAL_TREATMENT == "YES", yes = 1, no = 0)
c <- sum(Death_outcome_DF$TREATMENT_OUTCOME_FIRST_COURSE == "%Progression%", yes = 1, no = 0)
a
b
c

table(a, b, c)

ggplot(Dat_Patient_Calls$PATIENT_ID,aes(x=a, y= b))
hist(Dat_Patient_Calls, x=1, y=2)

ggplot(Dat_Patient_Calls[Death_outcome_DF==1,],aes(x=a, y= b)) +
scale_fill_manual(values=rep("white",5)) +
   geom_jitter(position = position_jitterdodge(jitter.width = 0.5,jitter.height = 0,dodge.width=0.75),
               aes(fill=a,col=b),alpha=0.7) +
   geom_boxplot(outlier.shape = NA, alpha=0) +
   theme(panel.grid.major = element_blank(),
         panel.grid.minor = element_blank(), 
         panel.background = element_blank(), 
         axis.line = element_line(colour = "black")) + 
   guides(fill=FALSE,colour=FALSE)

ggplot(dat[dat$high_quality==1,],aes(x=Call,y=Confidence,fill=Call)) + 
   scale_fill_manual(values=rep("white",5)) +
   geom_jitter(position = position_jitterdodge(jitter.width = 0.5,jitter.height = 0,dodge.width=0.75),
               aes(fill=Call,col=Call),alpha=0.7) +
   geom_boxplot(outlier.shape = NA, alpha=0) +
   theme(panel.grid.major = element_blank(),
         panel.grid.minor = element_blank(), 
         panel.background = element_blank(), 
         axis.line = element_line(colour = "black")) + 
   guides(fill=FALSE,colour=FALSE)


table(dead_index_in_Vital_status +
      Dat_Patient_Calls$PATIENT_ID[dead_index_in_Vital_status]+
      Dat_Patient_Calls$SUBTYPE[dead_index_in_Vital_status]+
      Dat_Patient_Calls$CLINICAL_GLEASON_SUM[dead_index_in_Vital_status]+
      Dat_Patient_Calls$TUMOR_STATUS[dead_index_in_Vital_status]+
      Dat_Patient_Calls$Call2[dead_index_in_Vital_status]
      )


table()
xtabs()
ggplot2

