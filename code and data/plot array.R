dfpatient_A50
colnames(dfpatient_A50)

#checking expression for each group
callsVSarray50 <- dfpatient_A50[, c(1, 17, (19:ncol(dfpatient_A50)))]
head(callsVSarray50)[1:3]
sort(callsVSarray50$Call2)

hist(callsVSarray50$ANLN[callsVSarray50$Call2 == "Normal"])

barplot(callsVSarray50$ANLN[callsVSarray50$Call2 == "Normal"])
boxplot(
  callsVSarray50$ANLN[callsVSarray50$Call2 == "Normal"],
  callsVSarray50$ANLN[callsVSarray50$Call2 == "Basal"],
  callsVSarray50$ANLN[callsVSarray50$Call2 == "LumA"],
  callsVSarray50$ANLN[callsVSarray50$Call2 == "LumB"]
)

plot(callsVSarray50$ANLN, callsVSarray50$BAG1)

plot(callsVSarray50$ANLN[callsVSarray50$Call2 == "LumB"])



# Test normality
qqnorm(callsVSarray50$ANLN)
qqline(callsVSarray50$ANLN)

#par(mfrow = c(2,2)) tot see a 2 by 2 plot

library(lattice)
xyplot(callsVSarray50$BIRC5~callsVSarray50$CDC20| callsVSarray50$Call2, data=callsVSarray50)

xyplot(callsVSarray50$BIRC5[callsVSarray50$Call2 == "Normal"]~
         callsVSarray50$CDC20[callsVSarray50$Call2 == "Basal"], data=callsVSarray50)

library("psych")
pairs.panels(callsVSarray50$Call2 == "LumB" [6:6])


cor(callsVSarray50$ANLN[callsVSarray50$Call2 == "LumB"])

hc <- callsVSarray50 %>%
  callsVSarray50$Call2 %>%
  hclust



#rm(dfpatient_A50)



# PART 2
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




