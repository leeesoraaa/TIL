# 별도의 기억장소에 저장된 패키지 설치 방법 - github
install.packages('devtools')
# 패키지 설치
devtools::install_github('kilhwan/bizstatp')
# 패키지 로딩
library(bizstatp)
course

# 데이터 확인
str(course)

# 데이터 전체 요약 보고서
summary(course)

# 변수들 간의 상관관계를 파악 - 산점도
plot(course)

# 수치형 데이터를 이용한 상관분석
plot(course[,5:8])

# 범주형 변수의 기술 통계
head(course)

# 절대 빈도표 table(), xtabs()
## table(벡터) or table(데이터프레임$컬럼)
## xtabs(수식_formula, data=df, subset)
table(course$major)
xtabs(~ year, course)
xtabs(~ year, course,gender == 'M')
xtabs(~year, course, class == 2)

# 상대빈도표
dataYear <- xtabs(~year, course)
dataYear

dataMajor <- xtabs(~major, course)
dataMajor

dataGender <- xtabs(~gender, course)
dataGender

dataClass <- xtabs(~class, course)
dataClass

## 상대빈도표 생성 함수 proportions(절대빈도표), prop.table()
### 학년과 성별에 대한 상대 빈도표
proportions(dataYear)
proportions(dataGender)
#### 백분율로 출력
proportions(dataClass) * 100
round(proportions((dataClass))*100, 1)

## 막대 그래프
### ggplot(데이터, aes(범주형변수)) + geom_bar()
ggplot(course, aes(year)) + geom_bar(fill = 'orange')

### 상대 빈도를 이용해서 막대그래프를 그릴 때
### ggplot(데이터, aes(x=범주형 변수, y=after_stat(prop), group =1))+geom_bar
ggplot(course, aes(year, after_stat(prop), group = 1)) + geom_bar()

#-----------------------------------------------------------------------
str(mpg)
ggplot(mpg, aes(class)) + geom_bar()
ggplot(mpg, aes(class)) + geom_bar() + coord_flip() # 그래프를 가로로

## 빈도 순으로 막대를 표시하는 함수
### ggplot(데이터, aes(x=reorder(범주형 변수, 범주형 변수, length))) + geom_bar()
### reorder(범주형 변수, 기준변수, 함수)
ggplot(mpg, aes(reorder(class, class, length))) + 
  geom_bar() +
  coord_flip() +
  labs(x='자동차 종류')

ggplot(course, aes(year)) + geom_bar()
ggplot(course, aes(reorder(year, year, length))) + geom_bar()
reorder(course$gender, course$score, mean)
ggplot(course, aes(reorder(gender, score, mean), score))+ geom_boxplot()

# 파이차트: pie(빈도표)
pie(dataYear, main='학년별 수강생 비율')

labels <- paste0(names(dataYear), '학년:', 
                round(proportions(dataYear)*100, 2), '%')
rm(labes)
pie(dataYear, main= '학년별 수강생 비율', label=labels)

# 번주형 변수들 간의 상관성을 수치로 요약하는 방법 - 교차표
## 절대 빈도로 교차표(분할표)를 만든다.
### table(), xtabs(), acast()나 dcast() - reshape2패키지
### count() - dplyr
#### table() 함수를 이용한 교차표
#### table(벡터)
table(course$gender, course$year)
table(course$year, course$gender)

### 행, 열, 면(층, layer)
table(course$gender, course$year, course$class)

# xtabs() 함수를 이용한 교차표
data <- xtabs(~gender + year, course)
data

xtabs(~gender + year, course, score >= 80)
























