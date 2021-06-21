
Data1=read.csv("C:/Users/YOULA Mohamed/Desktop/Data mining Arras/Absenteeism_at_work.csv",sep=';',dec='.', header=TRUE)
Data1[,1]<-as.factor(Data1[,1])
Data1[,2]<-as.factor(Data1[,2])
Data1[,3]<-as.factor(Data1[,3])
Data1[,4]<-as.factor(Data1[,4])
Data1[,5]<-as.factor(Data1[,5])
Data1[,12]<-as.factor(Data1[,12])
Data1[,13]<-as.factor(Data1[,13])
Data1[,15]<-as.factor(Data1[,15])
Data1[,16]<-as.factor(Data1[,16])
str(Data1)

par(mfrow=c(1,2))
boxplot(Data1$Absenteeism.time.in.hours,col = "orange",xlab = " ",ylab = "Temps d'absentéisme",
        main = "Avec outliers")
outlier_val<-boxplot.stats(Data1$Absenteeism.time.in.hours)$out
outlier_val
outlier_idx <-which(Data1$Absenteeism.time.in.hours%in% c(outlier_val))
outlier_idx
Data2<-Data1[-outlier_idx,]
boxplot(Data2$Absenteeism.time.in.hours,col = "orange",xlab = " ",ylab = "Temps d'absentéisme",
        main = "Sans outliers")

Data3<-Data1[outlier_idx,]
summary(Data1)



learn_test<-function(data,j){ # fonction pour créer un échantillon test et un échantillon d'apprentissage
  t <- sample(nrow(data), 0.3*nrow(data), replace = FALSE) # 30% d'observations pour l'échantillon test
  test<-data[t,j] # échantillon test
  train<-data[-t,j] # échantillon d'apprentissage
  list(train=train,test=sort(test))
}
ll<-learn_test(Data1,21)
##########################################
tt1<-tube_hist(ll,B =50)
b1 <- baseboot(data$test, tt1$punctual, tt1$bunch)
#Représentation graphique
par(mfrow=c(1,3))
matplot(ll$test, t(tt1$bunch),type='l',col = "grey", lty = 1,xlab="Absenteeism.time.in.hours", ylab="Densité",main="Histogramme")
matlines(ll$test, tt1$punctual,type='l', col = 2, lwd = 2)
matlines(ll$test, t(b1), col = 4, lty =1, lwd = 1)
legend("topleft",c("Boostraps_hist","BagHist","Bande_de_variabilité"),lty="solid",lwd=c(1,1,1),
       col=c("grey","red","blue"), bty="n")
#----------
tt2 <- tube_fp(ll,B =50)
# Représentation graphique
b2 <- baseboot(data$test, tt2$punctual, tt2$bunch)
matplot(ll$test, t(tt2$bunch),type='l',col = "grey", lty = 1,xlab="Absenteeism.time.in.hours", ylab="Densité",main="Polygone de
fréquence")
matlines(ll$test, tt2$punctual,type='l', col = 2, lwd = 2)
matlines(ll$test, t(b2), col = 4, lty =1, lwd = 1)
legend("topleft",c("Bootstrap_FP","BagFP","Bande_de_variabilité"),lty="solid",lwd=c(1,1,1),
       col=c("grey","red","blue"), bty="n")
#----------
tt3 <- tube_KDE(ll,B =50)
# Représentation graphique
b3 <- baseboot(data$test, tt3$punctual, tt3$bunch)
matplot(ll$test, t(tt3$bunch),type='l',col = "grey", lty = 1,xlab="Absenteeism.time.in.hours", ylab="Densité",main="Estimateur à noyau")
matlines(ll$test, tt3$punctual,type='l', col = 2, lwd = 2)
matlines(ll$test, t(b3), col = 4, lty =1, lwd = 1)
legend("topleft",c("Bootstrap_KDE","BagKDE","Bande_de_variabilité"),lty="solid",lwd=c(1,1,1),
       col=c("grey","red","blue"), bty="n")
########
#Métrique pour l'histogramme
B1<-t(b1) # bande de variabilité
N1=nrow(B1)
S11=sum(B1[,1]) # bord inférieur de la bande de variabilité
S21=sum(B1[,2]) # bord supérieur de la bande de variabilité
metric_hist<-(S21-S11)/N1 # calcul de la métrique
metric_hist
#-----------
# Métrique pour le polygone de fréquence
B2<-t(b2) # bande de variabilité
N2=nrow(B2)
S12=sum(B2[,1]) # bord inférieur de la bande de variabilité
S22=sum(B2[,2]) # bord supérieur de la bande de variabilité
metric_fp<-(S22-S12)/N2 # calcul de la métrique
metric_fp
#-----------
# Métrique pour kde
B3<-t(b3) # bande de variabilité
N3=nrow(B3)
S13=sum(B3[,1]) # bord inférieur de la bande de variabilité
S23=sum(B3[,2]) # bord supérieur de la bande de variabilité
metric_kde<-(S23-S13)/N3 # calcul de la métrique
metric_kde
##############################################################################################

m<-mean(Data2[,21])
for(i in 1:nrow(Data2)){
  if(Data2[i,21]<=m)
    Data2[i,21]<-"A"
  else
    Data2[i,21]<-"B"

}
str(Data2)


summary(Data2[,21])












