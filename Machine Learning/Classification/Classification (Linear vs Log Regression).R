######### (1) Data Preparation  ##############


VPref <- read_csv("~/Desktop/Data Mining-758T/DATA/VoterPref-1.csv")


VPref$PREFERENCE <- factor(VPref$PREFERENCE, levels= c("For", "Against"), ordered = FALSE )

VPref$GENDER <- as.factor(VPref$GENDER)
Prefdummy <- as.numeric(ifelse(VPref$PREFERENCE == "Against", 1, 0))

VPref <- cbind(VPref, Prefdummy)

class(VPref$PREFERENCE)

set.seed(71923)

train <- sample(nrow(VPref),0.7*nrow(VPref))

VPref_train <- VPref[train,]

VPref_test <- VPref[-train,]

############# (2)	Exploratory analysis of the training data set  #############


boxplot(VPref_train$INCOME~VPref_train$PREFERENCE, main = "INCOME")

boxplot(VPref_train$AGE~VPref_train$PREFERENCE, main = "AGE")

table(VPref_train$PREFERENCE)

table(VPref_train$PREFERENCE, VPref_train$GENDER)

######### (3) Linear Regression############

##Computed the average error, RMSE, and MAE for both in-sample predictions and and the out-of-sample predictions  

m1 <- lm(formula = Prefdummy~AGE+INCOME+GENDER, data = VPref_train)

summary(m1)

predicted <- predict(m1, newdata = VPref_train)

actual <- VPref_train$Prefdummy

Metrics <- c("AE", "RMSE", "MAE", "SSE")

x1 <- mean(actual-predicted)
x2 <- sqrt(mean((actual-predicted)^2))
x3 <- mean(abs(actual-predicted))
x4 <- sum((actual-predicted)^2)

Values <- c(x1, x2, x3, x4)

X <- data.frame(Metrics, Values)

X
  
predicted2 <- predict(m1, newdata = VPref_test)

actual2 <- VPref_test$Prefdummy

Metrics <- c("AE", "RMSE", "MAE", "SSE")

xA <- mean(actual2-predicted2)
xB <- sqrt(mean((actual2-predicted2)^2))
xC <- mean(abs(actual2-predicted2))
xD <- sum((actual2-predicted2)^2)

Values <- c(xA, xB, xC, xD)

X2 <- data.frame(Metrics, Values)
  
X2
  
##### Use a cutoff of 0.5 and do the classification. 
#Compute the confusion matrix for both in-sample and out- of-sample predictions.  

INActual <- VPref_train$Prefdummy

predicted.probability <- predict(m1, type = "response") 

cutoff <- 0.5

INPredicted <- ifelse(predicted.probability > cutoff, 1, 0)

INConfusion <- table(INActual, INPredicted)

rownames(INConfusion) <- c("For", "Against")
colnames(INConfusion) <- c("For", "Against")

INConfusion

OUTActual <- VPref_test$Prefdummy

OUTpredicted.probability <- predict(m1, newdata = VPref_test, type = "response") 

cutoff <- 0.5

OUTPredicted <- ifelse(OUTpredicted.probability > cutoff, 1, 0)

OUTConfusion <- table(OUTActual, OUTPredicted)

rownames(OUTConfusion) <- c("For", "Against")
colnames(OUTConfusion) <- c("For", "Against")

OUTConfusion
  
######### (4) Logistic Regression Model ############

#Repeat Same process with a Logistical Regression

fit <- glm(PREFERENCE~AGE+INCOME+GENDER, data = VPref_train, family = "binomial")




LogINActual <- VPref_train$Prefdummy

predicted.probability <- predict(fit, type = "response") 

cutoff <- 0.5

LogINPredicted <- ifelse(predicted.probability > cutoff, 1, 0)

LogINConfusion <- table(LogINActual, LogINPredicted)

rownames(LogINConfusion) <- c("For", "Against")
colnames(LogINConfusion) <- c("For", "Against")

LogINConfusion

LogOUTActual <- VPref_test$Prefdummy

LogOUTpredicted.probability <- predict(fit, newdata = VPref_test, type = "response") 

cutoff <- 0.5

LogOUTPredicted <- ifelse(LogOUTpredicted.probability > cutoff, 1, 0)

LogOUTConfusion <- table(LogOUTActual, LogOUTPredicted)

rownames(LogOUTConfusion) <- c("For", "Against")
colnames(LogOUTConfusion) <- c("For", "Against")

LogOUTConfusion





