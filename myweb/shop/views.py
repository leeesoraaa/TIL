from django.shortcuts import render, redirect
from shop.models import Product, Cart

# 이미지 경로 설정
UPLOAD_DIR = "c:/k-digital/web/myweb-t/shop/static/images/"

# Create your views here.
# 상품관리
def product_list(request):
    ## 상품테이블에 존재하는 모든 상품을 읽어와 웹에 보여주는 역할
    ## select * from shop_product order by product_name;
    productList = Product.objects.order_by('product_name')
    return render(request, 'shop/product_list.html',
                  {'productList':productList, 'count':len(productList)})

# 상품 추가
def product_write(request):
    ## 새로운 상품을 등록하기 위한 폼을 호출하는 역할의 메서드
    if request.session.get('userid', False):  # False는 비밀번호는 없어도 됨을 의미함 userid만 있다면 회원으로 인식
        return render(request, 'shop/product_write.html')
    else: # 회원이 아닌경우 (=userid 없음)
        return redirect('/member/login')

# 상품 등록
def product_insert(request):
    ## 상품등록폼을 통해 입력된 값을 가져와 db에 저장하는 작업을 수행하는 메서드
    ## 상품관련 이미지가 존재하는지의 여부에 따라 처리 달라짐
    if "file1" in request.FILES: # 상품이미지가 존재한다면
        file = request.FILES['file1']
        file_name = file._name
        fp = open("%s%s"%(UPLOAD_DIR, file_name), "wb")  # 파일경로, 모드(wb:작성모드)
        for chunk in file.chunks():   # 파일이 담고 있는 모든 객체를 비트 단위로 (chunk) 반복하여 읽어 담으라는 뜻
            fp.write(chunk)
        fp.close()
    else:  # 상품이미지가 없다면
        file_name = '-'

    row = Product(product_name=request.POST['product_name'],
                  price=request.POST['price'],
                  description=request.POST['description'],
                  picture_url=file_name)

    row.save()

    return redirect('/shop/product_list')

# 특정 상품의 상세보기
def product_detail(request):
    pid = request.GET['product_id']
    row = Product.objects.get(product_id=pid)
    return render(request, 'shop/product_detail.html', {'row':row, 'range':range(1, 21)})

# 상품 수정 폼
def product_edit(request):
    if request.session.get('userid', False):
        pid = request.GET['product_id']
        row = Product.objects.get(product_id=pid)
        return render(request, 'shop/product_edit.html', {'row':row})
    else:
        return redirect('/member/login')

# 상품 수정 반영
def product_update(request):
    id = request.POST['product_id']
    row_src = Product.objects.get(product_id = id) # 원본데이터

    p_url = row_src.picture_url
    if 'file1' in request.FILES:  # 이미지 파일이 바뀌었다면
        file = request.FILES['file1']
        p_url = file._name  # 새 파일의 이름을 가져와 p_url에 담아라

        fp = open("%s%s" % (UPLOAD_DIR, p_url), "wb")
        for chunk in file.chunks():  # chunk는 파일의 이미지를 비트단위로 가져오기 위해 사용
            fp.write(chunk)
        fp.close()

    row_new = Product(product_id=id, product_name=request.POST['product_name'],
                      price=request.POST['price'], description=request.POST['description'],
                      picture_url=p_url)
    row_new.save()
    return redirect('/shop/product_list')

# 상품 삭제
def product_delete(request):
    id = request.POST['product_id']
    Product.objects.get(product_id=id).delete()
    return redirect('/shop/product_list')

# ----------------------------------------------------------------------------
# 장바구니 함수
# ---------------------------------------------------------------------------
# 장바구니에 상품 추가
def cart_insert(request):
    uid = request.session.get('userid', '')
    if uid != "":  # 회원인 경우
        row = Cart(userid=uid, product_id=request.POST['product_id'], amount=request.POST['amount'])
        row.save()
        return redirect('/shop/cart_list')
    else:  # 비회원인 경우
        return redirect('/member/login')

# 장바구니 목록보기
def cart_list(request):
    uid = request.session.get('userid', '')
    if uid != "": # 회원인 경우
        # Cart 테이블: 상품번호, 사용자 아이디, 수량
        # Product 테이블: 상품번호, 상품명, 가격
        cartList = Cart.objects.raw("""
        select cart_id, userid, amount, c.product_id, product_name, price, amount*price money
        from shop_product p, shop_cart c
        where p.product_id = c.product_id and userid = '{0}'
        """.format(uid))
        # 총 상품 금액
        sumMoney = 0
        # 배송료
        fee = 0
        # 총 결제 금액(총 상품 금액 + 배송료)
        total = 0
        cartCount = len(cartList)
        if cartCount > 0:
            # 장바구니 금액의 합계
            sumRow = Cart.objects.raw("""
                select sum(amount*price) cart_id 
                from shop_cart c, shop_product p
                where c.product_id=p.product_id and userid='{0}'  
            """.format(uid))
            sumMoney = sumRow[0].cart_id
            # 배송료 구매금액이 50000원 이상이면 배송료 0, 그렇지 않으면 2500
            if sumMoney >= 50000:
                fee = 0
            else:
                fee = 2500

            # 총 구매 금액
            total = sumMoney + fee
        return render(request, 'shop/cart_list.html', {'cartList':cartList, 'cartCount':cartCount,
                                                       'sumMoney':sumMoney, 'fee':fee, 'total':total})
    else:
        return redirect('/member/login')

# 장바구니 수정
def cart_update(request):
    uid = request.session.get('userid', '')
    if uid != "": # 회원인 경우
        amt = request.POST.getlist('amount')  # 여러 개의 변수를 가져오기 위해 getlist()
        cid = request.POST.getlist('cart_id')
        pid = request.POST.getlist('product_id')
        for idx in range(len(cid)):
            row = Cart(cart_id=cid[idx], userid=uid, product_id = pid[idx],
                       amount=amt[idx])
            row.save()
        return redirect('/shop/cart_list')
    else: # 비회원인 경우
        redirect('/member/login')

# 장바구니 하나의 제품 삭제
def cart_del(request):
    Cart.objects.get(cart_id=request.GET['cart_id']).delete()
    return redirect('/shop/cart_list')

# 장바구니 전체 삭제
def cart_del_all(request):
    uid = request.session.get('userid', '')
    if uid != "":
        Cart.objects.filter(userid=uid).delete()
        return redirect('/shop/cart_list')
    else:
        return redirect('/member/login')