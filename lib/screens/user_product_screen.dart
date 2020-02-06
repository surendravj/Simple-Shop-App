import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/widgets/user_product_item.dart';
import '../providers/products_provider.dart';
import 'package:shop/screens/edit_products_screen.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/userProducts';
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.routeName);
            },
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (_, i) {
              return Column(
                children: <Widget>[
                  UserProductItem(
                      products.items[i].id,
                      products.items[i].title,
                      products.items[i].imageUrl,
                      products.items[i].price,
                     ),
                  Divider(),
                ],
              );
            },
          )),
      drawer: AppDrawer(),
    );
  }
}
