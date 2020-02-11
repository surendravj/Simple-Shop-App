import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shop/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return _items;
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get favItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  String token;
  Products(this.token,this._items);
  // Function to fetch products from server
  Future<void> getAndFetchProducts() async {
    final url = 'https://vuejs-demo-43f51.firebaseio.com/products.json?auth=$token';
    try {
      final response = await http.get(url);
      var data = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedData = [];
      data.forEach((key, value) {
        loadedData.add(Product(
            id: key,
            description: value['description'],
            title: value['title'],
            imageUrl: value['imageUrl'],
            price: value['price']));
      });
      _items = loadedData;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = 'https://vuejs-demo-43f51.firebaseio.com/products.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'id': product.id,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite
          }));
      var newProduct = Product(
          imageUrl: product.imageUrl,
          id: json.decode(response.body)['name'],
          title: product.title,
          price: product.price,
          description: product.description);
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateItems(String id, Product newProduct) async {
    final url = 'https://vuejs-demo-43f51.firebaseio.com/products/$id.json';
    await http.patch(url,
        body: json.encode({
          'title': newProduct.title,
          'imagrUrl': newProduct.imageUrl,
          'price': newProduct.price,
          'description': newProduct.description
        }));
    notifyListeners();
    _items[_items.indexWhere((element) => element.id == id)] = newProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://vuejs-demo-43f51.firebaseio.com/products/$id.json';
    _items.removeWhere((element) => element.id == id); 
    http.delete(url);
    notifyListeners();
  }
}
