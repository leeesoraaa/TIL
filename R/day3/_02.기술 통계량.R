# 기술 통계량: 데이터를 요약하는 대푯값, summary()
## 데이터를 의미있는 숫자로 요약하여 데이터의 특성을 파악하는 방법

### 평균: mean
## 식당들의 배달 시간
storeA <- c(20,21,23,22,26,28,35,35,41,42,43,45,44,45,46,47,47,46,47,58,58,59,60,56,57,57,80)
storeB <- c(5,6,11,13,15,16,20,20,21,23,22,27,27,30,30,32,36,37,37,40,40,43,44,45,51,54,70,600)
storeC <- c(5,5,5,12,10,11,20,20,20,20,20,21,20,30,32,31,31,31,36,40,40,51,61,51,61,61,70)

### A 와 B 중 어느 식당이 배달시간이 빠른지 분석
mean(storeA)
mean(storeB)

#### 600보다 작은 값을 대상으로 평균
mean(storeB[storeB < 600])

### 중앙값: median - 이상치의 존재여부를 판단하기에 좋은 대푯값
nums <- c(1,5,2,3, 1000)
median(nums)
median(storeA)
median(storeB)

### 사분위수 - 중앙값이 동일한 집단에서 유용
nums <- 1:17
nums
quantile(nums)
A <- c(0,1,1,1,5,9,9,9,10)
B <- c(0,4,4,4,5,6,6,6,10)
quantile(A)
quantile(B)
quantile(storeA)
quantile(storeB)

# boxplot: 상자수염그래프
boxplot(storeB)
boxplot(storeA, storeB, names = c('A식당', 'B식당'))
boxplot(storeA)













