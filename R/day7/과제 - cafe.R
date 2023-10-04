# 패키지 로딩
library(foreign)
library(ggplot2)
library(readxl)
library(dplyr)

#과제 - Cafe 매출 분석
raw <- read_excel('C:/k-digital/data/Cafe_Sales.xlsx')
cafe <- raw
str(cafe)
View(cafe)

# 1. 인기 메뉴 best 10
best_item10 <- cafe %>% 
  filter(!is.na(item)) %>% 
  group_by(item) %>% 
  summarise(n_item=n()) %>% 
  arrange(desc(n_item)) %>% 
  head(,10)
best_item10
## 시각화
ggplot(best_item, aes(x= item, y= n_item)) + geom_col()

# 2. 날짜별 총 매출
date_sales <- cafe %>% 
  filter(!is.na(order_date)) %>% 
  group_by(date) %>% 
  summarise(sales = sum(price))
## 시간을 제외한 날짜만 나타내는 파생변수 date 추가
cafe$date <- substring(cafe$order_date, 1, 10)  
head(cafe)
date_sales

## 시각화
ggplot(date_sales, aes(x=date, y=sales)) + geom_col()

## 매출 best 10 날짜
best_date <- cafe %>% 
  filter(!is.na(order_date)) %>% 
  group_by(date) %>% 
  summarise(sales = sum(price)) %>% 
  arrange(desc(sales)) %>% 
  head(,10)
best_date
### 결론: 2018년 12월에 가장 장사가 잘 됐다. 

### 시각화
ggplot(best_date, aes(x=date, y=sales)) + geom_col()

# 3. 요일별 평균 매출
## 요일을 나타내는 파생변수 day추가
weekdays(as.Date('2023-08-03'))
help("weekdays")
help("weekdays.Date")
str(cafe$order_date)
cafe$day <- weekdays(cafe$order_date)
names(cafe)

## 날짜별 매출이 담겨있는 date_sales에 요일을 나타내는 변수 day 추가
date_sales$day <- weekdays(as.Date(date_sales$date))
date_sales
day_sales <- date_sales %>% 
  filter(!is.na(date)) %>% 
  group_by(day) %>% 
  summarise(sales = mean(sales))
day_sales
## 시각화 
ggplot(date_sales, aes(x=day, y=sales)) + geom_col()
### 결론: 일요일이 가장 장사가 잘 되고 그 다음은 토요일이다. 월요일은 휴무인 듯하다.

# 4. 손님이 가장 많은 시간대는 언제인가?
## 시간대 설정
times <- substring(cafe$order_date, 12, 13)
times
table(times)

## 시각화
barplot(table(times))
str(times)
times %>% 
  summarise(sales = n()) %>% 
  arrange(desc(sales))


