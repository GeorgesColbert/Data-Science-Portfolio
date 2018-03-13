library(tidyr)
library(dplyr)
library(readr)
library(tree)
titan.train <- read_csv("Desktop/Projects/Kaggle/Titanic/train.csv")
titan.test <- read_csv("Desktop/Projects/Kaggle/Titanic/test.csv")

head(titan.train)


### check which columns have na values

colnames(titan.train)[ apply(titan.train, 2, anyNA) ]

###count number of na rows in those columns

sum(is.na(titan.train$Cabin))
sum(is.na(titan.train$Embarked))
sum(is.na(titan.train$Age))


############ drop cabin, give most common value to embarked and give them median age

titan.train$Cabin <- NULL

table(titan.train$Embarked)

titan.train <- titan.train%>% drop_na(Embarked)


titan.train <- titan.train %>% mutate_at(vars(Age), ~ifelse(is.na(.), median(., na.rm = TRUE), .))


########## create a variable that designates if they are a family/nuclear family

# 
titan.train$Miss_or_Not <- ifelse(grepl("Miss",titan.train$Name) & titan.train$Age > 18, 1,0 ) 


#Family unit or not

titan.train$FM_or_Not <- ifelse( titan.train$SibSp >=1 & titan.train$Parch >= 1,1,0)


titan.train$Ticket <- gsub("^.*\\s", "", titan.train$Ticket)

titan.train$Ticket <- as.numeric(titan.train$Ticket)

######## turn survived into a factor

titan.train$Survived <- factor(titan.train$Survived, levels = c(0,1))
titan.train$Pclass <- factor(titan.train$Pclass, levels = c(3,2,1), ordered = TRUE)
titan.train$Sex<- as.factor(titan.train$Sex)
titan.train$Embarked <- as.factor(titan.train$Embarked)
titan.train$Miss_or_Not <- as.factor(titan.train$Miss_or_Not)
titan.train$FM_or_Not <- as.factor(titan.train$FM_or_Not)

####### Remove name 

titan.train$Name <- NULL



###################### create a decision tree


set.seed(123)
inTrain <- sample(nrow(titan.train), 0.9*nrow(titan.train))
#
train <- data.frame(titan.train[inTrain,])
validation <- data.frame(titan.train[-inTrain,])

# Computing the error rate on validation data (full tree)

tree.titanic=tree(Survived~.-PassengerId,data=train)
tree.pred=predict(tree.titanic,validation,type="class")
confusion = table(tree.pred,validation$Survived)
confusion
Error = (confusion[1,2]+confusion[2,1])/sum(confusion)
Error

(accuracy <- (confusion[1,1]+confusion[2,2])/sum(confusion))

#############################################

Size <- 1:8
Error <- rep(0,length(Size))

# For tree with one terminal node the prediction is the modal class
table(validation$Survived)
# There are 40 "Yes" and 60 "High"
(Error[1] = 53/89)

library(caret)

for (i in 2:8) {
  prune.titanic=prune.misclass(tree.titanic,best=i)
  tree.pred=predict(prune.titanic,validation,type="class")
  confusion = table(tree.pred,validation$Survived)
  Error[i] = (confusion[1,2]+confusion[2,1])/sum(confusion)
}

plot(Size,Error,type = "o",xlab="Tree Size",ylab="Error Rate",col="blue")
(z = which.min(Error))
#


#####################################


colnames(titan.test)[ apply(titan.test, 2, anyNA) ]


###count number of na rows in those columns

sum(is.na(titan.test$Age))
sum(is.na(titan.test$Fare))
sum(is.na(titan.test$Cabin))


#### MAKE cabin null, median value for the Fare and median for the Age
titan.test$Cabin <- NULL

titan.test <- titan.test %>% mutate_at(vars(Age), ~ifelse(is.na(.), median(., na.rm = TRUE), .))

titan.test <- titan.test %>% mutate_at(vars(Fare), ~ifelse(is.na(.), median(., na.rm = TRUE), .))

# create Miss_or_Not and FM 

titan.test$Miss_or_Not <- ifelse(grepl("Miss",titan.test$Name) & titan.test$Age > 18, 1,0 ) 


#Family unit or not

titan.test$FM_or_Not <- ifelse( titan.test$SibSp >=1 & titan.test$Parch >= 1,1,0)

titan.test$Ticket <- gsub("^.*\\s", "", titan.test$Ticket)

titan.test$Ticket <- as.numeric(titan.test$Ticket)

######## turn survived into a factor

#stitan.test$Survived <- factor(titan.test$Survived, levels = c(0,1))
titan.test$Pclass <- factor(titan.test$Pclass, levels = c(3,2,1), ordered = TRUE)
titan.test$Sex<- as.factor(titan.test$Sex)
titan.test$Embarked <- as.factor(titan.test$Embarked)
titan.test$Miss_or_Not <- as.factor(titan.test$Miss_or_Not)
titan.test$FM_or_Not <- as.factor(titan.test$FM_or_Not)


####### Remove name 

titan.test$Name <- NULL




# Now plot the best pruned tree
prune.titanic=prune.misclass(tree.titanic,best=z)
plot(prune.titanic)
text(prune.titanic,pretty=0)
tree.pred=predict(prune.titanic,titan.test,type="class")

######## attach prediction to test set

titan.test$Survived <- tree.pred


Kaggle.submit <- titan.test %>% select("PassengerId", "Survived")

write.csv(Kaggle.submit, file = "Desktop/Projects/Kaggle/Titanic/Kagglesub6.csv", row.names=FALSE)










