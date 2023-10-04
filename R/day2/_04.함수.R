#함수(Function)
## 내장 함수와 사용자 정의 함수
### R에서 함수를 정의하는 방법
gugu <- function(){
  dan <- readline('단을 입력하세요:')
  dan <- as.integer(dan)
  
  for(i in 1:9){
    cat(paste(dan, 'x', i, '=', dan*i, '\n'))
  }
}

#함수호출
gugu()

# 구구단 출력
for(dan in 2:9){ 
  cat(paste('\n', dan, '단 결과값', '\n'))
 for(i in 1:9){
    cat(paste(dan, 'x', i, '=', dan*i, '\n'))
 }}

## 1부터 100까지의 합을 계산하여 출력하는 프로그램
tot = 0
for(i in 1:100){
  tot <- tot + i
}
tot

## while
tot <- 0 
i <- 1 #시작값 필요
while(i<101){
  tot <- tot + i
  i <- i + 1
}
tot

##repeat: 무한루프이므로 탈출조건 필요
tot<-0
i <- 1
repeat{
  tot <- tot + i
  i <- i+1
  if(i > 100) break
}
tot





