# 필요한 패키지 설치 및 로딩
# 엑셀 파일 가져올 때 필요한 readxl 패키지 로딩
library(readxl)

# 데이터셋 로딩
raw<- read_excel('C:/k-digital/data/Sample1.xlsx')

# 사본
data <- raw
View(data)
str(data)

## id만 추출
select(data, ID)

## id, area, age 추출
select(data, ID, AREA, AGE)

## area를 제외하고 추출
select(data, -AREA)

## area가 서울에 해당하는 자료만 추출
filter(data, AREA=='서울')

## area가 서울이면서 Y21_CNT의 거래건수가 10이상인 자료만 추출
data %>% filter(AREA == '서울' & Y21_CNT >= 10)

## age를 기준으로 오름차순 정렬
arrange(data, AGE)

## Y21_AMT를 기준으로 내림차순 정렬
arrange(data, desc(Y21_AMT))

## age 오름차순, Y21_AMT는 내림차순 정렬
arrange(data, AGE, desc(Y21_AMT))

## 21년도 이용금액(Y21_AMT)의 합산결과 (tot_21)추출
tot_21 <- summarise(data, sum(Y21_AMT))
tot_21

## 지역별 21년도 이용금액의 합계 추출
summarise(group_by(data, AREA), sum(Y21_AMT))

















