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

        return redirect('order_complete')  

    else:
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

                if request.user.is_authenticated:
                    customer = request.user.customer
                    order, created = Order.objects.get_or_create(customer=customer, complete=False)
                else:
                    order, created = Order.objects.get_or_create(complete=False)

                order_item, created = OrderItem.objects.get_or_create(order=order, product=product)

                if action == 'add':
                    order_item.quantity += 1
                elif action == 'remove':
                    if order_item.quantity > 0:
                        order_item.quantity -= 1

                order_item.save()

                return redirect('cart')

            except Product.DoesNotExist:
                return JsonResponse({'error': 'Không tìm thấy sản phẩm'}, status=404)

    return JsonResponse({'error': 'Yêu cầu không hợp lệ'}, status=400)


def process_payment(request):
    customer = request.user.customer
    order = Order.objects.filter(customer=customer, complete=False).first()

    if not order:
        messages.error(request, 'Không tìm thấy đơn hàng cần thanh toán.')
        return redirect('cart') 
    if request.method == 'POST':
        card_name = request.POST.get('cardName')
        card_number = request.POST.get('cardNumber')
        expiry_date = request.POST.get('expiryDate')
        cvv = request.POST.get('cvv')

        payment_status = 'completed'  

        if payment_status == 'completed':
            order.complete = True
            order.save()

            Payment.objects.create(
                order=order,
                amount=order.get_cart_total,
                status=payment_status
            )

            messages.success(request, 'Thanh toán thành công!')
            return redirect('payment_confirmation')
        else:
        
            messages.error(request, 'Thanh toán thất bại. Vui lòng thử lại.')

    context = {
        'order': order,
    }
    return render(request, 'app/process_payment.html', context)


def process_shipping(request):
    if request.method == 'POST':
        customer = request.user.customer
        order, created = Order.objects.get_or_create(customer=customer, complete=False)
        
        name = request.POST.get('name')
        email = request.POST.get('email')
        address = request.POST.get('address')
        city = request.POST.get('city')
        state = request.POST.get('state')
        mobile = request.POST.get('mobile')

        customer.name = name
        customer.email = email
        customer.save()

        shipping_address, created = ShippingAddress.objects.get_or_create(
            order=order,
            defaults={
                'address': address,
                'city': city,
                'state': state,
                'mobile': mobile,
            }
        )
        
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


def payment_confirmation(request, order_id):
    order = get_object_or_404(Order, id=order_id)
    customer = order.customer
    try:
        payment = order.payment
    except Payment.DoesNotExist:
        payment = None
    shipping_address = order.shipping_address if hasattr(order, 'shipping_address') else None
    items = order.order_items.all()

    context = {
        'order': order,
        'customer': customer,
        'payment': payment,
        'shipping_address': shipping_address,
        'items': items,
    }

    return render(request, 'app/payment_confirmation.html', context)