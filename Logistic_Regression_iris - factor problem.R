# 함수 예습 #
?subset     # 데이터의 부분집합을 해당 조건에 맞게 추출한다.
    ?levels # 변수$컬럼의 factor 확인
    ?str    # 변수     의 속성 확인(num,factor,list,...)
?droplevels # 사용되지 않는 factor의 level들을 제거시킨다.



iris_data <- subset(iris, Species == "virginica" | Species == "versicolor",encoding = "UTF-8")
str(iris_data) # iris_data의 구조
levels(iris_data$Species)
iris_data$Species
str(iris_data) #versicolor,virginica 2개를 subset으로 추출했지만 
#factor가 3개로 그대로 남아있다.

##########################################################
####subset 시 factor가 3개에서 2개로 줄어들지 않을 때,####
##########################################################

#1. droplevels 함수 사용
levels(droplevels(iris_data$Species))
#이를 변수에 입력하면
iris_data2 <- droplevels(iris_data) # 변수$컬럼 지정없이 변수만 입력해도 가능.
str(iris_data2)

#1.1 droplevels 예시
aq <- transform(airquality, Month = factor(Month, labels = month.abb[5:9]))
aq <- subset(aq, Month != "Jul")
levels(aq$Month)
aq$Month<- droplevels(aq$Month,except="Jul")
levels(aq$Month)

#또는 
aq <- transform(airquality, Month = factor(Month, labels = month.abb[5:9]))
aq <- subset(aq, Month != "Jul")
table(           aq $Month)
table(droplevels(aq)$Month)
levels(aq$Month)

#2. gdata 패키지사용
install.packages("gdata")
library(gdata)

levels(iris_data$Species)
drop.levels(iris_data)
levels(drop.levels(iris_data)$Species)

#3. as.factor(as.character(변수$컬럼명))로 직접 변수변경
levels(iris_data$Species)
iris_data$Species <- as.factor(as.character(iris_data$Species))
levels(iris_data$Species)

#4. varFactor 사용
levels(iris_data$Species)
iris_data$Species  <- iris_data$Species[drop=T]
levels(iris_data$Species)

# 가장 단순한 방법은 변수$컬럼 <- factor(변수$컬럼)

iris_data$Species <- factor(iris_data$Species) 
str(iris_data)

iris_model <- glm(Species ~., data=iris_data, family="binomial") 
iris_model

f<-fitted(iris_model) 

a<-as.numeric(iris_data$Species). 

ifelse(f>.5, 1, 0) == as.numeric(iris_data$Species) - 1  

is_correct <- (ifelse(f>.5,1,0)==as.numeric(iris_data$Species)-1)

sum(is_correct) 

predict(iris_model, newdata = iris_data[c(1,10,55),],type="response") 

