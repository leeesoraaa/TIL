# 변수
x=5
print(x)
# R에서 권장하는 대입연산자
x<-10

# 대입과 출력을 함께할 수 있다.
(x<-2)

#변수 삭제
rm(x)
x

x<-2
y<-3

# 현재 사용중인 변수의 목록을 출력
ls()

# 출력함수: print()
# 함수 사용 중 Ctrl + Space 로 옵션 확인 가능

# 특수상수 NA
aaa <- 100
bbb <- 75
ccc <- 80
ddd <- NA

stu <- c(aaa, bbb, ccc, ddd)
stu

# is.자료형(): 해당 자료형 확인 T/F
# as.자료형(): 해당 자료형으로 형변환
is.na(ddd)

# 특수상수 NULL
x = NULL 
is.null(x)
is.null(ddd)

# vector 주요 내장함수
val <- 1:9
val

## summary(): 수치데이터의 기초 통계량을 한꺼번에 보여주는 함수
summary(val)

x<-10 # 요소가 1개인 벡터
x=1:5
x
xy=rnorm(30) # 정규분포 난수를 생성하는 함수
xy
length(x)
range(x)
mean(x)
var(x) # 분산
sd(x) # 표준편차

# 벡터의 요소에 접근: 인덱스
## [인덱스]
# 두번째 요소를 뺀 나머지
x[-2]
# 세번째 요소 값 변경
x[3] = 30
x

## [start:end]
x[2:4]

# 벡터화 연산: 벡터에 저장된 데이터의 요소단위로 계산을 수행한다.
## 벡터 합치기: append(a,b)
## append(a, b, after_index)
x <- c(3,6,8,12,15)
y=c(5,10,15,20,25)
z = append(x,y)
z
w = append(x, y, 3) # x의 3번째 수 다음에 y를 연결
w

v = -5:5
v

#seq(from, to, by) 
q = seq(1,5,0.5)
qq = seq(10) # seq의 from과 by는 1일 때 생략할 수 있다.
qq

# 두 벡터의 비교연산자
x <- c(1,2,3)
y <- c(4,2,8)
x==y # 값이 논리연산자 3개

# rep(벡터, times=반복횟수 or each=개별반복횟수)
(x=rep(c('a', 'b', 'c'),times=10))
(x=rep(c('빨','주','노','초','파','남','보'), each=3))

#중복값을 제거하고 대표값만 추출하는 함수
y<- unique(x)
y

## 문자를 결합 paste
xx = c('a','b','c','d','d')
k= paste(xx[1], xx[2])
k
print(xx[1] + xx[2]) # error 문자는 산술연산자 불가
paste('hello', 'world')
# \n: 한줄 내려쓰는 제어문자
cat(paste('hello\n', 'world')) # 제어문자 작동을 위해 cat 함수

#sep: 구분기호, sep = ' ' - 연결 시 한 칸 공백
paste(xx[1], xx[2], sep='')
paste(xx[1], xx[2], sep='-')

# substring('문자열', 시작위치, 마지막위치): 문자열의 일부분 추출
substring('abcdefghijklmn', 2, 5)

# 논리값: TRUE(T), FALSE(F)
## 형변환 불가
## 논리연산자: and(&), or(|), not(!)
TRUE & TRUE  #TRUE
TRUE|FALSE  #TRUE
TRUE&FALSE #FALSE
!TRUE   #FALSE

# factor < vector
gender <- factor('M', c('M','F'))
gender 
nlevels(gender)
levels(gender)
levels(gender)[1] # factor도 vector의 일종이기 때문에 인덱스 활용 가능
levels(gender) <- c('male', 'female') # level이 바뀌면 factor의 데이터도 바뀜
gender

ordered(c('a','b','c'))  # a < b < c
ordered(gender)
gender

# 행렬(matrix)
matrix(1:9, nrow=3) # ncol=3, byrow=F 생략
matrix(1:9, nrow=3, byrow=T)
x = matrix(1:9, nrow=3, 
       dimnames=list(c('item1','item2','item3'), c('att1','att2','att3')))

## 행렬의 데이터에 접근하는 방법: [행인덱스, 열인덱스]
x
x[1,1]
x[-3,]
x[-2,-2]
x[c(1,3), c(1,3)]
x['item1',]
x*2

# 전치행렬
t(x)

matrix(1:12, nrow=4)
array(1:12, dim=c(3,4))
x = array(1:12, dim=c(2,2,3))
x
dim(x)
x[1,2,3]
x[,,3]

#list(리스트)
x <- list(name = '홍길동', height=c(170, 187, 163))
x
x$name
x$height
x$height[3]

list(a=list(val=c(1,2,3)), b=list(val=c(1,2,3,4)))
# 리스트 내 데이터에 접근하는 방법: $
## 리스트명$변수명$키 or 리스트[[인덱스]]
x<-list(name = '홍길동', height = c(1,3,5))
x
x$name
x$height
x[[1]]
x[[2]] # 대괄호 2개일 때 값만 출력
x[[2]][2]
x[1] # 대괄호 1개일 땐 키와 값이 함께 출력

# 데이터 프레임(Data Frame)
d = data.frame(x = 1:5, y = c(2,4,6,8,10))
d
d2 = data.frame(x=1:5, y=seq(2,10,2), z=c('M', 'F', 'M','F', 'M'))
d2

## 기존에 데이터프레임에 특정 컬럼 추가
d2$v = c(3,6,9,12,15)
d2
d2$x
d2[,1] #matrix식 접근
d2[,c('x','y')]
d2[, 1, drop=F] #데이터프레임 형태 그대로 출력

str(d2)

# 타입(data type) 확인
## mode(), typeof(), class()
##class() 자료구조 확인
class(c(1,2))
class(matrix(c(1,2)))
str(c(1,2))

# is.factor(), is.matrix(), is.data.frame(), is.character()
is.numeric(c(1,2,3))
is.numeric(c('a','b','c'))
is.matrix(matrix(c(1,2)))

# 형변환: as.자료형(바꿀자료)
x=c('m', 'f')
is.character(x)
as.factor(x)
as.numeric(factor(x)) #level 순서에 따라 숫자 매김

