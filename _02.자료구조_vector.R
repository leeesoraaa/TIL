# 자료형(data type):변수와 상수의 크기를 규정해놓은 예약어

## 변수(Variable): 변하는 수, 기억장소
### 변수명: 기억 장소의 주소
### 변수명을 작성하는 규칙(명명법): 영문자(대,소문자), 숫자, 특수문자, 첫글자는 문자, _, $, 공백불가

## 상수(Constant): 변하지 않는 수, 값(data)
## R의 기본 자료형: 수치형(numeric), 문자형(character), 논리형(logical), 복소수형(complex)

## 대입연산자 또는 치환연산자: 좌변 = 우변, v(변수) = c(상수)/ v / 수식, <-, ->

### 변수
x <- 5
x
y=10
y

## 출력함수 print()
print(x)

## 변수 대입과 동시에 출력
(z <- 2)

# 변수제거: rm(변수명)
rm(x)
x

xx <- print # 객체복사 
print('안녕하세요')
xx('안녕하세요')
rm(xx)

## 현재 메모리에 저장된 변수의 목록을 확인하는 명령
ls()
help(ls)

x <- "one"
x
print(x)
print(x,quote = F) # T = TRUE(기본형), F = FALSE (따옴표 제거)

# 출력서식을 지정하여 출력하는 함수 sprintf = string print format
## 서식기호: %s(문자형), %f(실수형), %i(정수형)
### 홍길동의 나이는 낭랑 18세 입니다.
print("홍길동의 나이는 낭랑 18세 입니다.")
sprintf("%s의 나이는 낭랑 %i세 입니다.", "이순신", 23)

# 자료구조: 데이터를 효율적으로 저장하기 위한 틀
## 벡터(vector): 하나 이상의 데이터를 관리하는 자료구조
## 요소: 벡터 안의 데이터들
## 벡터의 특징: scalar도 벡터로 취급
## 벡터의 생성함수: c()
## 벡터의 인덱스의 시작값은 1부터
## 하나의 벡터에는 하나의 자료형만 사용할 수 있다.
## NA: 결측값
v1 <- c(1, 2,3,4,5)
v2 <- 1:5 #start:end, step=1 생략
v3 <- c(1.5, 10, 'two', 5, 'five') #문자형으로 저장
v4 <- c(100, "one", T, FALSE, 3.14) # 문자형으로 저장
x2 = 1:15
x2

x3 = c('one', 'two', 'three')
x3

x1 = c(1,2,3,4)
x1

# 벡터 합치기: append(변수1, 변수2) --두 개만 가능
x3 = append(x1, x2)
x3
x4 = c(x1, 0, x2)
x4

# vector(length=n): 요소가 n개인 비어있는 벡터를 생성하는 함수
vector(length = 5) # mode = "logical" 기본형
# 벡터 안에 또 다른 벡터를 담을 수 있다.
c(1,2,3, c(4:6))
y = c()
y = c(y, c(1:3)) # append
y

# seq(start, stop, by), by = 증감치 (1이 기본)
# seq(from=, to=, by=)
xx = seq(1,5)
yy = c(1,2,3,4,5)
zz = 1:5
print(xx)
yy
zz
seq(1, 10, 2)
seq(0,1, length.out = 11) #length.out: 요소의 개수

a=seq(10) # 10개의 요소 
a

#rep(벡터, times=반복횟수 / each=요소별 반복횟수)
rep(c(1:3), times=3) # R에서 하나 이상의 데이터를 담을 땐 무조건c()
rep(c(1:3), each=2)

#자료형을 이용한 벡터의 생성
## numeric(integer, double), charcter, logical
integer(length=10) # 정수형의 기본값은 0

## 벡터를 구성하는 자료를 요소(item)라고 부른다.
## 요소의 위치를 인덱스(index)라고 부른다.
## 인덱스의 시작은 1부터이다.
### 인덱스를 이용한 요소에 접근 [index], [조건식]
x = 1:11
x
x[5] #5번째 데이터를 추출하라
x[2:5] # 2번째 값부터 5번째 값까지 추출하라.
x[c(1,3,5)] # 연속되지 않은 인덱스는 c()
x[-2] # 해당 인덱스를 제외

#벡터의 각 셀에 이름을 부여할 수 있다.
y = c(a=1, b=25, c=7)
y
y['a']
y[c('b', 'c')]

xx = c(1,3,5)
xx
#이름부여 함수 names(벡터명) = c(붙일 이름들 요소 개수만큼)
names(xx) = c('lee', 'kim', 'park')
xx[c('lee', 'park')]
names(xx)
names(xx)[2]

## 벡터의 주요 내장함수
## 자료형 확인 함수
typeof(xx) # 정수형, 실수형, ...
mode(xx) # 수치형, 문자형, 논리형, 복소수형

## 벡터의 길이 = 벡터를 구성하는 요소의 개수, length()
a = c('x', 'y', 'z')
length(a)

## NROW() - 모두 대문자로, 행렬과 벡터에서 모두 사용, 행의 수
## nrow() - 모두 소문자로, 행렬(matrix)에서 행의 개수를 추출하는 함수
NROW(a) # 3
nrow(a) # NULL

## 통계함수
### cor(): 상관계수, cumsum(): 누적함수, length(): 요소의 개수
### max(): 최댓값, mean(): 평균값, min(): 최솟값, range(): 범위
### rank(): 순위, sd(): 표준편차, sum(): 합계, summary(): 기초통계량 

## 데이터분석에서 주로 사용되는 함수: matrix(행과 열을 구성/단일행)나 dataframe(표, table/다중행)
## head() tail(), summary()

## R에 내장된 데이터셋 - data()
data()

help(iris)
iris

#데이터 구조
str(iris)

head(iris) # 앞에 데이터 6개의 행 추출
tail(iris) # 뒤부터 데이터 6개의 행 추출
head(iris, 10) #앞의 데이터 10개 행 추출

x=1:10
x

# 총합 
sum(x)
# 평균
mean(x)
# 분산
var(x)
# 표준편차
sd(x)
# 중앙값
median(x)
# 최댓값
max(x)
# 최솟값
min(x)
# 범위
range(x)
#사분위 수
quantile(x)

## 벡터의 연산: 벡터의 요소들을 잉요하여 수정, 삭제, 추가
## 사칙연산과 내장함수

##스칼라(scalar): 하나의 요소로 구성된 자료 구조 
## R에서 스칼라 = 벡터
x = 10 # 요소가 1개인 벡터
y = c(1,2,3,4,5) # 벡터 요소의 개수

length(y)
x=c(1:5)
y=c(6:10)
x + y #벡터화 연산
z=c(1:3)
z+x
x + 9
x - 9
x * 3
x / 3
x %/% 3
x %% 3

x
x[3] = 30
x
x[c(2,4)] = 9
x

## 벡터 x의 모든 요소의 값을 1로 변경하시오.
x[1:5] = 1
x

## 벡터 x의 첫번째 요소 자리에 0을 추가하시오.
x = c(0, x)
x
x=append(x, 0)
x

help(append)

v_a=c('A','B','C','F','G')
v_b=c('D','E')
append(v_a, v_b, 3) #3번째 위치 뒤에 추가
append(v_a, v_b, 3) -> v_c

## 벡터 요소 삭제; -
v_a = 11:20
v_a
# 1, 3, 5, 6위치의 값만 화면에 표시하려면
v_a[c(1,3,5,6)]

#1, 3, 5, 6위치의 값을 제외하려면
v_a[-c(1,3,5,6)]

# v_a의 마지막 요소의 값만 제외하고 추출
length(v_a)
v_a[-10]

# 논리형 벡터: 논리형(logical) - TRUE(T) or FALSE(F)
v_b = c(FALSE,TRUE, TRUE, FALSE, FALSE)
v_b

# and/&, or/, not/!
!v_b #거꾸로
v_b[-c(2,3)]

# 펜시인덱스
## 논리값을 이용하여 인덱스 처리하는 기능
v_t = c('첫번째', '두번째', '세번째', '네번째', '다섯번째')
v_t

## 두번째, 세번째 요소만 추출
v_t[c(2,3)]
v_t[v_b]
v_t[!v_b]

## %in%: ~안에 포함여부를 판단하여 (T or F) 출력하는 연산자
'a' %in% c('a','b','c')
'm' %in% c('o','d','v')

# 집합연산
## 합집합(union), 교집합(intersection), 차집합(setdiff)
setdiff(c('a','b','c'), c('a', 'd'))
intersect(c('a','b','c'), c('a', 'd'))
union(c('a','b','c'), c('a', 'd'))

## 집합간의 비교연산
setequal(c('a','b','c'), c('a', 'd')) # 집합이 같은지
setequal(c('a','b','c'), c('a', 'b', 'b', 'c')) # 집합은 중복을 허용하지 않음

## all(), any()
x=1:10
x
x>5 # 결과가 10개
all(x>5) # 결과가 1개
any(x>5)

head(x)
tail(x,3)











