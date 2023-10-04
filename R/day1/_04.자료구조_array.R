# R의 자료구조
## 변수 => 벡터 => 행렬 => 배열
## 행렬 => 데이터프레임 => 리스트
## 데이터분석에 특화된 자료구조 => 데이터프레임

# 행렬(matrix): 벡터의 확장
## 행과 열로 구성된 2차원 배열
## 행렬은  2차원만 가능하고, 배열(array)은 N차원이 가능한 자료구조
## cbind(열단위), rbind(행단위)는 기존 벡터를 묶어 배열을 생성할 때 사용한다.

help(matrix)

# 3행 3열 행렬 생성
## nrow = 행의 수, ncol = 열의 수 (행과 열의 개수가 같은 정방행렬은 둘 중 하나만 써도 됨)
matrix(1:9,nrow = 3)

## matrix 참조[행번호, 열번호]

matrix(1:9, nrow=3, byrow=TRUE)

## 행렬의 이름을 부여하는 함수 dimnames
dimnamex = list(c('r1', 'r2', 'r3'), c('c1','c2','c3'))
x = matrix(1:9, nrow=3, byrow = T, dimnames = dimnamex)
x

## 행렬에 요소 추출: 인덱스[행번호, 열번호]
x[2,2]
x[1, ]
x[,3]
x[1:2,]
x[2:3,2:3]
x[-1,-1]
x[,'c2'] # 행이나 열의 이름으로 추출할 땐 ''붙이기
x['r3','c1']
x[c(1,3), c(1,3)]
x[-2,-2]

y=matrix(1:9, nrow=3)
y

## 사칙연산
y + 2
y-3
y*84
y/7

a= matrix(1:4,nrow=2)
a
b=matrix(5:8, nrow=2)
b
a+b

a %*% b # 행렬 간의 곱

## 전치행렬: 행과 열의 위치를 바꿔주는 함수
t(a)
nrow(x)

xx = matrix(1:6, ncol=3)
nrow(xx)

a
b
cbind(a,b) #열 단위로 붙임
rbind(a,b) #행 단위로 붙임

## 배열: array(벡터형데이터, dim=c(행차원, 열차원))
## 3행 4열짜리 2차원 배열을 생성
x=array(1:12, dim=c(3,4))
x
dim(x)

# 2행 2열 짜리 행렬 3개를 생성하시오.
yy = array(1:12, dim = c(2, 2, 3))
yy

yy[1,2,3]

#행렬 연산 apply(행렬데이터, 방향, 연산함수)
## 방향: 1(행단위), 2(열단위)
z = array(1:12, c(3,4))
z
sum(z)
apply(z, 1, sum)
apply(z,2,mean)

# sample(): 벡터나 배열에서 샘플 추출
w = array(1:12, dim=c(3,4))
w
sample(w,10) #무작위로 10개 추출
## sample 옵션 - replace: 똑같은 값을 중복해서 추출할건지 (T/F)
sample(1:15, 20, replace=T) # 추출개수가 데이터보다 많은 경우 rep 생략하면 오류








