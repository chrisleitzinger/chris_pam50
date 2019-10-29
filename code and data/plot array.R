dfpatient_A50
colnames(dfpatient_A50)

#checking expression for each group
callsVSarray50 <- dfpatient_A50[,c(1,17,(19:ncol(dfpatient_A50)))]
head(callsVSarray50)[1:3]
sort(callsVSarray50$Call2)

hist(callsVSarray50$ANLN[callsVSarray50$Call2=="Normal"])

barplot(callsVSarray50$ANLN[callsVSarray50$Call2=="Normal"])
boxplot(callsVSarray50$ANLN[callsVSarray50$Call2=="Normal"],
        callsVSarray50$ANLN[callsVSarray50$Call2=="Basal"],
        callsVSarray50$ANLN[callsVSarray50$Call2=="LumA"],
        callsVSarray50$ANLN[callsVSarray50$Call2=="LumB"])

plot(callsVSarray50$ANLN,callsVSarray50$BAG1)

plot(callsVSarray50$ANLN[callsVSarray50$Call2=="LumB"])

cor(callsVSarray50$ANLN[callsVSarray50$Call2=="LumB"])

hc <- callsVSarray50 %>%
  callsVSarray50$Call2 %>%
  hclust



#rm(dfpatient_A50)
