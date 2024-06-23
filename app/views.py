from django.shortcuts import render, get_object_or_404, redirect  # Thêm 'redirect' vào đây
from django.http import HttpResponse, JsonResponse
from django.views.decorators.http import require_POST
from .models import Product, Order, OrderItem
import json

                            


def home(request):
    products = Product.objects.all()
    context = {'products': products}
    return render(request, 'app/home.html', context)

def cart(request):
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
    return render(request, 'app/cart.html', context)

def checkout(request):
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

@require_POST
def add_to_cart(request):
    if request.method == 'POST':
        product_id = request.POST.get('productId')
        action = request.POST.get('action')

        if product_id and action:
            try:
                product = get_object_or_404(Product, id=product_id)
                order, created = Order.objects.get_or_create(customer=request.user.customer, complete=False)
                order_item, created = OrderItem.objects.get_or_create(order=order, product=product)

                if action == 'add':
                    order_item.quantity += 1
                elif action == 'remove':
                    if order_item.quantity > 0:
                        order_item.quantity -= 1

                order_item.save()

                
                return redirect('home')  

            except Product.DoesNotExist:
                return JsonResponse({'error': 'Product not found'}, status=404)

    return JsonResponse({'error': 'Invalid request'}, status=400)

