# 데이터프레임(dataframe): 데이터베이스의 표(table)
## 단일 자료형을 사용하는 자료구조: 변수, 벡터, 팩터, 행렬, 배열
## 다중 자료형을 사용하는 자료구조: 데이터프레임, 리스트
## 데이터분석의 기본 자료형: 행(record, 관측데이터), 열(attribute, feature, 특성)
help(data.frame)

## 데이터프레임 생성, as.data.frame(matrix)
## data.frame(data, matrix)
aa= data.frame(x=c(1,2,3,4,5), y = c('a','b','c','d','e'))
aa

## 여러 개의 벡터를 이용한 데이터프레임 생성
names = c('홍길동', '이순신', '장보고', '임꺽정','김유신')
ages = c(20,23,31,28,35)
scores = c(80,95,87,100,79)
gender = factor(c('F', 'M', 'M', 'F', 'F'))

student = data.frame(names, ages, scores, gender)
student
stu = data.frame(name=names, age=ages, gender=gender, score=scores)
stu

str(stu)
## $:특정 열 추출
stu$name
stu$name[3]
stu[4,2]

#gender와 score만 추출
stu[,3:4]











