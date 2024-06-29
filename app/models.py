from django.db import models
from django.contrib.auth.models import User

class Customer(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=200, null=True, blank=True)
    email = models.EmailField(max_length=200, null=True, blank=True)

    def __str__(self):
        return str(self.name) if self.name else str(self.user.username)


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
        customer_name = self.customer.name if self.customer else 'Unknown Customer'
        customer_email = self.customer.email if self.customer else 'Unknown Email'
        order_items = ', '.join([str(item) for item in self.order_items.all()])
        return f"Order ID: {self.id} - Customer: {customer_name} ({customer_email}) - Items: {order_items}"

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
    order = models.ForeignKey(Order, on_delete=models.SET_NULL, blank=True, null=True, related_name='order_items')
    quantity = models.IntegerField(default=0, null=True, blank=True)
    date_added = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        product_name = str(self.product.name) if self.product and self.product.name else 'Unknown Product'
        return f"{self.quantity} x {product_name}"

    @property
    def get_total(self):
        if self.product and self.product.price is not None:
            total = self.product.price * self.quantity
            return total
        return 0

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

class Warehouse(models.Model):
    name = models.CharField(max_length=200, null=True, blank=True)
    location = models.CharField(max_length=200, null=True, blank=True)
    capacity = models.IntegerField(default=0)
    current_stock = models.IntegerField(default=0)

    def __str__(self):
        return str(self.name)

class Stock(models.Model):
    warehouse = models.ForeignKey(Warehouse, on_delete=models.CASCADE, related_name='stocks')
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='stocks')
    quantity = models.IntegerField(default=0)

    def __str__(self):
        return f"{self.product.name} in {self.warehouse.name}"

class OrderWarehouse(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='order_warehouses')
    warehouse = models.ForeignKey(Warehouse, on_delete=models.CASCADE, related_name='order_warehouses')
    status = models.CharField(max_length=200, choices=[('pending', 'Pending'), ('shipped', 'Shipped'), ('delivered', 'Delivered')], default='pending')

    def __str__(self):
        return f"Order {self.order.id} - {self.warehouse.name}"

class Payment(models.Model):
    order = models.OneToOneField(Order, on_delete=models.CASCADE, related_name='payment')
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    date_paid = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=200, choices=[('pending', 'Pending'), ('completed', 'Completed')], default='pending')

    def __str__(self):
        return f"Payment for Order {self.order.id}"

class Shipment(models.Model):
    order = models.OneToOneField(Order, on_delete=models.CASCADE, related_name='shipment')
    shipping_address = models.ForeignKey(ShippingAddress, on_delete=models.CASCADE, related_name='shipments')
    date_shipped = models.DateTimeField(auto_now_add=True)
    date_delivered = models.DateTimeField(null=True, blank=True)
    status = models.CharField(max_length=200, choices=[('pending', 'Pending'), ('shipped', 'Shipped'), ('delivered', 'Delivered')], default='pending')

    def __str__(self):
        return f"Shipment for Order {self.order.id}"

class Revenue(models.Model):
    date = models.DateField(auto_now_add=True)
    total_revenue = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"Revenue on {self.date}"
    

