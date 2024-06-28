from django.shortcuts import render, get_object_or_404, redirect  # Thêm 'redirect' vào đây
from django.http import HttpResponse, JsonResponse
from django.views.decorators.http import require_POST
from .models import Product, Order, OrderItem, ShippingAddress, Payment
from django.contrib.auth.decorators import login_required
import json
from .models import Product, Warehouse, Stock
from django.contrib import messages
from .models import Customer

def search(request):
    if request.method == 'POST':
        searched = request.POST.get('searched', '')
        products = Product.objects.filter(name__icontains=searched)  # Lọc sản phẩm có tên chứa từ khóa tìm kiếm
        context = {
            'searched': searched,
            'products': products,
        }
        return render(request, 'search.html', context)
    else:
        return render(request, 'search.html', {})

def manage_warehouses(request):
    warehouses = Warehouse.objects.all()
    context = {'warehouses': warehouses}
    return render(request, 'app/manage_warehouses.html', context)

def manage_stock(request, warehouse_id):
    warehouse = get_object_or_404(Warehouse, id=warehouse_id)
    stocks = Stock.objects.filter(warehouse=warehouse)
    context = {
        'warehouse': warehouse,
        'stocks': stocks,
    }
    return render(request, 'app/manage_stock.html', context)

def update_stock(request, warehouse_id, product_id):
    warehouse = get_object_or_404(Warehouse, id=warehouse_id)
    product = get_object_or_404(Product, id=product_id)
    stock, created = Stock.objects.get_or_create(warehouse=warehouse, product=product)

    if request.method == 'POST':
        quantity = request.POST.get('quantity')
        stock.quantity = quantity
        stock.save()

        return redirect('manage_stock', warehouse_id=warehouse.id)

    context = {
        'warehouse': warehouse,
        'product': product,
        'stock': stock,
    }
    return render(request, 'app/update_stock.html', context)

def home(request):
    products = Product.objects.all() 

    context = {
        'products': products, 
    }
    return render(request, 'app/home.html', context)

def cart(request):
    order = None
    items = []
    cart_items = 0
    cart_total = 0.0

    if request.user.is_authenticated:
        customer = request.user.customer
        order, created = Order.objects.get_or_create(customer=customer, complete=False)
        items = order.order_items.all()
        cart_items = order.get_cart_items
        cart_total = order.get_cart_total

    context = {
        'items': items,
        'order': order,
        'cart_items': cart_items,
        'cart_total': cart_total,
    }
    return render(request, 'app/cart.html', context)


def checkout(request):
    if request.method == 'POST':
        customer = request.user.customer
        order, created = Order.objects.get_or_create(customer=customer, complete=False)

        address = request.POST.get('address')
        city = request.POST.get('city')
        state = request.POST.get('state')
        mobile = request.POST.get('mobile')

        shipping_address, created = ShippingAddress.objects.update_or_create(
            order=order,
            defaults={'address': address, 'city': city, 'state': state, 'mobile': mobile}
        )

        # Đánh dấu đơn hàng đã hoàn thành
        order.complete = True
        order.save()

        # Chuyển hướng đến trang hoàn tất thanh toán (hoặc bất kỳ trang nào bạn cần)
        return redirect('order_complete')  # Điều hướng đến trang hoàn tất thanh toán

    else:
        # Nếu không phải POST request, hiển thị trang thanh toán
        items = []
        order = None
        cart_items = 0
        cart_total = 0.0

        if request.user.is_authenticated:
            customer = request.user.customer
            order, created = Order.objects.get_or_create(customer=customer, complete=False)
            items = order.order_items.all()
            cart_items = order.get_cart_items
            cart_total = order.get_cart_total

        context = {
            'items': items,
            'order': order,
            'cart_items': cart_items,
            'cart_total': cart_total,
        }
        return render(request, 'app/checkout.html', context)

def about(request):
    context = {}
    return render(request, 'app/about.html', context)

def add_to_cart(request):
    if request.method == 'POST':
        product_id = request.POST.get('productId')
        action = request.POST.get('action')

        if product_id and action:
            try:
                product = get_object_or_404(Product, id=product_id)
                
                # Tạo hoặc lấy đơn hàng hiện tại
                if request.user.is_authenticated:
                    customer = request.user.customer
                    order, created = Order.objects.get_or_create(customer=customer, complete=False)
                else:
                    order, created = Order.objects.get_or_create(complete=False)
                
                # Thêm sản phẩm vào đơn hàng
                order_item, created = OrderItem.objects.get_or_create(order=order, product=product)

                if action == 'add':
                    order_item.quantity += 1
                elif action == 'remove':
                    if order_item.quantity > 0:
                        order_item.quantity -= 1

                order_item.save()

                # Sau khi thêm vào giỏ hàng thành công, chuyển hướng đến trang giỏ hàng
                return redirect('cart')

            except Product.DoesNotExist:
                return JsonResponse({'error': 'Không tìm thấy sản phẩm'}, status=404)

    return JsonResponse({'error': 'Yêu cầu không hợp lệ'}, status=400)


def process_payment(request):
    customer = request.user.customer
    order = Order.objects.filter(customer=customer, complete=False).first()

    if not order:
        messages.error(request, 'Không tìm thấy đơn hàng cần thanh toán.')
        return redirect('cart')  # Hoặc trang khác mà bạn muốn chuyển hướng đến

    if request.method == 'POST':
        card_name = request.POST.get('cardName')
        card_number = request.POST.get('cardNumber')
        expiry_date = request.POST.get('expiryDate')
        cvv = request.POST.get('cvv')

        # Giả lập quá trình xử lý thanh toán
        # Trong thực tế, bạn sẽ tích hợp với cổng thanh toán tại đây
        # Ví dụ: Stripe, PayPal, etc.

        # Giả lập thanh toán thành công
        payment_status = 'completed'  # Hoặc 'pending', 'failed', tùy theo kết quả thực tế

        if payment_status == 'completed':
            # Cập nhật đơn hàng và tạo bản ghi thanh toán
            order.complete = True
            order.save()

            Payment.objects.create(
                order=order,
                amount=order.get_cart_total,
                status=payment_status
            )

            # Thông báo thành công và chuyển hướng đến trang xác nhận thanh toán
            messages.success(request, 'Thanh toán thành công!')
            return redirect('payment_confirmation')
        else:
            # Thông báo lỗi nếu thanh toán thất bại
            messages.error(request, 'Thanh toán thất bại. Vui lòng thử lại.')

    context = {
        'order': order,
    }
    return render(request, 'app/process_payment.html', context)


def process_shipping(request):
    if request.method == 'POST':
        # Lấy thông tin khách hàng từ request.user.customer
        customer = request.user.customer
        
        # Tạo hoặc lấy đơn hàng hiện tại cho khách hàng
        order, created = Order.objects.get_or_create(customer=customer, complete=False)
        
        # Lấy thông tin địa chỉ giao hàng từ POST data
        address = request.POST.get('address')
        city = request.POST.get('city')
        state = request.POST.get('state')
        mobile = request.POST.get('mobile')

        # Tạo hoặc cập nhật địa chỉ giao hàng
        shipping_address, created = ShippingAddress.objects.get_or_create(
            order=order,
            defaults={
                'address': address,
                'city': city,
                'state': state,
                'mobile': mobile,
            }
        )
        
        # Nếu địa chỉ giao hàng đã tồn tại, cập nhật lại thông tin
        if not created:
            shipping_address.address = address
            shipping_address.city = city
            shipping_address.state = state
            shipping_address.mobile = mobile
            shipping_address.save()

        # Sau khi xử lý địa chỉ giao hàng, chuyển hướng đến trang thanh toán
        return redirect('process_payment')

    # Nếu không phải phương thức POST, chuyển hướng về trang checkout
    return redirect('checkout')


def payment_confirmation(request):
    customer = request.user.customer
    order = Order.objects.filter(customer=customer, complete=True).last()
    items = order.order_items.all()

    context = {
        'customer': customer,
        'order': order,
        'items': items
    }
    return render(request, 'app/payment_confirmation.html', context)
