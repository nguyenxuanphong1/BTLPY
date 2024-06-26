from .models import Order

def cart_items(request):
    cart_items = 0
    if request.user.is_authenticated:
        order_qs = Order.objects.filter(customer=request.user.customer, complete=False)
        if order_qs.exists():
            order = order_qs[0]
            cart_items = order.get_cart_items

    return {'cart_items': cart_items}
