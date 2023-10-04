# 변수
# 벡터(vector): 1차원 배열
## c(), start:end, seq(from, to, by), rep(vector, times or each)
a <- c("1", "2", "3", 4, 5, 6)
a
a <- c(1,2,3,c(4,5,6))
a
# 접근방법: [index]
a[3]
a[5]
## a 중 짝수에 해당하는 값만 추출
a[a%%2 == 0]

yy <- c("a", "b", "c")
yy[1:2]

# 벡터의 각 요소에 이름을 부여
names(yy)
names(yy) <- c('kim', 'lee', 'park')
names(yy)
yy
yy['park']

# 벡터의 길이: length() or NROW() - 대문자임을 주의!!
x <- c('a', 'b' ,'c')
length(x)
nrow(x) # matrix 형에서 사용
NROW(x) # 벡터형을 위한 nrow

# 벡터 연산
## %in%
'a' %in% x  # x라는 벡터에 'a'가 포함되어 있느냐

# 리스트(list): 파이썬의 딕셔너리 자료형과 동일
## 키 = 값의 형태로 데이터 관리
## 키는 중복불가, 값은 중복가능
x <- list(name='foo', height=70)
x
x$name
x[[1]]  # x 리스트의 첫번째 집합

## 리스트를 구성하고 있는 각 요소는 크기와 자료형이 달라도 된다.
x <- list(name='foo', height = c(1,2,3))
x
x$height
x$height[1]
x[[2]][1]

y<- list(a=list(val=c(1,2,3)), b=list(val=c('a','b','c','d')))
y
y[[2]][1]

# 행렬(matrix): 여러 개의 벡터가 결합되어 있는 형태
matrix(1:9, nrow=3)
matrix(1:9, nrow=3, byrow=T)

## 행렬의 행과 열에 이름을 부여 dimnames(list())
matrix(1:9, nrow=3, byrow=T,
       dimnames= list(c('행1', '행2', '행3'), c('열1', '열2', '열3')))

## 행렬에 접근: [행, 열]
matrix(1:9, nrow=3, byrow=T,
       dimnames= list(c('행1', '행2', '행3'), c('열1', '열2', '열3'))) -> m
m
### 1, 2 행 추출
m[1:2,]
### 3행 제외
m[-3,]
### 1행, 3행, 1열, 3열 추출
m[-2, -2]

# 데이터 프레임: 행렬과 유사한 구조
df <- data.frame(x= c(1,2,3,4,5), y=c(2,4,6,8,10))
df
df$z <- c('M', 'F', 'M', 'F', 'M')  # x, y와 개수는 같아야 함
df
df$x
df[1,2]
df[,'x']  # 벡터 형태로 추출됨
df[,'x', drop=F]  # 데이터프레임 형태를 유지한 채 추출 drop옵션















