#install.packages('stringr')
library(stringr)

v <- c("A", "B", "C")
str_c(v, "1")  # 공백 없음
paste(v, "1")  # 공백 있음
paste0(v, "1") # 공백 없음

paste(v, "1", sep = "_")  # sep = 구분자(공백 없이)
str_c(v, "1", sep = "_")

# Character 개수 카운트
## nchar(x)
## str_length(x)
s <- "Hello"
nchar(s)
str_length(s)

# 소문자 변환
## tolower(x)
tolower(s)

# 대문자 변환
## toupper(x)
toupper(s)

# 2개의 문자 벡터에 중복 항목없이 합치기
## union(x,y)
x<-c('hello', 'world' ,'r', 'program')
y <- c('hi', 'world' ,'r', 'coding')
union(x,y)

# 교집합 추출하기
## intersect(x, y)
intersect(x,y)

# 차집합 추출하기
## setdiff(x, y)
setdiff(x, y)

# 두 문자 벡터의 값이 같은지 확인하기
## setequal(x, y) -- T/F
setequal(x, y)

# 문자 공백 제거: trim
## str_trim(x, side = 'both'(기본)/'left'/'right')
s2 <- c("     Hello World    ", "   Hi R    ")
str_trim(s2)
str_trim(s2, side= 'left')
str_trim(s2, side='right')

# 문자 반복 추출
## rep(x, times(기본)= / each= / length.out)
rep(1:3, times=2)  # 전체 반복 2번
rep(1:3, times=2, each=3) # 각각 3번, 전체 2번 반복
rep(1:3, times=2, each=3, len=4) # 위의 데이터에서 4개만 보여라
rep("Hello", each=4)
rep(c("Hello", "world"), times=2, each=3)
## str_dup(x, times)
str(str_dup(1:3, times=2)) # 문자형으로 추출
str_dup("Hello", 3) # 공백 없음

# 문자열 일부분 추출
## substr(x, start, stop)
s3 <- "Hello World"
substr(s3, 7,9)

string <- "Today is Thursday"
substr(string, 10, 12)
substring(string, 10, 12)

# 함수(Function)
## 함수명 <- function(매개변수){규칙}
fibo <- function(n){
  if(n %% 2 == 0){
    print('짝수')
    }else{
      print('홀수')
    }
  }

fibo(7)
fibo(500)

# plot => qplot => ggplot
barplot(mpg$hwy)
qplot(hwy, mpg)

# plot(x, y, xlab, ylab, main)
# 점의 종류(pch)
# 점의 크기(cex)
# 점의 색상(col), col = #FF0000 or col = 'red'

install.packages("mlbench")
library(mlbench)
# data(Ozone)
help(Ozone)
data(Ozone)
str(Ozone)
plot(Ozone$V8, Ozone$V9)

# 축제목
plot(Ozone$V8, Ozone$V9, xlab = 'Sandburg Temp', ylab = 'El Monte Temp')

# 차트제목
plot(Ozone$V8, Ozone$V9, 
     xlab = 'Sandburg Temp', ylab = 'El Monte Temp',
     main = 'Ozone')

# 점의 종류(pch)
plot(Ozone$V8, Ozone$V9, 
     xlab = 'Sandburg Temp', ylab = 'El Monte Temp',
     main = 'Ozone',
     pch = "+")

# 점의 크기(cex)
plot(Ozone$V8, Ozone$V9, 
     xlab = 'Sandburg Temp', ylab = 'El Monte Temp',
     main = 'Ozone',
     pch = 20,
     cex= 2.7)
# 점의 색상(col)
plot(Ozone$V8, Ozone$V9, 
     xlab = 'Sandburg Temp', ylab = 'El Monte Temp',
     main = 'Ozone',
     pch = 20,
     cex= 2.7,
     col = "#ff0000")

#축값 범위(xlim =c(최솟값, 최댓값), ylim=c(최솟값, 최댓값)
max(Ozone$V8, na.rm=T)
max(Ozone$V9, na.rm=T)

plot(Ozone$V8, Ozone$V9, 
     xlab = 'Sandburg Temp', ylab = 'El Monte Temp',
     main = 'Ozone',
     pch = 20,
     cex= 2.7,
     col = "#ff0000",
     xlim = c(0, 100), ylim = c(0, 90))







