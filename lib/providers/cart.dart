import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(this.id, this.title, this.quantity, this.price);
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return _items;
  }

  int get cartCount {
    return _items == null ? 0 : _items.length;
  }

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (existingKey) => CartItem(existingKey.id, existingKey.title,
              existingKey.quantity + 1, existingKey.price));
    } else {
      _items.putIfAbsent(
          id, () => CartItem(DateTime.now().toString(), title, 1, price));
    }

    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    } else if (items[id].quantity > 1) {
      _items.update(
          id,
          (existingValue) => CartItem(existingValue.id, existingValue.title,
              existingValue.quantity - 1, existingValue.price));
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((f, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
