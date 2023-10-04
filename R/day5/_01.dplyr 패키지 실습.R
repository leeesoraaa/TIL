# 패키지 설치 및 로드
# install.packages('dplyr')
library(dplyr)

## mtcars 데이터셋의 구조와 내용 확인
str(mtcars)
## 행의 수와 열의 수를 확인하는 함수
nrow(mtcars)
## 수치형 데이터셋의 기초 통계량을 확인
summary(mtcars)

# 주요함수
## 주어진 조건에 만족하는 행을 추출: filter(df, condition), subset()
filter(mtcars, cyl==4)

## [조건식], [인덱스], [행조건식, 열조건식], [행인덱스, 열인덱스]
mtcars[mtcars$cyl==4,]

## 논리연산자: and(&), or(|), not(!)
filter(mtcars, cyl >= 6 & mpg>20)

## 열 추출: select(df, v1, v2, ...)
tail(select(mtcars, am, gear), 10)

## 정렬: arrange(df, v) or arrange(df, desc(v))
head(arrange(mtcars, wt))
head(arrange(mtcars, desc(wt)))
head(arrange(mtcars, mpg, desc(wt)))

## 열 추가: mutate(df, 변수명 = 조건)
ncol(mtcars)
mutate(mtcars, year='2023')
ncol(mtcars) # mutate 후 <- 담아야 저장 됨


## 연비(mpg)를 이용하여 순위를 구하고 mpg_rank 열 추가
head(mutate(mtcars, mpg_rank = rank(mpg, ties.method = "max")))
### rank의 기본값은 오름차순 순위
### 큰값부터 순위를 매길 때 rank(데이터, ties.metode = "max")

## 중복값 제거: distinct(df, v)
## 도수분포표: table()
table(mtcars$cyl)
distinct(mtcars, cyl)
table(mtcars$gear)
distinct(mtcars, cyl, gear)

## 요약: summarise(df, 변수명=기술통계함수) or summarise()
summarise(mtcars, mpg_mean=mean(mpg),
          mpg_min=min(mpg),
          mpg_max=max(mpg))

##그룹화: group_by(df, v)
summarise(group_by(mtcars, cyl), n())

# n_distinct(): 중복을 제거한 개수 추출, n() :전체 개수
## 위 두 함수는 개별적으로 사용불가 반드시 summarise, filter, mutate에서만 사용

## 샘플: sample_n(df, 추출할 개수), sample_frac(df, 추출할 비율)
sample_n(mtcars, 10)
## 전체 데이터에서 20%만 추출
sample_frac(mtcars, 0.2)

## 파이프 연산자 or 연결연산자: %>%, shitf + ctrl + M
group_by(mtcars, cyl) %>% summarise(cnt=n())

## mpg(연비)를 이용하여 순위를 계산한 후 해당 값을 mp_rank라는 변수에 대입
mp_rank <- mutate(mtcars, mpg_rank = rank(mpg))
arrange(mp_rank, mpg_rank)

mutate(mtcars, mpg_rank = rank(mpg)) %>% 
  arrange(mpg_rank)

mtcars %>% 
  mutate(mpg_rank=rank(mpg)) %>% 
  arrange(mpg_rank)





















