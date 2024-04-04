from django.db import models

# Create your models here.

# 설문 문제 table
class Survey(models.Model):
    survey_idx = models.AutoField(primary_key=True)
    # 문제
    question = models.TextField(null=False)
    # 답(1~4)
    ans1 = models.TextField(null=True)
    ans2 = models.TextField(null=True)
    ans3 = models.TextField(null=True)
    ans4 = models.TextField(null=True)
    # 설문진행 상태(y=진행중/n=종료)
    status = models.CharField(max_length=1, default='y')

# 응답 table
class Answer(models.Model):
    # 응답 식별값
    answer_idx = models.AutoField(primary_key=True)
    # 설문문항 식별값, 외래키(foreign key), survey 클래스와 조인할 수 있게 함
    survey_idx = models.IntegerField()
    # 응답 번호값
    num = models.IntegerField()
