#Park Quality and Real Estate Value

#Library
library(dplyr)
library(kernlab)
library(rpart)
library(randomForest)
library(e1071)

#Load Data
park    <- read.csv("~/Amazon Drive/ML 2017/park_pluto_score.csv")
quality <- read.csv("~/Amazon Drive/ML 2017/park_pluto_score.csv")

#Name of Variable 
names(park)

#Select Columns
clean_parkdata <- park %>%
                  select(signname, AssessTot, acres, LotArea, BldgArea, ResArea, NumFloors, UnitsRes, UnitsTotal, YearBuilt,
                         Inspections_Inspection_OverallCondition, Inspections_Inspection_Cleanliness, Inspections_Inspection_Cleanliness_Glass,
                         Inspections_Inspection_Cleanliness_Graffiti, Inspections_Inspection_Cleanliness_Litter, Inspections_Inspection_Cleanliness_Weeds, 
                         Inspections_Inspection_Landscape_Trees, Inspections_Inspection_Landscape, Inspections_Inspection_OverallCleanliness,
                         Inspections_Inspection_OverallCondition, Inspections_Inspection_Structural,
                         Inspections_Inspection_Structural_Benches, Inspections_Inspection_Structural_Fences, 
                         Inspections_Inspection_Structural_PavedSurfaces, Inspections_Inspection_Structural_PlayEquipment,
                         Inspections_Inspection_Structural_SafetySurface, Inspections_Inspection_Structural_Sidewalks)

#Add Zero to all NA                  
clean_parkdata[is.na(clean_parkdata)] <- 0

#Create an average score
clean_parkdata$Average <- rowMeans(clean_parkdata[10:25])

#Export Data
#write.csv(clean_parkdata, file = "/Users/alexismsoto-colorado/Amazon Drive/park_cleandata.csv")

##CLUSTER
kmeans.result <- kmeans(clean_parkdata, centers=3)

#To view the results of the k-means cluster type the following command
kmeans.result$centers

#To obtain the cluster ID’s type the following command
kmeans.result$cluster

##Classificaiton

#___________________________________
#Run OLS 

fit_ols <- lm(AssessTot ~ acres + LotArea +  BldgArea +  ResArea + NumFloors +
            UnitsTotal + YearBuilt + Average, data = clean_parkdata)

summary(fit_ols)

#Root Means Squared Error (RMSE) Function
rmse <- function(error) {
  sqrt(mean(error^2))
}

#Predict Error
error_ols <- fit_ols$residuals
predictioRMSE_OLS <- rmse(erro)
#____________________________________
#SVM

fit <- ksvm(AssessTot ~ acres + LotArea +  BldgArea +  ResArea + NumFloors +
              UnitsTotal + YearBuilt + Average, clean_parkdata)


# make a prediction for each X
predictedY <- predict(fit, clean_parkdata)

# display the predictions
points(clean_parkdata$AssessTot, predictedY, col = "blue", pch=4)

#Calcuate error
error_svm <- clean_parkdata$AssessTot - predictedY
svrPredictionRMS <- rmse(error_svm)


#Keep it Simple a Do Classifier Problemm since predicitng price is not working great for the homework
svmfit <- svm(signname ~., data = clean_parkdata, kernel = "linear", cost = 0.1, scale = FALSE)
#print(svmfit)

#___________________________________
#Tree Regression
rt.model <- rpart(AssessTot ~ acres + LotArea +  BldgArea +  ResArea + NumFloors +
                    UnitsTotal + YearBuilt + Average, clean_parkdata)

printcp(rt.model) # display the results
plotcp(rt.model) # visualize cross-validation results
summary(rt.model) # detailed summary of splits


# plot tree 
#Tree will show only the relevant attributes
plot(rt.model, uniform=TRUE, main="Classification Tree for Park Quality Score Predict Residential Prices")
text(rt.model, use.n=TRUE, all=TRUE, cex=.8)

#_________________________________________
#Random Forest

forest <- randomForest::randomForest(AssessTot ~ acres + LotArea +  BldgArea +  ResArea + NumFloors +
                  UnitsTotal + YearBuilt + Average, clean_parkdata)



#______________________________________________________________________________
#Devide Data between Train and Test

# splitdf function will return a list of training and testing sets
splitdf <- function(dataframe, seed=NULL) {
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  list(trainset=trainset,testset=testset)
}

splits <-  splitdf(clean_parkdata, seed = 808)

#it returns a list - two data frames called trainset and testset
str(splits)

# there are 75 observations in each data frame
lapply(splits,nrow)

#view the first few columns in each data frame
lapply(splits,head)

# save the training and testing sets as data frames
training <- splits$trainset
testing <- splits$testset

##Ridge 

x <- as.matrix(training[ ,2:25])
y <- as.matrix(training[ ,1])

cv.ridge <- glmnet::cv.glmnet(x, y, family = "gaussian", alpha = 0)
plot(cv.ridge)
cv.ridge$lambda.min
cv.ridge$lambda.1se
coef(cv.ridge, s=cv.ridge$lambda.min)

##LASSO

##PCA


#_________________________________________________________________________
#SVM https://www.youtube.com/watch?v=ueKqDlMxueE

plot(iris$Petal.Length, iris$Petal.Width, col=iris$Species)
plot(clean_parkdata$Average,)

#col <- c("Petal.Length","Petal.Width", "Species")
#train <- train[,col]
#test  <- test[,col]

svmfit <- svm(Species ~., data = train, kernel = "linear", cost = 0.1, scale = FALSE)
print(svmfit)
plot(svmfit, train[,col])

#CV to find the best tune
tuned <- tune(svm, Species ~., data = train, kernel = "linear", 
              ranges = list(cost =c(0.001, 0.01, .1, 1.10, 100)))
summary(tuned)

#Predict 
default_predsv <- predict(svmfit, test[,col], type="class")
table(default_predsv, test[,3]) #Table to look in the predictor
mean(default_predsv == test[,3])

