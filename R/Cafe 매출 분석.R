raw
cafe <- raw
str(cafe)
## Date: 날짜를 나타내는 자료형, 1970년 1월 1일 이후 경과된 일 수를 저장한다.
## POSIXct: 날짜와 시간을 나타내는 자료형, 1970년 1월 1일 에서 경과한 초 수와 타임존을 저장한다.
## POSIXlt: 날짜와 시간을 나타내는 자료형, 1900년에서 경과된 년수, 월, 일, 시간, 분, 초, 타임존 등을 리스트의 형태로 저장한다.

class(cafe$order_date)
cafe <- as.data.frame(cafe)
str(cafe)
# 현재 시간을 저장
x<- Sys.time()
x
format(x, '%Y-%m-%d %H:%M:%S')  # YYYYMMDD, YYMD
format(x, '%Y-%j %H:%M:%S')  # w
format(x, '%G-%V-%u %H:%M:%S')

## %u 요일(1-7, 1-월요일)

# 결측치와 이상치 분석
is.na(cafe$order_id)
table(is.na(cafe$order_id)) # 주문번호
table(is.na(cafe$order_date))  # 주문 날짜 결측 존재
table(is.na(cafe$category))
table(is.na(cafe$item))
table(is.na(cafe$price))

## 전체 데이터 수에 비해 결측의 수가 적으면 대체보다는 제거
cafe <- na.omit(cafe) # 결측이 있는 행 전체를 제거

head(cafe, 20)
nrow(cafe)

# 주문건수
length(unique(cafe$order_id))
unique(cafe$order_date)
as.Date(cafe$order_date)
# 카페에서 가장 많이 판매된 메뉴는 무엇인가?
table(cafe$item)
## 내림차순 정렬
sort(table(cafe$item), decreasing = T)

cafe_item<- data.frame(table(cafe$item))
head(cafe_item)

sales_item <- subset.data.frame(cafe, select=c('item', 'price'))
sales_item <- unique(sales_item)
sales_item

# 요일별 판매한 메뉴는 무엇인가
cafe$weekday <- weekdays(cafe$order_date)
table(cafe$weekday)

## cafe$info <- ifelse(조건식, 참, 거짓)
date_info <- data.frame(weekday = c('월요일','화요일','수요일', 
                                    '목요일', '금요일', '토요일', '일요일'),
                        day=c('평일','평일', '평일', '평일', '평일', 
                              '주말', '주말'))
date_info
## 두 df 합치는 작업 merge
cafe <- merge(cafe, date_info)
head(cafe)

table(cafe$day)

# 계절별로 판매되는 메뉴는 무엇인가?
cafe$month <- months(cafe$order_date)
head(cafe)

##봄(3-5월), 여름(6-8월), 가을(9-11월), 겨울(12-2월)
## 계절 데이터프레임 season_info: 봄, 여름, 가을, 겨울
season_info <- data.frame(month = c('1월', '2월', '3월', '4월', '5월', '6월', '7월',
                               '8월', '9월', '10월', '11월', '12월'),
                     season = c('겨울', '겨울', '봄', '봄', '봄', '여름', '여름',
                                '여름', '가을', '가을', '가을', '겨울'))
season_info

cafe<- merge(cafe, season_info)
cafe
View(cafe)
## 계절별 메뉴
### 봄
spring_menu <- cafe %>% 
 filter(season == '봄') %>% 
  group_by(item) %>% 
  summarise(n_item = n())

arrange(spring_menu, desc(n_item))

### 여름
summer_menu <- cafe %>% 
  filter(season == '여름') %>% 
  group_by(item) %>% 
  summarise(n_item = n())

arrange(summer_menu, desc(n_item))
###가을
fall_menu <- cafe %>% 
  filter(season == '가을') %>% 
  group_by(item) %>% 
  summarise(n_item = n())

arrange(fall_menu, desc(n_item))
### 겨울
winter_menu<- cafe %>% 
  filter(season == '겨울') %>% 
  group_by(item) %>% 
  summarise(n_item = n())
arrange(winter_menu, desc(n_item))

## 매출현황 시각화 작업
cafe$date <- as.Date(cafe$order_date)

date_sales <- cafe %>% 
  group_by(date) %>% 
  summarise(sales = sum(price))
ggplot(date_sales, aes(x=date, y=sales)) + geom_line()

## 카테고리별 판매 건수 시각화
category_order <- cafe %>% 
  group_by(category) %>% 
  summarise(n_order = n())
ggplot(category_order,aes(x=category, y=n_order)) + geom_col()

## 월별 판매 건수 시각화
month_order <- cafe %>% 
  group_by(month) %>% 
  summarise(n_order = n())
ggplot(month_order, aes(x=month, y=n_order)) + geom_col()

## 요일별 판매 건수 시각화
weekday_order <- cafe %>% 
  group_by(weekday) %>% 
  summarise(n_order = n())
ggplot(weekday_order, aes(x=weekday, y=n_order))+geom_col()

## 시간대별 판매 건수 시각화
time <- substring(cafe$order_date, 12,13)
table(time)

time_order <- as.data.frame(table(time))
time_order
ggplot(time_order, aes(x=time, y= Freq)) + geom_col()
arrange(time_order, desc(Freq))

tail(sort(format(cafe$order_date, '%H:%M:%S')))
times <- sort(format(cafe$order_date, '%H:%M:%S'))
times <- as.data.frame(table(times))
times
str(times)
ggplot(times, aes(x=times, y=Freq))+geom_histogram()
