# 추론통계분석: 가설검정
## A학원에 수강하면 성적에 도움이 되느냐?
## 학원을 다니기 전 성적
before_study <- c(34,76,76,63,73,75,67,78,81,53,58,81,77,80,43,65,76,63,54,64,85,54,70,71,71,55,40,78,76,100,51,93,64,42,63,61,82,67,98,59,63,84,50,67,80,83,66,86,57,48)

## 학원을 다닌 후 성적
after_study <- c(74,87,89,98,65,82,70,70,70,84,56,76,72,69,73,61,83,82,89,75,48,72,80,66,82,71,49,54,70,65,74,63,65,101,82,75,62,83,90,76,87,90,78,63,59,79,74,65,77,74)

## boxplot 비교
boxplot(before_study, after_study, names=c('수강 전', '수강 후'))

# t-검정: 집단 간의 차이를 검증하는 도구, t.test()
## t.test(x, y, paired=T/F, var.equal=T/F, alternative=양측검정/단측검정)
### paired = T: 대응표본- 동일 집단(표본크기 동일) / F: 독립표본 - 다른 집단
### alternative = 'two.sided' 두 집단이 서로 같은지 비교
### alternative = 'less' A less than B(A가 B보다 작은지)
### alternative = 'greater' A greater than B(A가 B보다 큰지)
## 표본은 정규분포를 띈다는 가정 필수 

# 샘플 수가 30개 미만이면 정규분포 여부를 반드시 확인해야 한다.
# 귀무가설: 두 집단에 차이가 없다.
# 대립가설: 두 집단이 차이가 있다.
# p-value 값 확인 <=0.05: 대립가설 채택 / >0.05: 귀무가설 채택
length(after_study)
t.test(before_study, after_study, paired = T)
# p-value = 0.03973, 대립가설 채택, 귀무가설 기각

# 귀무가설: 
# 대립가설: 학원 수강 전의 성적이 학원 수강 후의 성적보다 크다.
t.test(before_study, after_study, paired = T, alternative = 'greater')
## P-value = 0.9801 > 0.05: 대립가설 기각
### [학원 수강 후의 성적이 학원 수강 전의 성적보다 크다.]

# 표본이 1개인 경우, 단일 표본 t 검정
## A회사의 건전지 수명시간은 1000시간이다. 
## 귀무가설: 건전지의 수명시간은 1000시간이다. 
## 대립가설: 건전지의 수명은 1000시간이 아니다.

a <- c(980,1003,963,1032,1012,1002,996,1102,1017,1003)
## 정규분포 여부 확인: Shapiro-wilk 검정
### 귀무가설: 정규분포를 따른다. 
### 대립가설: 정규분포를 따르지 않는다.
shapiro.test(a)
# p-value>0.05 , 귀무가설 채택(정규분포를 따름) - t.test 가능

## alternative = two.side, 샘플이 평균과 다르다.
## alternative = less, 샘플이 평균보다 작다.
## alternative = greater, 샘플이 평균보다 크다.
t.test(a, mu = 1000, alternative = 'two.side')
# 결론: 건전지의 평균수명시간은 1000시간이다.

# 수학 평균점수가 55점이다. 
# 0교시 수업 후 학생들의 성적이 올랐다고 할 수 있는지
## 귀무가설: 오르지 않았다.
## 대립가설: 성적이 올랐다.

# 0교시 후 학생들의 수학점수
score <- c(58,49,39,99,32,88,62,30,55,65,44,55,57,53,33,42,39)
shapiro.test(score)
t.test(score, mu = 1000, alternative='greater')
# 결론: 성적이 오르지 않았다

## 피셔검정(Fisher's exact Test): 표본 수가 적거나 데이터의 분포가 치우친 경우에 적용
## fisher.test(data)
fisher.test(score)

# 정수기 회사의 직원채용 분석 - 몇명의 AS기사 채용이 필요한 지 분석
purifier_df <- read.table(file = 'clipboard',
                          header = T,
                          sep='\t',
                          stringsAsFactors = T)
# 데이터 구조 확인
str(purifier_df)
## purifier: 총 정수기 대여 수(전월)
## old_purigier: 10년 이상 노후된 정수기 대여 수(전월)
## as_time: AS 소요시간(당월)

# 상관관계: 총 정수기 대여 수와 AS 시간의 상관관계
plot(purifier_df$purifier, purifier_df$as_time,
     xlab='총정수기 대여 수',
     ylab= 'AS 시간')
# 상관관계: 10년 이상 노후된 정수기의 대여수와 AS 시간의 상관관계
plot(purifier_df$old_purifier, purifier_df$as_time, 
     xlab = '노후 정수기 대여 수',
     ylab = 'AS 시간')

# 상관계수 cor(): 피어슨 상관계수(기본), 스피어만 상관계수(서열 데이터)
## -1<상관계수<1 
cor(purifier_df$purifier, purifier_df$as_time)
cor(purifier_df$old_purifier, purifier_df$as_time)

# 상관분석 cor.test()
## 구내식당의 음식값이 매출에 미치는 영향을 분석
## 귀무가설: 상관관계가 없다.
## 대립가설: 상관관계가 있다.
x <- c(70,72,62,64,71,76,0,65,74,72)
y <- c(70,74,65,68,72,74,61,66,76,75)
cor.test(x, y, method='pearson')

# R base 내장 데이터 women
data()
str(women)
plot(women$height, women$weight)

# 상관계수
cor(women$height, women$weight)

# 회귀분석: 독립변수와 종속변수
# 체중 = 기울기 * 신장 + y절편
# 종속변수 ~ 독립변수
model <- lm(weight ~ height, women)
model
# intercept: y절편
# 체중 = 3.45 * 신장 - 87.52
3.45*180-87.52
model$coefficients[[2]] * 180 + model$coefficients[[1]]
summary(model)

plot(women$height,women$weight)
# 회귀선
abline(model)

## 자동차의 속도와 제동거리 데이터 셋 cars
str(cars)
plot(cars$speed, cars$dist)  # 선형관계= 선형 회귀분석이 가능하다.
cor(cars$speed, cars$dist)

# lm(formula, data)
# 제동거리 ~ 속도
## 독립변수가 여러 개 일 때: 종속변수 ~ 독립변수1 + 독립변수2
## 종속변수를 제외한 모든 변수가 독립변수일 때: 종속변수 ~.

head(cars, 10)
# 차 속도에 따른 제동거리를 확인하는 회귀분석
model <- lm(dist ~ speed, cars)
model

summary(model) # 회귀분석 모델의 평가 지표
## Adjusted R-squared: 설명력(정확도)

# 회귀방정식
## 제동거리 = 3.9324 * 속도 - 17.5791
abline(model)

# 회귀분석 모델의 평가 요소
## 독립변수의 유의성, 모델의 정확도, 오차항의 정규성

# 가로 2, 세로 2
par(mfrow = c(2,2))
plot(model)
## 1.Residuals vs Fitted: 실제값 vs 예측값
### 빨간 선이 0과 가까우면 정확함
## 2.Q-Q Residuals: 실제값의 차이
### 동그라미가 선과 비슷하면 정규분포를 따름
## 3. Scale-Location

## 4. Residuals vs Leverage
### 이상치

# 예측: 새로운 독립변수를 대입해서 종속변수의 값을 확인
# 점 추정과 구간 추정
# predict(model, data, interval, level)
## interval: 점(기본) / 구간
## level: 신뢰구간(구간추정에서만 필요)
model <- lm(dist ~ speed, cars)

# 독립변수에 여러 값을 담아 예측
## 예측할 값은 data.frame 형태로 담고 변수명이 독립변수와 같아야 함 
speed <- c(50, 60, 70, 80, 90, 100)
new_input <- data.frame(speed)
new_input

## 예측 - 점 추정
result <- predict(model, new_input)
str(result)
cbind(new_input, result)

## 예측 - 구간 추정
### interval='confidence': 모델 계수의 불확실성을 감안한 구간추정
### interval='prediction': 모델 계수의 불확실성과 결과의 오차를 감안한 구간추정
result <- predict(model, new_input, interval = 'confidence', level=0.95)
result

# 수치데이터의 기초 통계량
summary(purifier_df)
## 독립변수: 정수기 총 대여 수, 노후된 정수기의 총 대여 수 
#### 정수기 총 대여 수에는 노후된 정수기의 대여 수도 포함되므로 독립변수가 중복됨 -- 독립변수의 유의성 X
## 총 대여 수에서 노후된 정수기 대여 수를 뺀 파생변수생성
purifier_df$y_purifier <- purifier_df$purifier - purifier_df$old_purifier
## 종속변수: AS 시간
lm_result <- lm(as_time ~ y_purifier + old_purifier, purifier_df)
lm_result

summary(lm_result)

# AS 시간 = 0.0881 * y_purifier + 0.23977 * old_purifier + 193.73664
## 월말 총 대여 수 300.000대, 그중 10년 이상 70,000라고 한다면
input_predict <- data.frame(y_purifier=230000, old_purifier=70000)
result <- predict(lm_result, input_predict)
result

## AS 기사 1명이 한 달간 처리하는 AS 시간: 8 * 20 = 160시간
## AS 총 시간 37403.09를 한 명의 시간으로 나누면 필요한 인력
result/(8*20) #233명이 필요함

# 구간추정 

