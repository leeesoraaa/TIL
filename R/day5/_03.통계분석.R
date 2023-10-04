# R을 이용한 통계분석: 기술통계분석과 추론통계분석

## 수치형자료를 분석하는 작업: 기술 통계량
x <- c(
  64, 84, 82, 81, 68, 85, 76, 89, 93,
  77, 66, 64, 86, 74, 64, 70, 53, 98, 
  59, 79, 57, 59, 65, 67, 80)

### 평균
mean(x)
### 중앙값
median(x)
### 최솟값, 최댓값
min(x)
max(x)

## A,B,C 식당의 배달시간을 이용해서 가장 배달이 빠른 식당 찾기
storeA <- c(20,21,23,22,26,28,35,35,41,42,43,45,44,45,46,47,47,46,47,58,58,59,60,56,57,57,80)
storeB<- c(5,6,11,13,15,16,20,20,21,23,22,27,27,30,30,32,36,37,37,40,40,43,44,45,51,54,70,600)
storeC<-c (5,5,5,12,10,11,20,20,20,20,20,21,20,30,32,31,31,31,36,40,40,51,61,51,61,61,70)

# A와 B 중 배달이 더 빠른 식당은?
mean(storeA)
mean(storeB)

median(storeA)
median(storeB)

quantile(storeA)
quantile(storeB)

# B 식당의 이상치를 제거한 후 배달시간
## boxplot
boxplot(storeB)
boxplot(storeA, storeB, names=c('A', 'B'))
points(c(mean(storeA), mean(storeB)), pch = 2, col='red',cex=2)
storeB <- storeB[storeB < 600]

mean(storeC)
boxplot(storeB, storeC, names=c('B','C'))

# 구간별 데이터의 분포를 확인하는 시각화 도구
## 히스토그램: 연속형 데이터, hist(데이터, main=차트제목, xlab, ylab)
## 막대 그래프: 이산형 데이터(범주형 데이터)

hist(storeB, main='B식당 배달 시간', xlab= '배달시간', ylab='건수')
hist(storeC, main='C식당 배달 시간', xlab= '배달시간', ylab='건수')

## 분산과 표준편차
## 첨도(뾰족한 정규분포)와 왜도(치우친 정규분포)
var(storeB)
var(storeC)

sd(storeB)
sd(storeC)

## B식당: 평균 배달 시간 30분, 15~45분
## C식당: 평균 배달 시간 30분, 12~48분

# 범주형 데이터의 분석: 파이차트, 막대그래프
bloodType <- c('A','B','A','AB','O','A','O','B','A','O','O','B','O','A','AB','B','O','A', 'A', 'B')
table(bloodType) # 도수분포표
length(bloodType)

## pie(데이터, 범주명, col, lty, main)
pie(table(bloodType))
pie(table(bloodType), labels=c('A형', 'AB형', 'B형', 'O형'),
    lty = 2,
    main='우리반 혈액형 분포도')
tb <- addmargins(table(bloodType)) # 전체 도수의 합계
tb

# 막대차트 barplot(height, names.arg, space, horiz=T/F, main, xlab, ylab, col, beside, xlim, ylim)
barplot(table(bloodType))
barplot(table(bloodType),
        names.arg = c('A형', 'AB형', 'B형', 'O형'),
        main='우리반 혈액형 분포도',
        xlab= '혈액형',
        ylab= '학생 수',
        col= c('lightcyan', 'pink', 'lightyellow' ,'skyblue'))

names <- c('aaa','bbb','ccc','ddd','eee','fff','ggg','hhh','iii','jjj','kkk','lll','mmm','nnn','ooo','ppp','qqq','rrr','sss','ttt')
> sex <- c('남', '여', '남', '남', '남', '여', '여', '남','여', '여', '여','여', '남','여','여', '남','남', '남','여','남')
classDF <- data.frame(name= names, gender=sex, blood= bloodType)
str(classDF)

classTable <- table(classDF[,2:3])
classTable
addmargins(table(classDF[,2:3]))

barplot(classTable, legend=T)
barplot(classTable, legend=T,
        ylim = c(0, 8),
        col = c('pink', 'lightcyan'),
        beside=T)

# MASS 패키지 로딩
?survey
head(survey)
str(survey)

survey <- survey[,c('Sex', 'Exer', 'Smoke')]
head(survey)

table(survey$Sex)
table(survey$Exer)
table(survey$Smoke)

xtabs(~Sex, survey)  # df에서만 사용가능

# 교차표: 둘 이상의 범주형 데이터를 이용해서 빈도와 비율 
table(Sex=survey$Sex, Smoke= survey$Smoke)
xtabs(~Sex+Smoke, survey) # fomular식을 이용한 table 생성

pie(table(survey$Smoke))











