#Park Quality and Real Estate Value

#Library
library(dplyr)

#Load Data
park    <- read.csv("~/Amazon Drive/ML 2017/park_pluto_score.csv")
quality <- read.csv("~/Amazon Drive/ML 2017/park_pluto_score.csv")

#Name of Variable 
names(park)

#Select Columns
clean_parkdata <- park %>%
                  select(AssessTot, acres, LotArea, BldgArea, ResArea, NumFloors, UnitsRes, UnitsTotal, YearBuilt,
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


#Run OLS 
fit <- lm(AssessTot ~ ., data = clean_parkdata)
summary(fit)

fit <- lm(AssessTot ~ acres + LotArea +  BldgArea +  ResArea + NumFloors +
            UnitsTotal + YearBuilt + Inspections_Inspection_OverallCondition, data = clean_parkdata)
summary(fit)

fit <- lm(AssessTot ~ acres + LotArea +  BldgArea +  ResArea + NumFloors +
            UnitsTotal + YearBuilt + Inspections_Inspection_OverallCleanliness + 
            Inspections_Inspection_Structural + Inspections_Inspection_Landscape, data = clean_parkdata)
summary(fit)


#Devide Data between 
# define training control
train_control <-caret::trainControl(method="cv", number=10)
# fix the parameters of the algorithm
grid <- expand.grid(.fL=c(0), .usekernel=c(FALSE))
# train the model
model <- caret::train(AssessTot ~ acres + LotArea +  BldgArea +  ResArea + NumFloors +
                 UnitsTotal + YearBuilt + Inspections_Inspection_OverallCondition, 
               data=clean_parkdata, trControl=train_control, method="ls", tuneGrid=grid)
# summarize results
print(model)

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



