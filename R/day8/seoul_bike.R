# packages install
# load data
bike <- read.csv('C:/k-digital/data/seoul_bike/SeoulBikeData.csv')
summary(bike)
head(bike)

# 회귀-예측
names(bike)

## Date: 대여일(년-월-일)
## Rented_Bike_Count: 대여 자전거 수
## Hour: 대여 시간
## Temperature: 온도
## Humidity: 습도(%)
## Wind_speed: 풍속(m/s)
## Dew_point_temperature: 이슬점
## Solar_Radiation: 일사량
## Rainfall: 강우량
## Snowall: 적설량
## Seasons: 계절
## Holiday: 평일/주말
## Functioning_Day: 비근무시간(NoFunc)/근무시간(Fun)

# 산점도 그래프 scatter plot: 온도와 자전거 대여 수의 상관성
plot(x=bike$Temperature, y= bike$Rented_Bike_Count)

# 선형 회귀분석
## 회귀방정식 y = ax + b
model <- lm(Rented_Bike_Count ~ Temperature, bike)
model
summary(model) ## Residuals: 잔차, Coefficients: 상관관계

## 예측 y = ax + b
## a = 29.08
## b = 329.95  Intercept
temp_temperature = 23
a = 29.08
b = 329.95

y=a*temp_temperature + b
y

# 회귀선 추가
plot(x=bike$Temperature, y= bike$Rented_Bike_Count)
abline(a=b, b=a, col='red')

# 여러 개의 값을 이용한 예측
temperature_list = c(-10,0,10,20,30,40)
new <- data.frame(Temperature = temperature_list)
pred_list <- predict(model, newdata = new)

data.frame(Temperature = temperature_list, 
           pred_bike_count = pred_list)


    




