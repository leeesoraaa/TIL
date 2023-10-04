# 데이터 불러오기: 클립보드 데이터를 데이터 프레임으로 변환
apple_df <- read.table(file = 'clipboard', header = T, sep = '\t',
                       stringsAsFactors = T)
summary(apple_df)

# 품종에 따른 무게
boxplot(weight ~ model, apple_df, ylab = '무게')

# 품종별 당도의 분포 시각화
boxplot(sugar ~ model, apple_df, ylab = '당도')

# 품종별 산도의 분포 시각화
boxplot(acid ~ model, apple_df, ylab = '산도')

# 훈련데이터 분리(전체 데이터의 80%): apple_train_idx
apple_train_idx <- createDataPartition(apple_df$model,
                                       p=0.8, list = F)

# 훈련 데이터 
apple_train <- apple_df[apple_train_idx,]

# 테스트 데이터
apple_test <- apple_df[-apple_train_idx,]
apple_train
apple_test

# 훈련 데이터를 기반으로 분류 모델 생성: rpart
model <- rpart(model ~ ., data=apple_train,
               control=rpart.control(minsplit=2))
model

# rpart.plot 시각화
rpart.plot(model)

# 실제값과 예측값 한 눈에 비교할 수 있는 데이터 프레임
actual <- apple_test$model
apple_test[,-1] ## 예측값 구할 땐 테스트에서 품종 변수 제거
expect <- predict(model, newdata=apple_test, type='class')
result_df <- data.frame(actual, expect)
result_df

# 혼동행렬
table(result_df)

# 정확도
## 80% 정확도
