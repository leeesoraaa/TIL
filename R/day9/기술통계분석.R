# 데이터의 기본 특성
## 범주형 변수의 빈도수, 상대도수 구하기
library(MASS)
### 절대 빈도수 구하기
data <- data.frame(Cars93)
str(data)
summary(data)
table(data$Manufacture)
install.packages('psych')
library(psych)
psych(data$Manufacturer)


### 상대도수 구하기: prop.table()
prop.table(summary(data$Manufacturer))
prop.table(table(data$Manufacturer)) * 100
round(prop.table(table(data$Manufacturer))*100,2)
paste0(round(prop.table(table(data$Manufacturer))*100,2), '%')
paste0('(',round(prop.table(table(data$Manufacturer))*100,2),'%)')

### 테이블 형태로 표현: 데이터와 빈도수 함께 추출
mf_p <- data.frame('Freq' = table(data$Manufacturer), 
           'Prop'= paste0(round(prop.table(
             table(data$Manufacturer))*100,2),
             '%'))
mf_p

## 연속형 변수의 평균, 표준편차 구하기
### summary(): 기초통계량
mean(data$Price)
sd(data$Price)
paste(round(mean(data$Price),1), '±', round(sd(data$Price),1))

## 기술통계 분석에 유용한 함수
install.packages('moonBook')
library(moonBook)
mytable(data)


















