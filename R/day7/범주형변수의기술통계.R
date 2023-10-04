#별도의 기억장소에 저장된 패키지 설치 방법 - github

install.packages('devtools')

#패키지 설치

devtools::install_github(('kilhwan/bizstatp'))

#패키지 로딩

library(bizstatp)

#데이터 확인
str(course)

#데이터 전체 요약 보고서
summary(course)


#변수들 간의 상관관계를 파악 - 산점도
plot(course)


#수치형 데이터를 이용한 상관분석 
plot(course[,5:8])

#범주형 변수의 기술통계
head(course)

#절대빈도표 table(), xtabs()
##table(벡터) or table(데이터프레임$칼럼)
##xtabs(수식_formula, data=데이터프레임, subset)
table(course$major)

xtabs(~year, course)
xtabs(~year, course, gender == 'M')
xtabs(~year, course, class ==2)

#상대빈도표
dataYear <- xtabs(~year, course);dataYear
dataMajor <- xtabs(~major, course);dataMajor
dataGender <- xtabs(~gender, course); dataGender
dataClass <- xtabs(~class, course); course

## 상대빈도표를 만드는 함수 : proportions(절대빈도표), prop.table()
### 학년과 성별에 대한 상대 빈도표
proportions(dataYear)
round(proportions(dataYear),2)
proportions(dataGender) * 100

## 막대 그래프
### ggplot(데이터, aes(범주형변수)) + geom_bar()
ggplot(course, aes(year)) + geom_bar(fill='orange')

### 상대 빈도를 이용하여 막대그래프를 그릴 떄
### ggplot(데이터, aes(x=범주형변수, y=after_stat(prop), group=1)) + geom_bar()
ggplot(course, aes(year, after_stat(prop), group=1)) + geom_bar() 
                                                    #+ coord_flip() 하면 xy축 반전

##빈도 순으로 막대를 표시하는 함수
### ggplot(데이터, aes(x=reorder(범주형변수, 범주형변수,length))) + geom_bar()
str(mpg)
ggplot(mpg, aes(reorder(class, class, length))) +
         geom_bar() +
         coord_flip() +
         labs(x='자동차 종류')

ggplot(course, aes(reorder(year,year,length))) + geom_bar()

reorder(course$gender, course$score, mean)

ggplot(course, aes(reorder(gender, score, mean), score)) + geom_boxplot()                                                    
#파이 차트 : pie(빈도표)
pie(dataYear, main = '학년별 수강생 비율')

labels <- paste0(names(dataYear), '학년: ', round(proportions(dataYear)*100,2), '%')
labels

pie(dataYear, main = '학년별 수강생 비율', label = labels)


#범주형 변수들 간의 상관성을 수치로 요약하는 방법- 교차표
##절대 빈도로 교차표(분할표)를 만든다.
###table(), xtabs(), acast()나 dcast() - reshape2 패키지, count() -dplyr

### 행, 열, 면(층, layer)
table(course$gender, course$year, course$class)

#xtabs() 함수를 이용해서 교차표
data <- xtabs(~gender + year, course)
data

xtabs(~gender + year, course, score >= 80)

#조원 조퇴

#두 범주형 변수의 누적막대 그래프
ggplot(course, aes(x=year, fill=gender)) + geom_bar()

ggplot(course, aes(x=year, fill=gender)) + geom_bar(position = 'dodge') 

ggplot(course, aes(x=gender, fill=year)) + geom_bar(position = 'dodge')


#상대 빈도를 이용한 막대 그래프 -- 비율
ggplot(course,aes(x=year, fill=gender)) + geom_bar(position = 'fill')


#모자이크 그래프 : ggmosaic
## 패키지 설치
install.packages('vcd')
library(vcd)
## mosaic(범주형변수2 ~ 범주형변수1, data, direction = 'v')
mosaic(gender ~ year, course, direction = 'v')


#---------------------------------------------------
#관절염 치료 임상실험 데이터 분석

str(Arthritis)
#문제 정의
##새로운 치료법은 효과가 있는가?
##치료법(Treatment)과 증상 개선(Improved) 여부

TIgroup <- Arthritis %>%
  group_by(Treatment) %>%
  select(Treatment, Improved)

TIgroup
table(TIgroup)


#강사님답안

check <- xtabs(~Treatment + Improved, Arthritis);check

round(proportions(check, margin=1)*100,2)

#두 범주형 변수가 상관이 있는지를 보는
chisq.test(check) #귀무가설 차이가 없다를 기각, 두 수단 간 차이가 있다



## 2. 새로운 치료법의 효과는 성별로 차이가 있는가?
## None < Some < Marked

tsi_placebo <- xtabs(~ Sex + Improved, Arthritis, subset = Treatment =="Placebo")
tsi_placebo

round(proportions(tsi_placebo, margin=1)*100,2)

#샘플수가 적으니 피셔검정 사용

fisher.test(tsi_placebo) #귀무가설 채택, 성별과는 상관없다

ggplot(Arthritis)


#-------------------------------------------------------
#이혼에 대한 사회조사 데이터셋

BrokenMarriage

help("BrokenMarriage")

#구조를 잘 보면, 일반적인 데이터와 다르다.
#각각의 데이터가 아니라, 이미 Freq으로 그룹화된 빈도가 나타난 데이터다.
#따라서 처리도 다르게 해야한다.


#xtabs(빈도 변수 ~ 범주형변수 +..., data)

tgb <- xtabs(Freq ~ gender + broken, BrokenMarriage)
tgb

round(proportions(tgb, 1)*100,2)

chisq.test(tgb) #성별과 이혼은 서로 관계가 없다


trg <- xtabs(Freq ~ rank + gender, BrokenMarriage);trg

chisq.test(trg) #귀무가설 기각, 성별과 사회계급은 관계가 있다


##geom_bar 보단 geom_col
## ggplot(data, aes(x=범주형변수1, y=빈도변수, fill= 범주형변수2)) +geom_col()

ggplot(BrokenMarriage, aes(x=rank, y=Freq, fill = broken)) +
  geom_col() +
  facet_wrap(~gender)











