from django.db import models
from django.contrib.auth.models import User

class Customer(models.Model):
    user = models.OneToOneField(User, on_delete=models.SET_NULL, null=True, blank=False)
    name = models.CharField(max_length=200, null=True, blank=True)
    email = models.EmailField(max_length=200, null=True, blank=True)

    def __str__(self):
        return str(self.name) if self.name else ""

class Product(models.Model):
    name = models.CharField(max_length=200, null=True, blank=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    digital = models.BooleanField(default=False)
    image = models.ImageField(null=True, blank=True)
    
    def __str__(self):
        return str(self.name) if self.name else ""
   
    @property
    def ImageURL(self):
        try:
            url = self.image.url
        except AttributeError: 
            url = ''
        return url

class Order(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.SET_NULL, blank=True, null=True, related_name='orders')
    date_order = models.DateTimeField(auto_now_add=True)
    complete = models.BooleanField(default=False)
    transaction_id = models.CharField(max_length=200, null=True, blank=True)

    def __str__(self):
        return str(self.id)

    @property
    def get_cart_items(self):
        order_items = self.order_items.all()
        total = sum(item.quantity for item in order_items)
        return total

    @property
    def get_cart_total(self):
        order_items = self.order_items.all()
        total = sum(item.get_total for item in order_items)
        return total

class OrderItem(models.Model):
    product = models.ForeignKey(Product, on_delete=models.SET_NULL, blank=True, null=True, related_name='order_items')
    order = models.ForeignKey('Order', on_delete=models.SET_NULL, blank=True, null=True, related_name='order_items')
    quantity = models.IntegerField(default=0, null=True, blank=True)
    date_added = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        product_name = str(self.product.name) if self.product and self.product.name else 'Unknown Product'
        return f"{self.quantity} x {product_name}"

    @property
    def get_total(self):
            total = self.product.price * self.quantity
            return total
    

class ShippingAddress(models.Model):
    order = models.OneToOneField(Order, on_delete=models.SET_NULL, blank=True, null=True, related_name='shipping_address')
    address = models.CharField(max_length=200, null=True, blank=True)
    city = models.CharField(max_length=200, null=True, blank=True)
    state = models.CharField(max_length=200, null=True, blank=True)
    mobile = models.CharField(max_length=200, null=True, blank=True)
    date_added = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        parts = [self.address, self.city, self.state]
        return ', '.join(part for part in parts if part) if any(parts) else ''

