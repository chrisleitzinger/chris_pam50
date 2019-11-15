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
