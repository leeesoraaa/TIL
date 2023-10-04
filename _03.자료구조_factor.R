# factor(팩터): 범주형 데이터(질적 데이터)를 관리하는 자료구조
## 명목형과 서열형
## factor(x, levels, ordered)
v_c = c('사과', '복숭아','사과','오렌지','사과','오렌지','복숭아')
v_c

str(v_c)
v_factor = factor(v_c)
str(v_factor)
v_factor
mode(v_factor)

# is~ 형 확인, as~ 형 변환
## numeric(integer, double), character, logical, complex
## 자료형확인: mode(), typeof()

is.numeric(v_factor)
mode(v_factor)
typeof(v_factor)
is.integer(v_factor)

v_factor=as.character(v_factor) #""생김
is.character(v_factor) 

## 팩터 확인
v_factor
v_num = as.numeric(v_factor)
v_num






