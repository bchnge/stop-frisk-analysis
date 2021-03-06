frisk <- read.csv(file = 'data/Frisk2012-CensusTract-ACS.csv',header = TRUE, sep = ',',stringsAsFactors = FALSE)
save(frisk,file='data/frisk.RData')
load('data/frisk.RData')
library('psych')
library('GPArotation')
frisk1 <- as.data.frame(cbind(frisk[,406],frisk[,412],frisk[,240],frisk[,246],frisk[,254],frisk[,359],frisk[,297]))#income,foodstmps,highScool,graduateDegree,homeLanguageEnglish,noSocialSecurity,unEmployed
scaledFrisk1 <- as.data.frame(scale(frisk1))
fa.parallel(frisk1)
corMat1 <- cor (frisk1)
solution <- fa(r = frisk1, nfactors = 3, rotate = "varimax", fm = "wls",max.iter = 500)
##########################################################################################
frisk2 <- as.data.frame(cbind(frisk[,208],frisk[,218],frisk[,406],frisk[,412],frisk[,240],frisk[,246],frisk[,254],frisk[,359],frisk[,297]))#blacks,hispanic,income,foodstmps,highScool,graduateDegree,homeLanguageEnglish,noSocialSecurity,unEmployed
scaledFrisk2 <- as.data.frame(scale(frisk2))
fa.parallel(frisk2)
corMat1 <- cor (frisk2)
solution <- fa(r = frisk2, nfactors = 3, rotate = "varimax", fm = "wls",max.iter = 500)
#############################################################################################
# frisk[,369] #number of houses with SNAP
# frisk [,406] #average per capita income
# frisk[,407] #income white
# frisk[,408] #income black
# frisk[,409] #income asian
# frisk[,410] #income not hispanic
# frisk[,411] #income hispanic
# frisk[,413] #number of houses with food stamps 
# frisk[,437] #number of childer under two parents
# frisk[,439] #number of childer under one parent
# frisk[,415] #percentage of households white
# frisk[,419] #percentage of households black
# frisk[,423] #percentage of households asian
# frisk[,427] #percentage of households not hispanic
# frisk[,431] #percentage of households hispanic
# frisk[,356] #percentage of houses with social security
# frisk[,362] #percentage of houses with supplemental security
# frisk[,366] #percentage of houses with public assistance 
# frisk[,321] #percentage enrolled in college
# frisk[,319] #percentage enrolled grade 1 to 12
# frisk[,317] #percentage enrolled in KG
# frisk[,265] #percentage of no income individuals
# frisk[,255] #percentage of home  with language english
# frisk[,257] #percentage of home with lang spanis
# frisk[,258] #percentage of home with lang other
frisk3 <- as.data.frame(cbind(frisk[,369],frisk[,406],frisk[,407],frisk[,408],frisk[,409],
                              frisk[,410],frisk[,411],frisk[,413],frisk[,437],frisk[,439],
                              frisk[,415],frisk[,419],frisk[,423],frisk[,427],frisk[,431],
                              frisk[,356],frisk[,362],frisk[,366],frisk[,321],frisk[,319],
                              frisk[,317],frisk[,265],frisk[,255],frisk[,257],frisk[,259]))
frisk3[is.na(frisk3)] <- 0
scaledFrisk3 <- as.data.frame(scale(frisk3))
fa.parallel(frisk3)
corMat1 <- cor (frisk3)
solution <- fa(r = corMat1, nfactors = 6, rotate = "varimax", fm = "wls",max.iter = 500)
##############################################################################################
require(sqldf)
load('data/frisk.RData')
library('psych')
library('GPArotation')

frisk4 <- sqldf('select distinct BOROCT2010, count(*) as count, ACS_p_home_lang_english, ACS_p_home_lang_spanish, ACS_p_home_lang_other, ACS_p_no_income_indv from ')
frisk4 <- as.data.frame(cbind(frisk[,132],frisk[,369], frisk[,406],frisk[,407],frisk[,408],frisk[,409],
                                                      frisk[,410],frisk[,411],frisk[,413],frisk[,437],frisk[,439],
                                                      frisk[,356],frisk[,362],frisk[,366],frisk[,321],frisk[,319],
                                                      frisk[,317],frisk[,265],frisk[,255],frisk[,257],frisk[,259] ))
frisk4 <- frisk[,c(132,369,406,407,408,409,410,411,413,415,419,431,437,439,356,362,366,321,319,317,265,255,257,259)]
frisk4[is.na(frisk4)] <- 0
colnames(frisk4) <- colnames(frisk[,c(132,369,406,407,408,409,410,411,413,437,439,356,362,366,321,319,317,265,255,257,259)])
friskCounts <- sqldf('select *,count(*) from frisk4 group by BoroCT2010')     
friskCounts <- friskCounts[c(2:nrow(friskCounts)),]
friskCounts[is.na(friskCounts)] <- 0
scaledFrisk4 <- as.data.frame(scale(frisk4))
corMat1 <- cor (frisk4[,c(2:ncol(frisk4))])
fa.parallel(frisk4)
solution <- fa(r = corMat1, nfactors = 6, rotate = "varimax", fm = "minres",max.iter = 500)
##########################################################################################################
require(sqldf)
load('data/frisk.RData')
library('psych')
library('GPArotation')

frisk4 <- sqldf('select distinct BOROCT2010, count(*) as count, ACS_p_home_lang_english, ACS_p_home_lang_spanish, ACS_p_home_lang_other, ACS_p_no_income_indv from ')
frisk4 <- as.data.frame(cbind(frisk[,132],frisk[,369], frisk[,406],frisk[,407],frisk[,408],frisk[,409],
                          frisk[,410],frisk[,411],frisk[,413],frisk[,437],frisk[,439],
                          frisk[,356],frisk[,362],frisk[,366],frisk[,321],frisk[,319],
                          frisk[,317],frisk[,265],frisk[,255],frisk[,257],frisk[,259] ))
colnames(frisk4) <- colnames(frisk[,c(132,369,406,407,408,409,410,411,413,437,439,356,362,366,321,319,317,265,255,257,259)])
friskCounts <- sqldf('select distinct * from frisk4 group by BoroCT2010')     
friskCounts <- friskCounts[c(2:nrow(friskCounts)),]
write.csv(file = 'data/censusTract.csv',friskCounts,row.names=FALSE)

friskCounts <- sqldf('select BoroCT2010,count(*) as count from frisk4 group by BoroCT2010')     
friskCounts <- friskCounts[c(2:nrow(friskCounts)),]
write.csv(file = 'data/censusTractCounts.csv',friskCounts,row.names=FALSE)
                        
friskCounts[is.na(friskCounts)] <- 0
scaledFrisk4 <- as.data.frame(scale(frisk4))
corMat1 <- cor (scaledFrisk4)
fa.parallel(friskCounts)

solution <- fa(r = friskCounts, nfactors = 7,symmetric=FALSE, rotate = "varimax", fm = "wls",max.iter = 500)
friskACS <- frisk[,c(132,193:440)]
friskACSfactorise1 <- friskACS[,c(1,16,18,22,30,seq(48,56,by=2),58,64,66,68,74,92,106,108,seq(94,100,by=2),seq(110,122,by=2),seq(135,165,by=2),seq(76,90,by=2),167,171,175,179,215,216,217,218,219,220,222,seq(224,240,by=2))]                        
friskACSfactorise1[is.na(friskACSfactorise1)] <- 0
fa.parallel(friskACSfactorise1)

solution <- fa(r = friskACSfactorise1[,c(10,11,12,13,15,16,17,18,19,28,53,54,55,56,57,58)] , nfactors = 4,symmetric=FALSE, rotate = "varimax", fm = "wls",max.iter = 500)
noRaceLoadings <- friskACSfactorise1[,c(1,11,12,13,14,16,17,18,19,20,29,53,54,55,56,57,58)]
noRaceLoadings <- sqldf('select distinct * ,count(*) as stops from noRaceLoadings group by BoroCT2010')
raceLoadings <- friskACSfactorise1[,c(1,2,3,5,7,65,67,69,73,11,12,13,14,16,17,18,19,20,29,53,54,55,56,57,58)]
raceLoadings <- sqldf('select distinct * ,count(*) as stops from raceLoadings group by BoroCT2010')
write.csv(raceLoadings,file='data/raceLoadings.csv',row.names=FALSE)
write.csv(noRaceLoadings,file='data/noRaceLoadings.csv',row.names=FALSE)
###############################################################################
setwd(dir = '~/stop-frisk-analysis/')



require(sqldf)
load('data/frisk.RData')
library('psych')
library('GPArotation')
friskACS <- frisk[,c(132,193:440,3)]
friskACS <-  sqldf('select * , count(*) as noOfStops from friskACS group by BoroCT2010')                        
friskACSfactorise <- friskACS[,c(2:251)]                        
#friskACSfactorise <- friskACS[,c(1,seq(14,74,by=2),92,102,106,seq(169,179,by=2),seq(214,242,by=2))]
#friskACSfactorise <- as.data.frame(scale(friskACSfactorise))
#friskACSfactorise1 <- friskACSfactorise[,c(seq(15,23,by=2),seq(29,37,by=2),seq(91,99,by=2),seq(111,121,by=2),103,168,172,176,178,214,221,seq(223,239,by=4))]                        
#friskACSfactorise1 <- friskACS[,c(1,16,18,22,30,seq(48,56,by=2),58,64,66,68,74,92,106,108,seq(76,90,by=2),167,171,175,179,215,216:220,222,250)]                        
friskACSfactorise1 <- friskACS[,c(1,2,133,16,18,20,22,24,26,28,30,seq(48,56,by=2),58,64,66,68,74,92,106,108,seq(76,90,by=2),167,171,175,179,215,222,250,251)]                        
friskACScollapsed <- sqldf('select *,ACS_p_american_indian+ACS_p_asian+ACS_p_hawaiian+ACS_p_other_race as ACS_p_otherRaces,ACS_p_edu_grad_HS+ACS_p_edu_associate_degree as someEdu,ACS_p_edu_bachelor_degree+ACS_p_edu_graduate_degree as collegeDegree from friskACSfactorise1')
friskACSfactorise2 <- friskACScollapsed[rowSums(is.na(friskACScollapsed)) <1, ]
friskACSfactorise3 <- as.data.frame(friskACSfactorise2[,1])
friskACSfactorise2 <- friskACSfactorise2[,c(2:ncol(friskACSfactorise2))]
#friskACSfactorise1 <- friskACSfactorise1[c(2:nrow(friskACSfactorise1)),]
#friskACSfactorise2 <- friskACSfactorise1[complete.cases(friskACSfactorise1),]
fa.parallel(friskACSfactorise2[,c(2,4,16,17,27,28,29,30,32)])
solution <- factanal(x = friskACSfactorise2[,c(6,2,21,22,40,41,42,43,44,57)], factors =6 , rotation = "varimax", fm = "wls",max.iter = 500)                        
solution <- factanal(x = friskACSfactorise2[,c(6,2,21,22,40,41,42,43,44,57)], factors =6 , rotation = "varimax", fm = "wls",max.iter = 500)                        
solution <- factanal(x = friskACSfactorise2[,c(2,3,4,6,7,10,15,16,17,30,32)], factors =5, rotation = "varimax", fm = "wls",max.iter = 500)                        
solution <- fa(r = friskACSfactorise2[,c(2,3,4,6,7,10,15,16,17,30,31)], nfactors = 3, rotate = "varimax", fm = "minres",max.iter = 500)
solution[37]
save(solution,file = 'data/factorAnalysis1.RData')
write.csv(friskACSfactorise2,file='data/acsTract.csv',row.names=FALSE)
#####################################################################################
stopByrace <-  sqldf('select distinct BoroCT2010,race_1,count(*) as count from frisk group by BoroCT2010,race_1')
popByRace <- sqldf('select distinct BoroCT2010,ACS_p_white,ACS_p_black,ACS_p_hispanic,ACS_p_american_indian+ACS_p_asian+ACS_p_hawaiian+ACS_p_hawaiian as other from frisk group by boroCT2010')                        
popByRace[,5] <- as.numeric(popByRace[,5])
popByRace <- popByRace[rowSums(is.na(popByRace)) <1,]
stopByrace <- stopByrace[rowSums(is.na(stopByrace))< 1, ]
write.csv(stopByrace,file='data/stopByrace.csv',row.names =FALSE)
write.csv(popByRace,file='data/popByRace.csv',row.names=FALSE)
######
require(sqldf)
load('data/frisk.RData')
library('psych')
library('GPArotation')
friskACS <- frisk[,c(132,193:440,3)]
friskACS <-  sqldf('select distinct * , count(*) as noOfStops from friskACS group by BoroCT2010')                        
friskACSfactorise1 <- friskACS[,c(1,2,133,16,18,20,22,24,26,28,30,seq(48,56,by=2),58,64,66,68,74,92,106,108,seq(76,90,by=2),167,171,175,179,215,222,250,251)]                        
friskACSfactorise1 <- friskACSfactorise1[rowSums(is.na(friskACSfactorise1)) <1, ]
friskACScollapsed <- sqldf('select *,ACS_p_american_indian+ACS_p_asian+ACS_p_hawaiian+ACS_p_other_race as ACS_p_otherRaces,ACS_p_edu_grad_HS+ACS_p_edu_associate_degree as someEdu,ACS_p_edu_bachelor_degree+ACS_p_edu_graduate_degree as collegeDegree from friskACSfactorise1')

ind = c(2:38,40:43)
friskACScollapsed[,43]<- as.numeric(friskACScollapsed[,43])
friskACScollapsed[,41]<- as.numeric(friskACScollapsed[,41])
friskACScollapsed[,42]<- as.numeric(friskACScollapsed[,42])

for(i in 1:40){
  friskACScollapsed[,ind[i]] <- scale(friskACScollapsed[,ind[i]])
  
}
for(i in 1:40){
  friskACScollapsed[,ind[i]] <- friskACScollapsed[,ind[i]] * friskACScollapsed[,2]
  
}
names(friskACScollapsed)
save(friskACScollapsed,file='data/normalisedfriskData.RData')
write.csv(friskACScollapsed,file='data/acsTract.csv')
solution <- fa(r = friskACScollapsed[,c(5,11,41,42,43,22,17,37,38,23)], nfactors = 4, rotate = "varimax", fm = "minres",max.iter = 500)
# names(friskACScollapsed)
#######################
data <- read.csv(file='data/kmeansData.csv',header = TRUE,stringsAsFactors = FALSE)
labels <- read.csv(file='data/kmeans.csv',header=TRUE,stringsAsFactors = FALSE)
#pct <- sqldf('select distinct PCT from friskACScollapsed2 order by PCT')
pct <- sqldf('select distinct PCT from stopsTractPCT order by PCT')
labelledData <- as.data.frame(cbind(pct[,1],data[,2],data[,3],data[,4],labels[,2]))
colnames(labelledData) <- c('PCT','blackStopRatio','HispanicStopRatio','label')
write.csv(labelledData,file='../Downloads/stop-frisk-analysis/data/kmeans/K4PrecinctStopRatio.csv')
library(scatterplot3d)
labelledData[,5] <- labelledData[,5] + 1
plot(data[,2],data[,4],col = c("red","blue","green","black")[labelledData[,5]])
plot(labelledData[,2],data[,3],col = c("violet","skyblue3","orange","red","blue","green","black","yellow","pink","gainsboro")[labelledData[,4]])

#citizenIncomeStopsCrime no useful
#do blackCrime,HispanicCrime,stopCrime again
#stopCrime use K = 3
#blackCrime use K = 3

#########
crimeData <- read.table('data/SFCombinedData.csv',header=TRUE,stringsAsFactors=FALSE,sep=',')
crimeData <- as.data.frame(cbind(crimeData[,1],crimeData[,55]))
#crimeData[,2] = scale(crimeData[,2])
colnames(crimeData) <- c('PCT','crimeRate')
friskACScollapsed1 <- friskACScollapsed
friskACScollapsed2 <- merge(x = friskACScollapsed1,y = crimeData,by.x ='PCT',by.y='PCT')
write.csv(friskACScollapsed2,file='data/acsTract.csv',row.names=FALSE)
# stops profiling
##################
##################
stopsData <- read.table('data/stopsProfiling.csv',header = TRUE,sep = '\t')
tractPCT <- sqldf('select distinct BoroCT2010,PCT from frisk')
stopsTractPCT <- merge(x = stopsData,y =tractPCT,by.x = 'BoroCT2010',by.y='BoroCT2010')
stopsTractPCT <- merge(x = stopsTractPCT, y = crimeData,by.x = 'PCT',by.y = 'PCT')
stopsstops <- sqldf('select PCT, count(*) as count, sum(white),sum(black),sum(hispanic),sum(other),sum(crimeRate) from stopsTractPCT group by PCT')
stopsstops1 <- stopsstops
stopsstops1[,3] <- stopsstops[,3]/stopsstops[,2]
stopsstops1[,4] <- stopsstops[,4]/stopsstops[,2]
stopsstops1[,5] <- stopsstops[,5]/stopsstops[,2]
stopsstops1[,6] <- stopsstops[,6]/stopsstops[,2]
stopsstops1[,7] <- stopsstops[,7]/stopsstops[,2]
stopsTractPCT[,4] <- stopsTractPCT[,4]/max(stopsTractPCT[,4])
stopsTractPCT[,5] <- stopsTractPCT[,5]/max(stopsTractPCT[,5])
stopsTractPCT[6] <- stopsTractPCT[,6]/max(stopsTractPCT[,6])
stopsTractPCT[,7] <- stopsTractPCT[,7]/max(stopsTractPCT[,7])
write.table(stopsstops1,file = 'data/stopTractPCT2.csv',row.names=FALSE,col.names=FALSE,sep=',')

write.csv(stopsTractPCT,file = 'data/stopTractPCT1.csv',row.names=FALSE)
#######################################################
K1 <- read.table('../Downloads/stop-frisk-analysis/data/kmeans/K3PrecinctNonRace.csv',header = TRUE, sep = ',')
K2 <- read.table('../Downloads/stop-frisk-analysis/data/kmeans/KMeansRace.csv',header = TRUE, sep = ',')
K11 <- K1[,c(1,6)]
K22 <- K2[,c(1,5)]
colnames(K11) <- c('PCT','label')
colnames(K22) <- c('PCT','label')
frisk <- friskACScollapsed2[,c(1,6,12,5,23,37,44)]
colnames(frisk) <- c ('PCT','black','hispanic','other','poverty','perCapitaIncome','crimeRate')
kmeansNonRace <- merge(x = K11,y=frisk,by.x='PCT',by.y='PCT')
kmeansRace <- merge(x = K22,y=frisk,by.x='PCT',by.y='PCT')
kmeansRace1 <- sqldf('select label , AVG(black),AVG(hispanic),AVG(other) from kmeansRace group by label')
kmeansRace2 <- sqldf('select label , AVG(black),AVG(hispanic),AVG(other) from kmeansNonRace group by label')
