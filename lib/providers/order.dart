import 'package:flutter/foundation.dart';
import 'package:shop/providers/cart.dart';

class OrderItem {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem(this.id, this.total, this.products, this.dateTime);
}

class Orders with ChangeNotifier {
  List<OrderItem> order = [];

  List<OrderItem> get items {
    return order;
  }

  int get orderLength{
    return order.length;
  }

  void addOrder(List<CartItem> cartproducts, double total) {
    items.insert(0,
        OrderItem(DateTime.now().toString(), total, cartproducts, DateTime.now()));
    notifyListeners();
  }
}
