from django.shortcuts import render, redirect
from address.models import Address
# Create your views here.

def home(request):
    # db에 저장된 주소록의 모든 내용을 가져오는 작업
    # sql = select * from address_address order by idx
    items = Address.objects.order_by('-idx')  # order_by('-idx') = 내림차순
    return render(request, 'address/list.html', {'items':items, 'address_count':len(items)})
    # attribute : 웹상에서 전달되는 데이터들
    # 유효범위 : page, request, session, application

def write(request):
    # 새로운 주소록을 작성할 수 있는 폼을 리턴시켜주는 메서드
    return render(request, 'address/write.html')

def insert(request):
    # write 폼에서 전달받은 데이터를 db에 저장하는 작업을 수행한 후 주소록 목록으로 돌려준다.
    # addr = Address(name, tel, email, address)  addr: 객체, Address: 생성자 메서드
    addr = Address(name=request.POST['name'], tel=request.POST['tel'],
                   email=request.POST['email'], address=request.POST['address'])
    # sql = insert address into values(name, tel, email, address)
    addr.save()
    return redirect('/address')  # address의 url 매핑값 담음
    # 화면이동
    # 1) forword = redirect : 화면만 이동
    # 2) dispatch: 데이터와 함께 이동

def detail(request):
    # 주소록 목록에서 이름을 클릭하면 해당 이름에 사용자 정보를 상세보기 폼으로 보여주는 작업
    # 주소록 목록: list.html  (get 방식)
    id = request.GET['idx']
    # db에서 해당 idx 객체를 가져오는 작업
    # sql = select * from address where idx = id
    addr = Address.objects.get(idx=id)
    # 정렬 후 전체 다 가져올 때는 order_by(정렬기준), 하나만 가져올 때는 get(조건), 정렬 없이 전체 다 가져올 때는 all()
    return render(request, 'address/detail.html', {'addr':addr})

def update(request):
    # 특정 번호에 해당하는 사람의 정보를 수정하는 작업
    # 상세보기 페이지에서 수정 or 삭제가 가능하도록 구현할 것
    # 수정: 수정한 내용 db에 담는 작업 필요
    id = request.POST['idx']  # POST 방식으로 데이터를 모두 가져올 것
    addr = Address(idx = id, name=request.POST['name'], tel=request.POST['tel'],
                   email=request.POST['email'], address=request.POST['address'])
    # 수정된 내용을 db에 저장
    addr.save()
    # 수정이 끝나면 리스트로 반환
    return redirect('/address')

def delete(request):
    id = request.POST['idx']
    Address.objects.get(idx=id).delete()
    # 삭제 후 리스트로 반환
    return redirect('/address')
