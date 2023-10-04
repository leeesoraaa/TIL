from address import views
from django.urls import path

urlpatterns = [
    # http://localhost/address 주소록 목록 표시
    path('', views.home),

    # 주소록 관리 : 등록, 수정, 삭제, 상세보기
    #http://localhost/address/write
    # 새로운 내용을 입력할 수 있는 웹페이지 = 등록폼
    path('write', views.write),
    
    # 등록폼에서 작성된 내용을 DB에 저장하는 작업, 목록으로 돌아가기
    path('insert', views.insert),

    # 주소록 목록에서 내용을 클릭하면 상세 주소 보기로 이동, 수정과 삭제
    path('detail', views.detail),

    # 수정폼
    path('update', views.update),

    # 삭제 후 목록
    path('delete', views.delete),
]