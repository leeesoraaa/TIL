library(foreign)
row <- read.spss('C:/k-digital/data/HN21/HN21_ALL.sav', 
                 to.data.frame = T)
View(row)
dat <- read.spss('C:/k-digital/data/test3.sav',
                 to.data.frame = T,
                 reencode = 'utf-8')  # 한글이 깨졌을 때
View(dat)

# 방대한 데이터의 형태를 파악하는 패키지
install.packages('DataExplorer')
library(DataExplorer)
introduce(row)   # discrete_columns: 이산형 변수
# continuous_columns: 연속형 변수

# 변수별 결측률 확인
profile_missing(row)

# 결측률이 90% 이상인 데이터만 추출
row_missing <- profile_missing(row)
subset(row_missing, pct_missing > 0.9)

library(dplyr)
arrange(subset(row_missing, pct_missing > 0.9), desc(pct_missing))
































