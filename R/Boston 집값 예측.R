# 보스턴 집값 예측: 회귀분석(선형회귀)
data("Boston")
# 해당 데이터 셋을 파일로 저장
write.csv(Boston, file='baston.csv', row.names = T)
### baston 오타 입니다.. 재준님은 boston.csv 로 만드세요 

df <- read.csv('baston.csv', header=T, stringsAsFactors = F)
# 행머리글 제외
df <- df[,-1]
head(df)

# 변수의 의미
## crim: 1인당 범죄율
## zn: 25,000 초과하는 거주지역의 비율
## indus: 비상업지역이 점유하고 있는 토지의 비율
## chas: 찰스강 경계 근접 1, 아니면 0
## nox: 10PPM 당 일산화질소
## rm: 평균 방의 개수
## age: 1940년 이전에 건축된 소유주택의 비율
## dis: 직업센터까지의 접근성의 지수
## rad: 방사형 도로(도시 고속도로)까지의 접근성 지수
## tax: 재산세율
## ptratio: 학생과 교사의 비율
## black: 흑인의 비율
## lstat: 저소득층 비율
## medv: 주택가격(1000 단위)

# 기술통계량
install.packages('Hmisc')
library(Hmisc)
describe(df)
summary(medv ~ crim + zn, data = df)

# 데이터 전처리
## 결측치 확인
sum(is.na(df)) # 0 = 없음, 1= 결측치 있음

df[complete.cases(df),]  # 결측치가 없으면 TRUE
head(df,10)

# 결측치 삭제
df <- na.omit(df)

# 결측치 대체
df$crim[is.na(df$crim)] <- 0  # crim 컬럼의 결측치를 0으로 대체

mean_crim <- mean(df$crim)
df$crim[is.na(df$crim)] <- mean_crim  # crim의 결측치를 평균값으로 대체

# 데이터 분할 - 학습용 / 성능평가용
nrow(df)

## 랜덤 샘플링: train(70%), test(30%)
df_idx <- sample(1:506,300)
df_train <- df[df_idx,]
df_test <- df[-df_idx,]
df_train
nrow(df_train)
nrow(df_test)

# 다중회귀분석
result <- lm(medv ~ ., data=df_train)
summary(result)  ## *: 통계적으로 유의미한 변수

## 다중공선성: 독립변수들 간에 지나친 상관관계가 존재
### 팽창지수(vif)
install.packages("car")
library(car)
vif(result) # 팽창지수가 10 이상이면 다중공선성이 발생했다고 간주

# 이상치 분석
outlierTest(result)

# 상관관계 - 시각화(plot), 통계량(cor)
cor(df_train)
coef(result)

# 회귀분석 결과 - 요약보고서

# 변수선택
## 전진 선택법(forward selection): 절편만 있는 모델에서 가장 많이 개선시키는 변수를 차례로 추가하는 방법

## 변수 소거법(backward elimination): 모든 변수가 포함된 모델에서 기준 통계치에 가장 도움이 되지 않는 변수를 하나씩 제거하는 방법

## 단계적 방법(stepwise selection): 모든 변수가 포함된 모델에서 시작하여 기준 통계치에 가장 도움이 되지 않는 변수를 삭제하거나 모델에서 빠져있는 변수 중에서 기준 통계치를 가장 개선시키는 변수 추가하는 방법

result2 <- step(result, direction = 'both') # step(단계적변수선택)
# AIC: 통계 모델 간의 적합성을 비교하는 모델 지표
# AIC는 작을수록 더 좋은 모델을 의미한다.

result3 <- lm(medv ~ crim +zn +chas+ nox+ rm+ dis+ rad+ tax+ ptratio + black+ lstat, df_train)
summary(result3)

# 실제값
## df_test에서 집값 변수만 추출
df_test
actual <- df_test$medv

# 예측값
## 예측값을 구할 땐 df_test에서 medv를 제거 후 구함
# df_test에서 예측할 medv(집값) 변수 제거
df_test <- df_test[,-14]
expect <- predict(result2, newdata= df_test)

result_df <- data.frame(actual, expect)
result_df

t.test(result_df)


















