import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/order.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/edit_products_screen.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/product_detail_screen.dart';
import 'package:shop/screens/products_overview_screen.dart';
import 'package:shop/screens/user_product_screen.dart';
import './providers/products_provider.dart';

void main() {
  var shop = Shop();
  runApp(shop);
}

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        title: 'Shop',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrangeAccent,
            fontFamily: 'Lato'),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductsScreen.routeName: (ctx) => EditProductsScreen(),
        },
      ),
    );
  }
}
