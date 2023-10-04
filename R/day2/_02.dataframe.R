# 데이터 프레임의 내용에 접근
## [인덱스], [행인덱스, 열인덱스], [행인덱스, 열인덱스, 면인덱스]
## [조건식]
### 팬시인덱스: 조건에 의해 원하는 값을 추출
x = c(FALSE, TRUE, FALSE, FALSE, TRUE)
y = c(1,2,3,4,5)
x
y
typeof(x)
y[x] # 인덱스에 조건을 넣어 참인 값만 추출

a=matrix(1:9,nrow=3)
a
# [행조건식, 열조건식]
a[,2]>4 # FALSE TRUE TRUE
a[a[,2]>4, ]
a[a>4, a>4]

# 데이터프레임에 내용에 접근 $변수명
d = data.frame(x=1:5, y=seq(2,10,2))
d
d$x
d[,'x', drop=F]

#데이터프레임의 열이름(colnames) = names(), 행이름(rownames)
colnames(d)
names(d)
rownames(d) #문자 취급된 숫자

# 여러 개의 벡터를 이용하여 데이터 프레임을 생성
name = c('홍길동', '장보고', '유관순', '이순신', '강감찬')
age = c(20,25,19,30,27)
gender= factor(c('M', 'F', 'F', 'M', 'F'))
blood.type=factor(c('A', 'O', 'AB', 'B', 'O'))

p = data.frame(name, age, gender, blood.type)
p2 = data.frame(name = c('홍길동', '장보고', '유관순', '이순신', '강감찬'),age = c(20,25,19,30,27)
,gender= factor(c('M', 'F', 'F', 'M', 'F'))
,blood.type=factor(c('A', 'O', 'AB', 'B', 'O')))
 p2
p[,2]
p[1,]

## 유관순 정보만 추출
p[p$name == '유관순',]

#이순신의 나이와 혈액형
p[p$name == '이순신', c('age', 'blood.type')]

#데이터 프레임에 유용한 함수
## R에 내장된 데이터셋
data()
# 자동차의 속도와 제동거리의 상관관계를 분석하기 위해 수집된 데이터 셋

## 구조확인
cstr (cars)
cars $speed
car$disit

## 데이터프레임의 속성명을 변수명으로 사용
## attach-설정,detach=,-해제
 attach( cars)
 
detach(cars)

#평균 자동차 속도
mean(cars$speed)
max(cars$speed) # 최고속도

#with 함수
with(cars, mean(speed))

#데이터 프레임의 일부분 추출
head(cars)
tail(cars, 10)

#subset(데이터프레임, 조건식, select)
## select: 특정 컬럼만 추출
## cars 데이터셋에서 속도가 20을 초과하는 데이터만 추출
cars$speed > 20
cars[cars$speed > 20,]
subset(cars, speed > 20)

## 속도가 20이상 23이하인 데이터 추출
subset(cars, speed>=20 & speed<=23)
## 속도가 20이상인 데이터의 dist만 추출
subset(cars, speed >=20, dist)
cars[cars$speed >= 20 & cars$speed <= 23, 'dist', drop=F]




