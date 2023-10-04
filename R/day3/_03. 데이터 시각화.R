# 데이터 시각화: plot(), barplot(), boxplot(), hist(), pie(), ggplot2
## plot: 산점도 그래프, 두 개의 값의 상관관계
## plot(y축 데이터, 옵션) or plot(x축 데이터, y축 데이터, 옵션)
y <- c(1,1,2,2,3,3,4,4,5,5)
plot(y)

## pch: 심볼모양
plot(y, pch = 13)

x<-1:10
y<- 1:10
plot(x,y)
cars
plot(cars$speed, cars$dist)

# xlab, ylab - x, y 축 이름
# main - 그래프 제목
# sub - 그래프 부제목
# ann - F/T, 제목지정여부
# axes - F/T, 축 표시 여부
# axis - 사용자 지정 축값
# type - 그래프 종류(p=point(기본값), l=line, b=both)
# lty(line style): 0(없음,'blank'), 1(실선,'solid'), 
                   2(긴 점선,'dashed'), 3(점선, 'dotted')
# col: 그래프 색깔
plot(x,y,pch = '*', type = 'b', lty = 'dotted', col=2)

x<- runif(100)
y<- runif(100)
## y의 값이 0.5보다 크면 심볼모양 1, 아니면 18
 plot(x,y,pch=ifelse(y>0.5, 1, 18))

## 산점도 + 텍스트 추가
library(MASS)
str(Animals)
Animals
plot(Animals$body, Animals$brain, pch = 16, col = 'blue', 
     xlab= 'Body weight(kg)', ylab='Brain weight(g)',
     xlim= c(0, 250), ylim= c(0, 1400))
text(x=Animals$body, y= Animals$brain, labels= row.names(Animals), pos=1)
# pos는 text 위치:1~4
plot(iris$Sepal.Length, iris$Sepal.Width, col=iris$Species)

# 범례 legend()
legend('topright', legend=levels(iris$Species))

plot(~Sepal.Length + Sepal.Width,
     data = iris, 
     pch=rep(15:17, each=50), 
     col = c('red', 'green', 'blue')[iris$Species],
     cex = 1.5)  # cex - 심볼의 크기
legend('topright', 
       legend=levels(iris$Species),
       pch=15:17, 
       col=c('red' ,'green', 'blue'),
       cex=1.2,
       bty='n')  # bty - 범례 박스 선

# 막대그래프: barplot(), 도수분포표, 빈도
?barplot

sales <- c(0.12, 0.3, 0.26, 0.16, 0.04, 0.12)
barplot(sales,
        names.arg= c('berry', 'cherry', 'apple', 'banana', 'candy', 'cream'),
        horiz = T)

# 누적 막대그래프
xx <- matrix(1:6, nrow=3)
xx
barplot(xx) # 각 열에 해당하는 값들이 누적되어 나타남 

# 시즌별 티켓판매량을 그래프로 표현
aaa <- c(110, 300, 150, 280, 310)
bbb <- c(180, 200, 210, 190, 170)
ccc <- c(210, 150, 260, 210, 70)

data <- matrix(c(aaa,bbb,ccc), nrow=5,3)
data
barplot(data,
        main= '스포츠경기별 티켓판매량',
        xlab = '종목', ylab = '판매량',
        beside = T,  # 막대를 가로로
        names.arg= c('야구', '축구' ,'농구'),
        border='blue',  #막대 테두리 색깔
        col = rainbow(5),
        ylim=c(0, 400) #막대 채우기 색깔 rainbow(개수) 개수만큼 색 자동지정
        )

# ggplot2
library(ggplot2)

# 단순하게 그래프를 그리는 qplot(x, y, 옵션)
qplot(Sepal.Length, Petal.Length, data=iris)

# 꽃잎 그래프 sun flower graph
x<-c(1,1,1,2,2,2,2,2,2,2,3,3,4,5,6)
y<-c(2,1,4,2,3,2,2,2,2,2,2,1,1,1,1)

dt<- data.frame(x, y)
dt
sunflowerplot(dt)

data(mtcars)

# 별 그래프 stars
stars(mtcars[1:4], flip.labels = F, key.loc = c(13, 1.5))

# ggplot 시각화하는 단계 - 레이어 구조
## step1. 도화지(캔버스-배경): 축을 그림
ggplot(data = mpg, aes(x= displ, y= hwy))

## step2. 그래프의 종류('+'로 연결)
### geom_bar(): 막대그래프
### geom_histogram(): 히스토그램
### geom_boxplot(): 상자수염그래프
### geom_line(): 선 그래프
### geom_point(): 산점도 그래프
ggplot(data = mpg, aes(x= displ, y= hwy)) + geom_point()

### step3. 기타 옵션을 지정해서 그래프 디테일
ggplot(data = mpg, aes(x= displ, y= hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)











