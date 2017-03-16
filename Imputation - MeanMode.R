############# MISSING VALUE IMPUTATION

##Create a random data set for testing

set.seed(200)
visits<-round(runif(n = 500, min = 0, max = 1000))
conv<-sample(c(1:100), 500, replace = T)
medium<- sample(c("Organic", "CPC", "Direct", "Referral", "Display", "Email"), 500, replace = T)
Device<- sample(c("Mobile", "Tablet", "Desktop"), 500, replace = T)
os<-sample(c("Andriod", "iOS", "Windows"), 500, replace = T)
revenue<-runif(n = 500, min = 0, max = 10000)

## Adding missing values
visits[sample(1:length(visits), 50)]<-NA
conv[sample(1:length(conv), 35)]<-NA
medium[sample(1:length(medium), 75)]<-NA
Device[sample(1:length(Device), 25)]<-NA

##Create dataframe
data<-data.frame(medium, Device, os, visits, conv, revenue, stringsAsFactors=FALSE)

#check for NA
anyNA(data)
summary(data)


########################## Simple Imputation with Mean and Mode

summary(data)

data$visits[is.na(data$visits)]<-mean(data$visits, na.rm = T)
data$conv[is.na(data$conv)]<-mean(data$conv, na.rm = T)
data$os[is.na(data$os)]<-'iOS'
data$Device[is.na(data$Device)]<-'Mobile'

## Since medium has more than 10% of the missing values, we can impute missing values as new level
data$medium[is.na(data$medium)]<-"Other"


na<-which(is.na(data$medium))
data$medium[na]<-"Other"

#check for NA
anyNA(data)
summary(data)

############ Imputation using Hmisc package

library(Hmisc)

data$visits<-impute(data$visits,mean)

