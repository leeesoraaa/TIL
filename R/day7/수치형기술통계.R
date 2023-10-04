#수치형 변수의 기술통계

#하나의 수치형 변수의 분포 분석
##수치형 변수의 중심점이 어디있냐, 가장 빈번하게 발생하는 수치는 뭐냐
## 수치형 변수의 값이 얼마나 넓게 퍼져있냐, 특정값의 중심에 몰려있느냐
##분포 대칭적이냐 아니면 비대칭
##이상치 존재여부 

#전에 했던 mean, var 같은것들 복습하심


#추세선  geom_smooth(method = 'lm')
ggplot(course, aes(x=mid, y=final)) + geom_point() +
  geom_smooth(method = 'lm')

##ggpairs() : 확률밀도 그래프, 산점도
install.packages('GGally')

#기존에 갖고 있는 함수와 설치한 패키지의 함수 이름이 같을 경우,
GGally::ggpairs(course, 5:8)


#slice_sample()
str(diamonds)

diamonds_sample <- slice_sample(diamonds, prop= 0.1)

ggplot(diamonds_sample, aes(x=carat, y=price)) +
  geom_point() + geom_smooth()

cor(diamonds_sample$carat, diamonds_sample$price)

ggplot(diamonds_sample, aes(x=carat, y=price)) +
  geom_point() + geom_smooth() +
  scale_x_log10() + scale_y_log10() #로그변환해서 단위를 맞춰줌

cor(log10(diamonds_sample$carat), log10(diamonds_sample$price))

#범주형 변수를 조건으로 수치형 변수의 상관분석
ggplot(diamonds_sample, aes(x=carat, y=price, color = cut)) +
  geom_smooth(se=F) +
  scale_x_log10() + scale_y_log10()


ggplot(diamonds_sample, aes(x=carat, y=price, color = clarity)) +
  geom_smooth(se=F) +
  scale_x_log10() + scale_y_log10()



ggplot(diamonds_sample, aes(x=carat, y=price)) +
  geom_point() +
  geom_smooth(se=F) +
  scale_x_log10() + scale_y_log10() +
  facet_wrap(~ clarity)
