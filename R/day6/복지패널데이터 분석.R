# 복지패널 데이터를 이용한 데이터 분석

# step1. 필요 패키지 설치 및 로딩
install.packages('foreign')  # spss 전용파일 등 외부 파일 불러올 때
library(foreign)
library(readxl)
library(ggplot2)
library(dplyr)

# step2. 데이터셋 로딩
raw <- read.spss(file = 'C:/k-digital/data/Koweps_hpc10_2015_beta1.sav',
                 to.data.frame = T)

# step3. 데이터 복사본 만들기
welfare <- raw

# step4. 데이터 구조 및 기본 정보 확인
dim(welfare)
str(welfare)

# step5. 파생변수 생성 또는 변수명 변경 - 가독성을 위해
welfare <- rename(welfare, 
       gender = h10_g3,
       birth_year = h10_g4,
       marry = h10_g10,
       religion= h10_g11,
       code_job= h10_eco9,
       income = p1002_8aq1,
       code_region = h10_reg7)

## 1. 성별에 따른 급여의 차이가 있을까?
### 성비 분석: 남여의 도수분포표
table(welfare$gender) 
str(welfare$gender)
addmargins(table(welfare$gender))  # 결측값 없이 1,2만 존재함
### 'M'(1)과 'F'(2)로
welfare$gender <- ifelse(welfare$gender == 1, 'M', 'F')
### 시각화
ggplot(welfare, aes(gender)) + geom_bar()
### 급여정보 분석
str(welfare$income)
summary(welfare$income)
tail(table(welfare$income),20)
### 성별로 그룹화한 급여
gender_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(gender) %>% 
  summarise(mean_income = mean(income))
gender_income
table(gender_income)
### 시각화
ggplot(gender_income, aes(x=gender, y=mean_income)) + geom_col()

## 2. 나이와 급여의 관계는 있을까?
table(is.na(welfare$birth_year)) # 결측값 없음
summary(welfare$birth_year)
### 파생변수(age) = 현재년도(2015) - 출생년도 +1
welfare$age <- 2015 - welfare$birth_year + 1
summary(welfare$age)
age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))
### 시계열 시각화
ggplot(age_income, aes(x=age, y=mean_income)) + geom_line()

## 3. 연령대에 따른 급여의 차이가 있을까?
### 연령대: 초년(30세 미만)-young, 중년(60세미만)-middle, 노년(60세이상)-old
welfare$gen <- ifelse(welfare$age < 30,
                      'young',
                      ifelse(welfare$age < 60,
                             'middle', 'old'))
table(welfare$gen)
gen_income <- welfare %>%
  filter(!is.na(income)) %>% 
  group_by(gen) %>% 
  summarise(mean_income = mean(income))
gen_income
### 시각화
ggplot(gen_income,aes(x=gen, y=mean_income)) + geom_col()

## 4. 연령대와 성별에 따른 급여의 차이는 있을까?
welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(c(gen, gender)) %>% 
  summarise(mean_income = mean(income))
## 5. 직업별 급여의 차이는 있을까?

## 6. 성별에 따른 선호하는 직군이 있는가?
### 엑셀파일에서 특정 시트에 있는 내용을 불러오는 작업
joblist <- read_excel('C:/k-digital/data/Koweps_Codebook.xlsx', sheet=2, col_names = T)
tail(joblist)
str(joblist)
### welfare 데이터프레임과 joblist 데이터 프레임 합치기
welfare <- left_join(welfare, joblist, by = 'code_job')
?left_join
tail(welfare)
names(welfare)

View(welfare$job)
table(is.na(welfare$job))
### 남자가 선호하는 직군
M_preferjob <- welfare %>% 
  filter(!is.na(job) & gender == 'M') %>%
  group_by(job) %>% 
  summarise(M_job = n())
#### 시각화
ggplot(M_preferjob, aes(x=job, y=M_job)) + geom_col()
M_preferjob[M_preferjob$M_job == max(M_preferjob$M_job),]
#### 상위 10개만 시각화
M_preferjob <- welfare %>% 
  filter(!is.na(job) & gender == 'M') %>%
  group_by(job) %>% 
  summarise(M_job = n()) %>% 
  arrange(desc(M_job)) %>% 
  head(,10)
M_preferjob
ggplot(M_preferjob, aes(x=job, y=M_job)) + geom_col() 

### 여자가 선호하는 직군 상위 10개
F_preferjob <- welfare %>% 
  filter(!is.na(job) & gender == 'F') %>% 
  group_by(job) %>% 
  summarise(F_job = n()) %>% 
  arrange(desc(F_job)) %>% 
  head(,10)
F_preferjob
#### 시각화
ggplot(F_preferjob, aes(x=job, y= F_job)) + geom_col()

## 7. 직군별 급여의 차이는 있는가?

## 8. 종교 유무에 따른 이혼율의 차이는 있는가?

## 9. 지역별 연령대 비율은 어떤가?
