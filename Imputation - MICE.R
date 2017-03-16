############### Imputation using MICE Package

#MICE (Multivariate Imputation via Chained Equations) 
data(package = .packages(all.available = TRUE))

library(car)

data(Salaries)
salaries<-as.data.frame(Salaries)
class(salaries)
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


#Alternatively, we can impute random variables using missforest package prodNA function

salaries2<-as.data.frame(Salaries)
anyNA(salaries2)

install.packages("missForest")

library(missForest)

salaries2<-prodNA(salaries, noNA=0.1)
anyNA(salaries2)
colSums(is.na(salaries2))

###  Now, we have added missing values. 

install.packages("mice")
library(mice)

md.pattern(salaries)


#Visual representation of missing values using VIM

library(VIM)
mice_plot <- aggr(salaries, col=c('navyblue','yellow'),
                    numbers=TRUE, sortVars=TRUE,
                    labels=names(salaries), cex.axis=.7,
                    gap=3, ylab=c("Missing data","Pattern"))


#Impute Missing values 

salaries_Mice<-mice(salaries, m=5, maxit = 50)
summary(salaries_Mice)

salariesnoNA <- complete(salaries_Mice) #by default complete function will cosidere the first dataset
anyNA(salariesnoNA)

# m=5 indicates 5 datasets are created. We can select any dataset by passing number in complete func

salariesnoNA2 <- complete(salaries_Mice, 2)
anyNA(salariesnoNA)


