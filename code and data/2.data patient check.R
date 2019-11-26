##################################
# import library
##################################
library(stringr)
library(ggplot2)

##################################

#Alive <- grep('Alive', Dat_Patient_Calls$VITAL_STATUS)
str_count(Dat_Patient_Calls, "Alive")

#Passed <- grep('Dead', Dat_Patient_Calls$VITAL_STATUS)
str_count(Dat_Patient_Calls, "Dead")
#D <- Dat_Patient_Calls$VITAL_STATUS == "Dead"


passed_index_in_Vital_status <-
   which(Dat_Patient_Calls$VITAL_STATUS == "Dead")
Dat_Patient_Calls$PATIENT_ID[passed_index_in_Vital_status]
Dat_Patient_Calls$SUBTYPE[passed_index_in_Vital_status]
Dat_Patient_Calls$CLINICAL_GLEASON_SUM[passed_index_in_Vital_status]
Dat_Patient_Calls$TUMOR_STATUS[passed_index_in_Vital_status]
Dat_Patient_Calls$Call2[passed_index_in_Vital_status]
Dat_Patient_Calls$HISTORY_OTHER_MALIGNANCY[passed_index_in_Vital_status]
Dat_Patient_Calls$HISTORY_NEOADJUVANT_TRTYN[passed_index_in_Vital_status]
Dat_Patient_Calls$RADIATION_TREATMENT_ADJUVANT[passed_index_in_Vital_status]
Dat_Patient_Calls$TREATMENT_OUTCOME_FIRST_COURSE[passed_index_in_Vital_status]
Dat_Patient_Calls$NEW_TUMOR_EVENT_AFTER_INITIAL_TREATMENT[passed_index_in_Vital_status]
Dat_Patient_Calls$TARGETED_MOLECULAR_THERAPY[passed_index_in_Vital_status]

Death_outcome_DF <-
   Dat_Patient_Calls[c(189, 263, 311, 317, 347, 350, 416, 446, 462, 473), ]
Death_outcome_DF

# cor gleason and calls calls2

Dat_Patient_Calls[1:5,1:6]



hist(Dat_Patient_Calls$CLINICAL_GLEASON_SUM)
LumB <- Dat_Patient_Calls$Call == "LumB"
LumA <- Dat_Patient_Calls$Call == "LumA"
Basal <- Dat_Patient_Calls$Call == "Basal"
Normal <- Dat_Patient_Calls$Call == "Normal"
HER <- Dat_Patient_Calls$Call == "Her2"

LumB2 <- Dat_Patient_Calls$Call2 == "LumB"
LumA2 <- Dat_Patient_Calls$Call2 == "LumA"
Basal2 <- Dat_Patient_Calls$Call2 == "Basal"
Normal2 <- Dat_Patient_Calls$Call2 == "Normal"
HER2 <- Dat_Patient_Calls$Call2 == "Her2"
Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumA]

hist(Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumA])
boxplot(Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumA], 
        Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumB], 
        Dat_Patient_Calls$CLINICAL_GLEASON_SUM[Normal],
        Dat_Patient_Calls$CLINICAL_GLEASON_SUM[Basal], 
        Dat_Patient_Calls$CLINICAL_GLEASON_SUM[HER], 
        names = c("LumA","LumB","Normal","Basal","Her2"))
boxplot(Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumA2], 
        Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumB2], 
        Dat_Patient_Calls$CLINICAL_GLEASON_SUM[Normal2],
        Dat_Patient_Calls$CLINICAL_GLEASON_SUM[Basal2], 
        Dat_Patient_Calls$CLINICAL_GLEASON_SUM[HER2], 
        names = c("LumA","LumB","Normal","Basal","Her2"))

heatmap(tarray50)

cor(x= Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumA], 
    Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumB], 
    Dat_Patient_Calls$CLINICAL_GLEASON_SUM[Normal],
    Dat_Patient_Calls$CLINICAL_GLEASON_SUM[Basal], 
    Dat_Patient_Calls$CLINICAL_GLEASON_SUM[HER], 
    y= Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumA2], 
    Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumB2], 
    Dat_Patient_Calls$CLINICAL_GLEASON_SUM[Normal2],
    Dat_Patient_Calls$CLINICAL_GLEASON_SUM[Basal2], 
    Dat_Patient_Calls$CLINICAL_GLEASON_SUM[HER2])
cor(x= mean(Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumA]),
    y= mean(Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumA2])
mean(Dat_Patient_Calls$CLINICAL_GLEASON_SUM[LumA], na.rm = TRUE)


##############weird
# a <-
#    sum(
#       Death_outcome_DF$DFS_STATUS == "Recurred/Progressed",
#       yes = 1,
#       no = 0
#    )
# b <-
#    sum(
#       Death_outcome_DF$NEW_TUMOR_EVENT_AFTER_INITIAL_TREATMENT == "YES",
#       yes = 1,
#       no = 0
#    )
# c <-
#    sum(
#       Death_outcome_DF$TREATMENT_OUTCOME_FIRST_COURSE == "%Progression%",
#       yes = 1,
#       no = 0
#    )
# a
# b
# c
# 
# table(a, b, c)
# 
# ggplot(N, aes(x = a, y = b))
# hist(Dat_Patient_Calls, x = 1, y = 2)
# 
# ggplot(Dat_Patient_Calls[Death_outcome_DF == 1, ], aes(x = a, y = b)) +
#    scale_fill_manual(values = rep("white", 5)) +
#    geom_jitter(
#       position = position_jitterdodge(
#          jitter.width = 0.5,
#          jitter.height = 0,
#          dodge.width = 0.75
#       ),
#       aes(fill = a, col = b),
#       alpha = 0.7
#    ) +
#    geom_boxplot(outlier.shape = NA, alpha = 0) +
#    theme(
#       panel.grid.major = element_blank(),
#       panel.grid.minor = element_blank(),
#       panel.background = element_blank(),
#       axis.line = element_line(colour = "black")
#    ) +
#    guides(fill = FALSE, colour = FALSE)
# 
# ggplot(dat[dat$high_quality == 1, ], aes(x = Call, y = Confidence, fill =
#                                             Call)) +
#    scale_fill_manual(values = rep("white", 5)) +
#    geom_jitter(
#       position = position_jitterdodge(
#          jitter.width = 0.5,
#          jitter.height = 0,
#          dodge.width = 0.75
#       ),
#       aes(fill = Call, col = Call),
#       alpha = 0.7
#    ) +
#    geom_boxplot(outlier.shape = NA, alpha = 0) +
#    theme(
#       panel.grid.major = element_blank(),
#       panel.grid.minor = element_blank(),
#       panel.background = element_blank(),
#       axis.line = element_line(colour = "black")
#    ) +
#    guides(fill = FALSE, colour = FALSE)
# 
# 
# table(
#    passed_index_in_Vital_status +
#       Dat_Patient_Calls$PATIENT_ID[passed_index_in_Vital_status] +
#       Dat_Patient_Calls$SUBTYPE[passed_index_in_Vital_status] +
#       Dat_Patient_Calls$CLINICAL_GLEASON_SUM[passed_index_in_Vital_status] +
#       Dat_Patient_Calls$TUMOR_STATUS[passed_index_in_Vital_status] +
#       Dat_Patient_Calls$Call2[passed_index_in_Vital_status]
# )
# 
# 
# table()
# xtabs()
# ggplot2
# 


####################################################
pairs(calls_array50[,2:10])
heatmap(Array50)
####################################################
#cor
####################################################
str(calls_array50[5:10])
str(calls_array50$ACTR3B[3:10]) 





cor(calls_array50[5,10], y=calls_array50[5,5])
cor(calls_array50[2:nrow(calls_array50),2:ncol(calls_array50)-2])
cor.test(calls_array50[2:nrow(calls_array50),2:ncol(calls_array50)-2], y= NULL)


