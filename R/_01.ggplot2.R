# 시각화 ggplot2 패키지를 이용
## 패키지 설치 - 외부 패키지
install.packages('ggplot2')
## 패키지 로딩 - 패키지가 제공하는 다양한 함수를 사용
library(ggplot2)

# 기본문법 - 레이어구조 이용
## ggplot(data, aes()) + geom_point()  모든 그래프에 공통 속성을 줄 때
## ggplot(data) + geom_point(aes())  각각의 그래프의 속성을 다르게 할 때 
## mapping(매핑) - 연결 역할, 생략가능하나 data와 aes 위치가 다를 때                                  mapping=aes() 필수
## aes(): x, y 축에 관한 값을 매핑

# 내장 데이터셋 airquality
## 데이터셋의 구조확인
str(airquality)

## x - 날짜, y - 온도
ggplot(airquality, aes(x=Day, y=Temp)) + geom_point()

## 산점도(산포도): 두 관측데이터의 상관관계를 분석할 때 효율적으로 사용
## 심볼(볼릿)의 크기와 색상을 변경하는 작업
ggplot(airquality, aes(x=Day, y=Temp)) + geom_point(color='red', size = 3)
## 기본점의 크기 1.5
ggplot(airquality, aes(x=Day, y=Temp, color='red',size=3)) + geom_point()

# 선 그래프: 시계열 데이터, geom_line()
ggplot(airquality, aes(x=Day, y=Temp)) + geom_line()

# 막대 그래프: 빈도(크기), geom_bar()
## 실린더 종류에 따른 차종의 빈도수 확인
str(mtcars)
table(mtcars$cyl) # 도수분포표
ggplot(mtcars, aes(x=cyl)) + geom_bar(width=0.5)
##factor(): 범주형의 의미를 가지고 비어있는 값을 제외할 때
ggplot(mtcars, aes(x=factor(cyl))) + geom_bar(width=0.5)

# 누적막대 그래프
table(mtcars$gear)
## gear의 빈도값을 포함한 누적 막대 그래프
ggplot(mtcars, aes(x=factor(cyl))) + geom_bar(aes(fill=factor(gear)))
##fill() - 해당 축의 값이 색상으로 채워진다

## 누적막대 그래프를 선버스트 차트(coord_polar)를 이용
ggplot(mtcars, aes(x=factor(cyl))) +
  geom_bar(aes(fill=factor(gear))) +
  coord_polar()

ggplot(mtcars, aes(x=factor(cyl))) +
  geom_bar(aes(fill=factor(gear))) +
  coord_polar(theta = 'y') # 도넛모양 옵션

# 상자수염 그래프: geom_boxplot()
## 이상치를 판단할 때 유용
## 날짜별로 온도의 분포를 확인하기 위해 날짜별 그룹이 필요 group = Day
ggplot(airquality, aes(x=Day, y=Temp, group=Day)) + geom_boxplot()

# 히스토그램: geom_histogram()
ggplot(airquality,aes(Temp)) + geom_histogram()

ggplot(airquality,aes(Temp)) + geom_bar()
## 구간조정(막대의 너비): binwidth
ggplot(airquality,aes(Temp)) + geom_histogram(binwidth=0.7)

# 사선 추가: geom_abline()
## geom_abline(intercept=절편, slope=기울기)
## ggplot2::economics 
str(economics)
help("economics")
## 날짜별 저축률을 선그래프로 구현 후 그 위에 사선 추가
ggplot(economics, aes(x=date, y=psavert)) +
  geom_line() +
  geom_abline(intercept = 12.18671, slope = -0.0005444)

# 평행선 추가: geom_hline(yintercept = y절편)
ggplot(economics, aes(x=date, y=psavert)) +
  geom_line() +
  geom_hline(yintercept = mean(economics$psavert))

# 수직선 추가: geom_vline(xintercept = x절편)
## 개인 저축률이 가장 낮은 시기에 수직선 표시하기
min_psavert <- min(economics$psavert)
min_psavert
View(economics)
min_date <- economics[economics$psavert == 2.2, 'date']
min_date
typeof(min_date)
ggplot(economics, aes(x=date, y=psavert)) +
  geom_line() +
  geom_vline(xintercept= as.numeric(min_date))

# 레이블 추가: geom_text(aes(label = 레이블, vjust = 세로위치, hjust = 가로위치))
##각 점에 온도를 표시
ggplot(airquality, aes(x=Day, y=Temp)) +
  geom_point() +
  geom_text(aes(label=Temp, vjust=0, hjust=0))

## 세로와 가로의 위치값이 모두 0이면 점의 오른쪽 위
## 세로와 가로의 위치값이 +값은 왼쪽/아래, -값은 오른쪽/위

# 도형이나 화살표 추가: annotate()
## 그래프 영역에 투명 박스나 화살표를 이용하여 특정 영역을 강조하는 역할
## annotate('모양', xmin=x시작값, xmax=x끝, ymin=y시작값, ymax=y끝)
## mtcars 데이터셋에 무게와 연비를 기준으로 산점도 그래프를 구현한다.
ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_point() +
  annotate('rect', xmin=3,xmax=4, ymin=12.5,ymax=20, alpha=0.5, fill= 'skyblue')
# 0(투명) < alpha < 1(불투명)

## annotate() 함수의 모양 부분에 화살표를 뜻하는 segment를 추가
## x, xend와 y, yend를 추가
ggplot(mtcars, aes(x=wt, y=mpg)) +
  geom_point() +
  annotate('rect', xmin=3,xmax=4, ymin=12.5,ymax=20, 
           alpha=0.5, fill= 'skyblue') +
  annotate('segment', x=2.5, xend=3.7, y=10, yend=17,
           arrow = arrow(), color = 'red') +
  annotate('text', x=2.5, y=10, label = 'point')

# 그래프의 제목, 축제목 추가: labs()
## labs(x='x축제목', y='y축제목', title = '그래프제목')
ggplot(mtcars, aes(x=gear)) + geom_bar() +
  labs(x='기어수', y='자동차수', title='기어별 자동차수')

# 디자인 테마: theme()
theme_bw()







