############### Imputation using K-NN

## kNN (k-Nearest-Neighbourhood) is a supervised learning algorithm which is mainly used to Impute missing values
#k nearest neighbors is a simple algorithm that stores all available cases and classifies new cases by a majority 
# vote of its k neighbors. 

#To check datasets available in all packages, use the below command
data(package = .packages(all.available = TRUE))

library(car)

data(Salaries)
salaries<-as.data.frame(Salaries)
class(Salaries)
?Salaries
summary(salaries)
str(salaries)

#check for NA
anyNA(salaries)
colSums(is.na(salaries))

###No missing values found in the data.
###Lets insert missing values randomly

salaries$yrs.since.phd[sample(1:length(salaries$yrs.since.phd),30, replace=F)] <-NA
salaries[sample(1:nrow(salaries), 25, replace = F), "sex"] <-NA

#check for NA
anyNA(salaries)
colSums(is.na(salaries))

###  Now, we have added missing values. 
#Lets Impute with K-NN algorithm

library(VIM)

salaries1<-kNN(salaries, k=5, imp_var=F)
anyNA(salaries1)

## You can also specify column names where you want to impute

salaries2<-kNN(salaries, variable = c("yrs.since.phd", "sex"), k=5, imp_var=F)
anyNA(salaries2)




