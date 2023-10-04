# 선형회귀: 독립변수와 종속변수 간의 관계를 모델링하는 기법
## 단순 선형 회귀: 하나의 독립변수
## 다중 선형 회귀: 독립변수가 2개 이상인 경우

## 전제조건
### 독립변수 x는 고정된 값
### 오차항의 분산이 동일(등분산)
### 오차항은 정규분포를 따른다.
### 독립변수간 독립

# cars - speed(자동차 속도), dist(제동거리)
cor(cars$speed,cars$dist)

# 회귀모델
m <- lm(dist~ speed, cars)
m

# 회귀방정식 dist = 3.932*speed - 17.579

# 회귀모델 요약 보고서
summary(m)

# 회귀계수
coef(m)

# 예측값(Fitted Values)
fitted(m)[1:4]

## 잔차: 예측값과 실제값의 차이
residuals(m)[1:4]

## cars$dist = fitted(m) + residuals(m)
fitted(m)[1:4] + residuals(m)[1:4]

## 계수의 신뢰구간
confint(m)

## 잔차 제곱 합
deviance(m)
sum((cars$dist - predict(m, newdata=cars))^2)

## 예측 
predict(m, newdata=cars) ## 점추정







