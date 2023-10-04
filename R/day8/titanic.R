# classfication 과 classifier: 분류- 분류(지도학습)와 군집(비지도학습)

# 필요 패키지 설치 및 로딩 (필수 패키지)
library(ggplot2)
library(dplyr)

# 데이터 불러오기와 데이터 확인 패키지
install.packages('readr')
install.packages('descr')
library(readr)  # read_csv
library(descr)

# 데이터 불러오기
train<- readr::read_csv('C:/k-digital/data/Titanic/train.csv')
test <- readr::read_csv('C:/k-digital/data/Titanic/test.csv')

head(train)
head(test)
str(train)

full <- dplyr::bind_rows(train, test)   # rbind와 cbind
## rbind는 행을 무조건 합침 // bind_rows 는 속성이 한 두개 빠졌을 때 유용

str(full)

names(train)
names(test) ## Survives 컬럼이 없으므로 bind_rows로 합침
## PassengerID
## Survived: 생존여부 0(사망), 1(생존)
## Pclass: 선실 등급 1, 2, 3
## Name: 대표 승객 이름
## Sex: 대표 승객 성별
## Age: 대표 승객 나이
## SibSp: 동반 가족 수(형제 또는 배우자)
## Parch: 동반 가족 수(부모 또는 자녀)
## Ticket: 티켓번호
## Fare: 승선 요금
## Cabin: 선실
## Embarked 승선항 C, Q, S

# 사본 titanic
titanic <- train[,c('Survived', 'Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Embarked')]
titanic

# 변수 속성 변경
table(titanic$Survived)
table(titanic$Pclass)
table(titanic$Embarked)
titanic <- titanic %>%
  dplyr:: mutate(Survived = factor(Survived), 
                 Pclass = factor(Pclass),
                 Sex = factor(Sex),
                 Embarked = factor(Embarked))

str(titanic)
titanic <- as.data.frame(titanic)

summary(titanic)

# 전처리: 결측치와 이상치 처리
table(is.na(titanic$Embarked))
sapply(titanic, FUN = function(x){sum(is.na(x))}) # 모든 컬럼의 결측값 확인

titanic

## 결측치 대체 - 보간법
### Age: 결측값을 평균값으로 대체
age_mean <- mean(titanic$Age, na.rm=T)
titanic$Age <- ifelse(is.na(titanic$Age) == T, age_mean, titanic$Age)

### Embarked: 결측값을 최빈값으로 대체
titanic$Embarked <- ifelse(is.na(titanic$Embarked) == T, levels(titanic$Embarked) == "S", titanic$Embarked)  
titanic$Embarked
which.max(table(titanic$Embarked))
mode(titanic$Embarked)
str(titanic)
levels(titanic$Embarked)
# 문제정의
## 1. 생존 비율 - 사망과 생존의 비율
survival <- ggplot(titanic, aes(x= Survived, width=0.8)) + geom_bar()
survival

## 2. 성별에 따른 생존 비율
titanic %>% 
  group_by(Sex) %>% 
  summarise(mean = mean(Survived))

gender <- ggplot(train, aes(x=Survived, fill=Sex, width=0.8)) +
  geom_bar()
gender

## 3. 선실 등급에 따른 생존 비율
Pclass <- ggplot(Pclass_survivor, aes(x= Pclass, y=survivor)) + geom_col()
Pclass
Pclass_survivor <- titanic %>% 
  filter(Survived==1) %>% 
  group_by(Pclass) %>% 
  summarise(survivor = n())
### 1등급 칸이 가장 많이 생존

## 4. 동반 가족 수에 따른 생존 비율
num <- titanic$SibSp + titanic$Parch
titanic$family_num <- num
str(titanic)
as.factor(num)
family_suvivor <- titanic %>% 
  group_by(family_num) %>% 
  summarise(mean = mean(Survived))


## 5. 승선항에 따른 생존 비율

# 분류 분석(Classification Analysis)
## 학습을 통해 분류 모델을 학습하고 이를 통해 분류 예측하는 분석 기법
## 의사 결정 트리(Decision Tree), 나이브 베이스 분류, 신경망(ANN), 서포트 벡터(SVM)
























