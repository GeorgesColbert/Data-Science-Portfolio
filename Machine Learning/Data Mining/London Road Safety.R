library(readr)
Accidents0514 <- read_csv("~/Desktop/Data Mining-758T/DATA/Stats19_Data_2005-2014/Accidents0514.csv")
Casualties0514 <- read_csv("~/Desktop/Data Mining-758T/DATA/Stats19_Data_2005-2014/Casualties0514.csv")

# What fraction of accidents occur in urban areas? Report the answer in decimal form.
df <- as.factor(Accidents0514$Urban_or_Rural_Area)

urban_accidents <- table(df)

urban_accidents <- as.matrix(urban_accidents)

U.R <- c("Urban", "Rural", "Unallocated")

rownames(urban_accidents) <- U.R

totalU.R. <- colSums(urban_accidents)

 urban_accidents<-rbind(urban_accidents,totalU.R.)

 
options(digits = 10) 
 
urban_accidents[1,1]/urban_accidents[4,1]

######There appears to be a linear trend in the number of accidents that occur each year.
####What is that trend? Return the slope in units of increased number of accidents per year.


n.accidents <- Accidents0514$Date

n.accidents.year <- substring(n.accidents,7,10)

n.accidents.year <- as.factor(n.accidents.year, ordered = TRUE)

t.accidents.year <- table(n.accidents.year)
t.accidents.year <- as.data.frame(t.accidents.year)

t.accidents.year$n.accidents.year = as.numeric(as.character(t.accidents.year$n.accidents.year))

m1 <- lm(formula = Freq~n.accidents.year, data = t.accidents.year)

summary(m1)

plot(m1)

######## When is the most dangerous time to drive?
###Find the hour of the day that has the highest occurance of fatal accidents,
######normalized by the total number of accidents that occured in that hour.

t.accidents <- substring(Accidents0514$Time,1,2)

f.accidents <- Accidents0514$Accident_Severity

f_or_not <- as.data.frame(cbind(t.accidents,f.accidents))

fatal.a <- subset(f_or_not, f.accidents == "1")

table(fatal.a)

table(t.accidents)

1457/145399

#######How many times more likely are accidents involving male car drivers to be fatal compared to accidents involving female car drivers? 
######The answer should be the ratio of fatality rates of males to females



Vehicles0514 <- read_csv("~/Desktop/Data Mining-758T/DATA/Stats19_Data_2005-2014/Vehicles0514.csv")

Car <- subset(Vehicles0514, Vehicle_Type ==9)

F.Car <- subset(Accidents0514, Accident_Severity ==1)


L <- F.Car$Accident_Index

M_to_F <- Car[match(L,Car$Accident_Index),]

table(M_to_F$Sex_of_Driver)

1324605/757637

############### How many times more likely are you to be in an accident where you skid, jackknife, or overturn 
############## (as opposed to an accident where you don't) when it's raining or snowing compared to nice weather with no high winds?

##When its Raning or Snowing
W.Acc <- subset(Accidents0514, Weather_Conditions!= 9 & Weather_Conditions != -1)

R_S <- subset(W.Acc, Weather_Conditions %in% c(2,3,5,6))

M <- R_S$Accident_Index

Skid_R <- Vehicles0514[match(M,Vehicles0514$Accident_Index),]

table(Skid_R$Skidding_and_Overturning)


### When it's not raining or snowing

R_N <- subset(W.Acc, Weather_Conditions == 1)

N <- R_N$Accident_Index

Skid_N <- Vehicles0514[match(N,Vehicles0514$Accident_Index),]

table(Skid_N$Skidding_and_Overturning)

###Calculate Odds Ratio

(66929/165475)/(200325/1108811)


####### Do accidents in high-speed-limit areas have more casualties? 
####### Compute the Pearson correlation coefficient between
####### the speed limit and the ratio of the number of casualties to accidents for each speed limit.
#####    Pearson Correlation Coeficcient 

speed10 <- subset(Accidents0514, Speed_limit == 10)

speed15 <- subset(Accidents0514, Speed_limit == 15)

speed20 <- subset(Accidents0514, Speed_limit == 20)

speed30 <- subset(Accidents0514, Speed_limit == 30)

speed40 <- subset(Accidents0514, Speed_limit == 40)

speed50 <- subset(Accidents0514, Speed_limit == 50)

speed60 <- subset(Accidents0514, Speed_limit == 60)

speed70 <- subset(Accidents0514, Speed_limit == 70)

speed.bin <- as.data.frame(table(Accidents0514$Speed_limit))

Sum_Dead <- c(sum(speed10$Number_of_Casualties),sum(speed15$Number_of_Casualties),sum(speed20$Number_of_Casualties),sum(speed30$Number_of_Casualties),
              sum(speed40$Number_of_Casualties),sum(speed50$Number_of_Casualties),
              sum(speed60$Number_of_Casualties),sum(speed70$Number_of_Casualties))
speed.bin <- cbind(speed.bin, Sum_Dead)

speed.bin$Ratio <- speed.bin$Sum_Dead / speed.bin$Freq

speed.bin$Var1 <- as.numeric(speed.bin$Var1)

cor(speed.bin$Var1,speed.bin$Ratio)




