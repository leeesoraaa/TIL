# dplyr 패키지: 데이터 프레임을 핸들링할 때 가장 기본적으로 사용되는 함수
## 패키지 설치 후 로딩
## filter(데이터프레임, x): 행 추출, =subset()
## select(df, x, y): 열 추출, =df[,c('x', 'y')]
## mutate(df, z = x + y): 열 추가(파생변수), =df$z <- df$x + df$y, =transform()
## arrange(df, x): 정렬, =order(), =sort()
## distinct(df, x): 중복 제거, unique 행 추출, =unique()
## rename(df, y = x): 변수명 변경, =names(df)[names(df) == 'x'] <- 'y'
## summarise(): 집계, =aggregate()
## group_by(): 그룹별 집계
## inner_join(df1, df2), merge(df1, df2)
## left_join(df1, df2), merge(df1, df2, all.x = T)
## %>%: 체인연산자

# 세계 각 국의 기대수명과 1인당 국내 총생산, 인구에 대한 정보를 집계한 데이터셋
install.packages("gapminder")
library(gapminder)
str(gapminder)
head(gapminder, 10)

## 각 나라별 기대 수명을 추출
gapminder[, c('country', 'lifeExp')]

## 각 나라별 기대 수명과 측정년도
gapminder[, c('country', 'lifeExp', 'year')]

select(gapminder, country, lifeExp, year)

gapminder %>%
  select(country, lifeExp)
View(gapminder)

gapminder[gapminder$country=='Croatia', c('pop', 'lifeExp')]

# Croatia의 1990년 이후의 기대수명과 인구를 추출
gapminder[gapminder$country == 'Croatia' & 
            gapminder$year >= 1990,
          c('lifeExp', 'pop')]

# Croatia의 기대수명과 인구의 평균을 추출하시오.
## apply(data, 방향, function)
apply(gapminder[gapminder$country == 'Croatia', c('lifeExp', 'pop')], 2, mean)

# Croatia 정보추출
filter(gapminder, country == 'Croatia')

gapminder %>%
  filter(country == 'Croatia')

## Croatia의 기대수명과 인구만 추출 - dply 이용
df <- filter(gapminder, country == 'Croatia')
select(df, lifeExp, pop)

gapminder %>%
  filter(country == 'Croatia') %>%
  select(lifeExp, pop)

## 인구의 평균
mean(gapminder$pop)
summarise(gapminder, mean(pop))

## 대륙별 인구의 평균
summarise(group_by(gapminder, continent), mean(pop))

gapminder %>%
  group_by(continent) %>%
  summarise(mean(pop))

# 대륙별 나라의 인구 평균
gapminder %>%
  group_by(continent, country) %>%
 summarise(mean(pop))

#-----------------------------------------------------------------------------
# mtcars
#-----------------------------------------------------------------------------
str(mtcars)
## 행추출: filter(데이터, 조건식)
### 실린더(cyl)의 개수가 4기통에 해당하는 자동차의 정보만 추출하시오
mtcars %>%
  filter(cyl==4)

### 실린더가 6기통 이상이고 연비가(mpg) 20을 초과하는 자동차의 정보만 추출
mtcars %>%
  filter(cyl >= 6 & mpg > 20)

## 열추출: select(데이터, 변수명,...)
### mtcars 데이터셋에서 변속기(am)과 기어(gear) 데이터만 추출
mtcars %>%
  select(am, gear)

## 정렬: arrange(데이터, 변수명1, 변수명2,...), arrange(데이터, desc(변수명))
### mtcars 데이터셋의 무게(wt)를 기준으로 오름차순 정렬한 후 상위 6개만 추출
head(arrange(mtcars, wt))

## 열추가: mutate(데이터, 추가할 변수이름 = 조건 ...)
### mtcars 데이터셋에 year라는 생산년도를 담을 열을 추가한 후 1974라는 값을 표시
mutate(mtcars, year = 1974) -> mtcars1
mtcars1

### 자동차별 연비의 순위를 구하여 mpg_rank 열을 추가하여 표시
mutate(mtcars, mpg_rank = rank(mpg))

## 중복값 제거: distinct(데이터, 변수명)
### mtcars 데이터셋의 실린더 개수에 따른 종류와 기어 개수에 따른 종류 추출
distinct(mtcars, cyl, gear)

## 요약: summarise(데이터, 요약변수명 = 기술통계함수)
### 자동차 실린더 개수의 평균, 최솟값, 최댓값 추출
summarise(mtcars, cyl_mean = mean(cyl), cyl_min = min(cyl), cyl_max = max(cyl))

## 그룹설정: group_by(데이터, 변수명)
### 동일한 실린더 개수를 가진 차가 몇대인지 추출
gp <- group_by(mtcars, cyl)
summarise(gp, n()) #n() 개수 세는 함수
# 중복값을 제거한다면 n_distinct()

# 동일한 실린더 개수를 가진 차들 중 기어값이 중복인 데이터를 제외한 건수
gp <- group_by(mtcars, cyl)
summarise(gp, n_distinct(gear))

#--------------------------------------------------------------
# EDA(탐색적 데이터 분석)
#--------------------------------------------------------------
tips <- read.csv('https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv')
tips
str(tips)
View(tips)
## 요약보고서 summary
summary(tips)

## factor로 형변환
tips$sex <- as.factor(tips$sex)
tips$day <- as.factor(tips$day)
tips$smoker <- as.factor(tips$smoker)
tips$time <- as.factor(tips$time)

## 일요일에 다녀간 사람 중 담배를 피는 사람은 몇 명인가
tips %>%
  filter(day == 'Sun' & smoker == 'Yes') %>%
  summarise(n())

## 요일별 매출
tips %>%
  group_by(day) %>%
  summarise(tot = floor(sum(total_bill))) -> data
data
ggplot(data, aes(day, tot)) + geom_col() +
  geom_text(aes(label=tot, vjust=0, hjust=0))
### geom_bar는 축 하나만 가짐/ geom_col은 x,y두 개의 축으로 막대 그래프

## 동석자 수의 분포
tips %>%
  ggplot(aes(size)) + geom_histogram()

## 총계산 금액에 따른 팁 액수를 분석
tips %>%
  ggplot(aes(total_bill, tip)) +
  geom_point()
## 요일에 따른 색상을 다르게 부여
tips %>%
  ggplot(aes(total_bill, tip)) +
  geom_point(aes(col = day))
## 결제한 성별에 따른 볼릿기호
tips %>%
  ggplot(aes(total_bill, tip)) + 
  geom_point(aes(col = day, pch=sex),size=3)

#---------------------------------------------------------------------------
# 탐색적 데이터 분석: mpg
#---------------------------------------------------------------------------
str(mpg)
mpg <- as.data.frame(ggplot2::mpg)
head(mpg, 10)

## 자동차 배기량(displ)에 따른 고속도로 연비(hwy)
table(mpg$displ)

## 자동차 배기량이 4 이하인 자동차와 5이상인 자동차 중 어떤 자동차의 고속도로 연비가 높은지 분석
mpg %>%
  filter(displ <= 4) %>%
  summarise(mean(hwy))
mpg %>%
  filter(displ >= 5) %>%
  summarise(mean(hwy))


## 자동차의 제조회사별 도시 연비(cty)가 어떤지 분석
mpg$manufacturer <- as.factor(mpg$manufacturer)
mpg %>%
  group_by(manufacturer) %>%
  summarise(mean(cty))
















