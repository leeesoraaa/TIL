# 데이터 정제: 이상치와 결측치 처리
## 결측치(missing value): 누락된 값
### is.na()
### na.omit(): NA 가 존재하는 행 자체를 제거
### na.rm = T/F: NA 제거 (옵션)

str(airquality)
head(is.na(airquality))
table(is.na(airquality))
table(is.na(airquality$Temp))
table(is.na(airquality$Wind))
table(is.na(airquality$Ozone))

mean(airquality$Temp)
mean(airquality$Ozone)

## Ozone에 결측값이 아닌 관측데이터만 추출
air_narm <- airquality[!is.na(airquality$Ozone),]
air_narm
mean(air_narm$Ozone)

air_omit <- na.omit(airquality)
air_omit
mean(air_omit$Ozone)

mean(airquality$Ozone, na.rm=T)

## 이상치(outlier)
patients <- data.frame(name = c('환자1', '환자2', '환자3', '환자4', '환자5'),
                       age=c(22,30,41,27,38),
                       gender = factor(c('M','F','M','K','F')),
                       blood.type = factor(c('A','O','B','AB','C'))) 
patients
str(patients)

### 성별에서 이상치를 제거하고 추출
patients_omit <- patients[patients$gender == 'M' | patients$gender== 'F',]
patients_omit

### 성별과 혈액형의 이상치를 제거하고 추출
patients_outlier <- patients[(patients$gender == 'M'| patients$gender == 'F') &
                               (patients$blood.type == 'A'|
                               patients$blood.type == 'B'|
                               patients$blood.type == 'AB'|
                               patients$blood.type == 'O'),]
patients_outlier

patients1 <- data.frame(name = c('환자1', '환자2', '환자3', '환자4', '환자5'),
                       age=c(22,30,41,27,38),
                       gender = c(1,2,1,3,2),
                       blood.type = c(1,3,2,4,5))
patients1

## 성별의 이상치를 결측치 처리
table(patients1$gender)
patients1$gender <- ifelse(patients1$gender > 2, NA, patients1$gender)
patients1

## 혈액형의 이상치를 결측치 처리
patients1$blood.type <- ifelse(patients1$blood.type > 4, NA, patients1$blood.type)

## 이상치를 판단하기 어려운 데이터의 처리
boxplot(airquality[,1:4])
boxplot(airquality[,1])$stats

## Ozone 컬럼에 이상치를 찾아 결측처리
### 사본생성
air <- airquality
air$Ozone <- ifelse(air$Ozone < 1.0 | air$Ozone > 122.0, NA, air$Ozone)
air$Ozone
table(is.na(air$Ozone))

## cars 데이터셋의 dist 이상치를 제거한 후 dist 평균을 계산하시오.
### 단, 이상치의 판단은 boxplot을 이용할 것
str(cars)
boxplot(cars$dist)$stats
car <- cars
car$dist <- ifelse(car$dist < 2 | car$dist > 93, NA, car$dist)
mean(car$dist, na.rm=T)

## ChickWeight 데이터에서 병아리 무게의 이상치를 제거한 후 평균 무게를 구하시오.
### 단 이상치의 판단은 boxplot을 이용할 것.
ChickW <- ChickWeight
boxplot(ChickW$weight)$stats
ChickW$weight <- ifelse(ChickW$weight <35|ChickW$weight>309, NA, ChickW$weight)
mean(ChickW$weight, na.rm=T)






















