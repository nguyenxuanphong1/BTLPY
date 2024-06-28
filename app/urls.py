from django.contrib import admin
from django.urls import path, include
from . import views

urlpatterns = [
    path('', views.home, name="home"),
    path('cart/', views.cart, name="cart"),
    path('checkout/', views.checkout, name="checkout"),
    path('about/', views.about, name="about"),
    path('add_to_cart/', views.add_to_cart, name="add_to_cart"),
    path('search/', views.search, name="search"),
    path('manage_warehouses/', views.manage_warehouses, name="manage_warehouses"),
    path('manage_stock/', views.manage_stock, name='manage_stock'),
    path('update_stock/<int:warehouse_id>/<int:product_id>/', views.update_stock, name="update_stock"),
     path('process-shipping/', views.process_shipping, name='process_shipping'),
    path('process-payment/', views.process_payment, name='process_payment'),
    path('payment-confirmation/', views.payment_confirmation, name='payment_confirmation'),
]