# R base 내장 데이터
data()
iris
## 데이터 표 형태로 데이터를 보여주는 View()
help(View)
View(iris)
## 데이터 구조 확인 str()
str(iris)

# 데이터 셋 목록 확인
library(help=datasets)

# 실제 데이터를 사용할 때
data(mtcars)

## head()와 tail()
head(mtcars)

View(mtcars)

# 파일 입출력
## csv 파일 입출력: read.csv(파일명, header=T)
## header=T: 첫번째 값은 열의 이름이다
x <- read.csv('C:/k-digital/data/aaa.csv')
x
### 파일을 가져온 후 데이터의 구조를 확인하는 것이 우선
str(x)  # 데이터프레임 형식으로 가져옴

x <- read.csv('C:/k-digital/data/bbb.csv')
x
names(x) # x의 열 이름을 가져옴
names(x) <- c('id', 'name', 'score')  # 첫 행 손실
x

x <- read.csv('C:/k-digital/data/bbb.csv', header=F)
x
str(x)

# 특정 열의 자료형을 바꾸는 함수
x$name <- as.factor(x$name)
str(x)
x$name <- as.character(x$name)
str(x)

# 처음 자료를 가져올 때 부터 문자를 팩터로 읽어오는 함수
##  stringsAsFactors = T
x <- read.csv('C:/k-digital/data/aaa.csv', stringsAsFactors = T)
str(x)

x <- read.csv('C:/k-digital/data/aaa.csv')
x
str(x)

# 문자를 결측값 처리하는 함수
## na.strings = '문자'
x <- read.csv('C:/k-digital/data/aaa.csv', na.strings = 'NIL' )
x
str(x)

is.na(x$score)
table(is.na(x$score)) #결측값 유무의 F/T 를 표 형태로 보여줌

# 데이터를 파일로 저장하는 방법
getwd()  # 현재 작업위치 확인
write.csv(x, 'ccc.csv', row.names = F)
## 행번호 삽입 안 하려면 row.names = F

# R 객체를 그대로 파일로 저장하고 불러오는 함수, RData 확장자
x <- 1:5
y <- 6:10
save(x, y, file='xy.RData')
x
y

## 현재 메모리상에 있는 모든 객체를 삭제하는 작업
rm(list=ls())
x

## save로 저장된 변수를 읽어오기
load('xy.RData')
x

# 외부 데이터 가져오기: 엑셀파일, read_excel()
## 별도의 새로운 패키지 설치
install.packages('readxl')

## 패키지 불러오기
library(readxl)

## 엑셀파일 불러오기
ex_data <- read_excel('C:/k-digital/data/ex_data.xlsx')
View(ex_data)
ex_data

# rbind(), cbind(): 각각 행 또는 열 형태로 데이터를 합쳐 행렬 또는 데이터 프레임을 생성
rbind(c(1,2,3), c(4,5,6))

x<-data.frame(id=c(1,2), name=c('a', 'b'), stringsAsFactors = F)
x
str(x)
 y <- rbind(x, c(3, 'c'))
y

cbind(c(1,2,3), c(4,5,6))
y <- cbind(x, test = c('pass', 'fail'))
y

# apply 계열의 함수들: 벡터, 행렬, 리스트, 데이터프레임에 반복적으로 적용하는 함수
## 종류: apply, lapply, sapply, tapply
### apply(행렬, 방향, 함수): 행 또는 열방향으로 특정 함수를 적용할 때 사용
sum(1:10)

d <- matrix(1:9, nrow=3)
d
### 주어진 행렬의 행들의 합
apply(d, 1, sum)  ## 1=행방향, 2=열방향
apply(d,2,sum) # 열들의 합

View(iris)
str(iris)

### iris 데이터의 각 컬럼의 합
##apply(iris[행인덱스, 열인덱스], 2, sum)
apply(iris[,1:4], 2, sum)

## rowSums(), colSums()
## rowMeans(), colMeans()
colSums(iris[,-5])

## lapply(x, 함수), x - 벡터 또는 리스트
### 결과가 리스트로 반환된다. 
result <- lapply(1:3, function(x){ x*2})  # function(변수){규칙} 사용자 정의 함수
result

### 리스트를 벡터로 변환하는 함수
unlist(result)
result

## 리스트 생성: 키와 값을 쌍으로 관리하는 자료구조
x <- list(a=1:3, b=4:6)  # a,b는 키
x
lapply(x, mean) # 키 별 평균
lapply(iris[,-5], mean)  # 리스트 형태로 도출
colMeans(iris[,-5])  # 데이터프레임 형태 그대로 도출

# 리스트를 데이터 프레임으로 변환할 때
##1. unlist() 함수를 통해 리스트를 벡터로 변환
unlist(lapply(iris[,-5], mean))
##2. matrix() 함수를 통해 벡터를 행렬로 변환
matrix(unlist(lapply(iris[,-5], mean)), ncol=4, byrow =T) # 컬럼명 소멸
##3. as.data.frame() 함수를 이용해서 행렬을 데이터프레임으로 변환
as.data.frame(matrix(unlist(lapply(iris[,-5], mean)), ncol=4, byrow =T))
#### 이 과정 중 컬럼명이 사라짐
names(iris[,-5])
##4. names() 함수를 이용해 리스트로부터 컬럼명을 얻어와 데이터프레임에 부여
d <- as.data.frame(matrix(unlist(lapply(iris[,-5], mean)), ncol=4, byrow =T))
names(d) <- names(iris[,-5])
d

# sapply : lapply와 유사하지만 리스트 대신 행렬, 벡터 등으로 결과가 반환됨
## iris 컬럼별 평균 계산
lapply(iris[,-5], mean)
sapply(iris[,-5], mean)
class(sapply(iris[,-5], mean))  # 자료형 도출
x<-sapply(iris[,-5], mean)
x
as.data.frame(x)
as.data.frame(t(x))  # t() - 전치행렬(행과 열의 위치 바꿈)

sapply(iris, class)  # 각 컬럼에 대한 타입이 나옴

### iris의 데이터 값 중 3 이상인 데이터 찾기
result <- sapply(iris[,-5], function(x){ x>3})
class(result)
head(result)

# tapply: 그룹별 처리를 위한 apply 함수
## tapply(데이터, 색인, 함수) 색인- 그룹 정의
tapply(1:10, rep(1, 10), sum)

## 홀수별, 짝수별로 묶어서 합계를 구하시오.
tapply(1:10, 1:10 %% 2 == 1, sum) # TRUE: 홀수, FALSE: 짝수

### 행렬(행-계절, 열-성별)
m <- matrix(1:8, ncol=2, dimnames=list(c('spling', 'summer', 'fall', 'winter'), c('male', 'female')))   # 행과 열의 이름을 부여하는 함수 dimnames 는 list로 작성
m

#### 분기별 남성과 여성의 합계를 구하시오.
#### 상반기(봄, 여름), 하반기(가을, 겨울)
tapply(m,list(c(1,1,2,2,1,1,2,2), c(1,1,1,1,2,2,2,2)), sum)

#doBy 패키지
## summaryBy(), orderBy(), splitBy(), sampleBy(): 
###summary(): 수치데이터의 기초 통계량을 나타내는 함수
summary(iris)
quantile(iris$Sepal.Length)

#패키지 설치
install.packages('doBy')
library(doBy)

# 사분위수를 추출
quantile(iris$Sepal.Length)  # 0%, 25%, 50%, 75%, 100%
quantile(iris$Sepal.Length, seq(0, 1, by=0.1)) # 0%, 10%, 20% ,...,90%, 100%

## formula 식: 독립변수 ~ 종속변수, 독립변수1 + 독립변수2 ~ 종속변수
summaryBy(Sepal.Length + Sepal.Width ~ Species, iris)  # Species 별 합
## 생략은 all
orderBy( ~ Sepal.Width, iris) # 모든 데이터들을 Sepal.Width를 기준으로 오름차순정렬

orderBy( ~ Species + Sepal.Width, iris) # Species를 기준으로 정렬 후 Sepal.Width 로 정렬
order(iris$Sepal.Width) # 벡터 형식으로 정렬 됨

iris[order(iris$Sepal.Width), ]

sample(1:10, 5)   # 중복 불가능
sample(1:10, 5, replace =T) # 중복허용
sample(1:10, 20, replace = T) # 중복허용 옵션 필수

## 데이터를 무작위로 섞어내기
### iris 데이터를 무작위로 섞는 작업
iris[sample(nrow(iris), nrow(iris)),] #sample(전체 데이터, 가져올 데이터 개수)
### 랜덤샘플링
sampleBy(~ Species, frac = 0.1, data = iris)   # frac - 품종별 포함될 데이터의 퍼센트

## split(데이터, 분리조건) - 리스트로 반환된다.
split(iris, iris$Species)

lapply(iris[,1:4], mean)

lapply(split(iris$Sepal.Length, iris$Species), mean)

#subset(): 소개
subset(iris, Species == 'setosa') 
subset(iris, Species == 'setosa' & Sepal.Length > 5.0)
subset(iris, select = c(Sepal.Length, Species)) # 특정 열만 추출은 select
subset(iris, select = -c(Sepal.Length, Species))

# merge(): join과 같은 역할을 수행하는 함수
x <- data.frame(name = c('a', 'b', 'c'), math=c(1,2,3))
x
y <- data.frame(name = c('c','b','a'), kor=c(4,5,6))
y

cbind(x, y)
merge(x,y,all = T) # full output join, 일치하지 않더라도 조인(NA)

# sort(), order(): 데이터를 정렬하는 함수
x = c(20,11,33,50,34)
x

sort(x) # 정렬옵션, decreasing = T(내림차순), 기본값 오름차순
sort(x, decreasing = T)

order(x) # 정렬 후 인덱스 반환
order(-x)  # 내림차순 인덱스 반환
x[order(x)]

# with(), within() - 데이터 수정할 때 사용
mean(iris$Sepal.Length)
print(mean(iris$Sepal.Length))
print(mean(iris$Sepal.Width))

with(iris, {
  print(mean(Sepal.Length))
     print(mean(Sepal.Width))
})
x <- data.frame(val=c(1,2,3,4,NA, 5, NA))
mean(x$val)
is.na(x$val)
mean(is.na(x$val)) # 결측값을 포함한 평균
mean(x$val, na.rm=T) # 결측값을 무시한 평균

## ifelse(조건식, 참일 때, 거짓일 때)
## 수치데이터의 결측값을 보간하는 방법: 평균값 or 최빈값
x <- within(x, {
  val <- ifelse(is.na(val), median(val, na.rm=T), val)
})
x
x$val[is.na(x$val)] <- median(x$val, na.rm=T)
x

iris[1,1] <- NA
head(iris)

## 결측값이 존재하는 해당 품종의 중앙값으로 대체하는 작업
### step1. setosa 품종의 Sepal.Length의 중앙값 계산
split(iris$Sepal.Length, iris$Species)  # 품종 별 Sepal.Length만 추출
rs <- sapply(split(iris$Sepal.Length, iris$Species), median, na.rm=T) 
# 품종 별 Sepal.Length의 중앙값 계산 (NA 무시)
rs

### step2. 해당 중앙값으로 결측값을 채운다.
iris <- within(iris, {
  Sepal.Length <- ifelse(is.na(Sepal.Length), rs[Species], Sepal.Length)
})

head(iris)

#attach(), detch()
iris$Sepal.Length
attach(iris) ## iris의 컬럼 데이터들을 기억
Sepal.Length
detach(iris) ## 기억해제

# which(), which.max(), which.min()
## which 함수는 벡터나 배열에서 주어진 조건에 만족하는 값이 있는 인덱스 반환
x<- c(2,4,6,7,10)
x%%2
which( x %% 2 == 0)
x[which(x%%2==0)]

which.max(x)  # x에서 가장 큰 값의 인덱스
x[which.max(x)]  # x에서 가장 큰 값

sort(x)[1]  # =which.min()
sort(x, decreasing = T)[1] #which.max()
-sort(-x)[1] #which.max()

# aggregate(): 그룹별 연산을 수행하는 함수
## aggregate(데이터, 그룹조건, 함수) or aggregate(formula, 데이터, 함수)

### iris 데이터에서 품종별로 Sepal.Width의 평균 계산
aggregate(Sepal.Width ~ Species, iris, mean)
