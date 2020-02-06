import 'package:flutter/material.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/widgets/drawer.dart';
import '../widgets/Batch.dart';
import 'package:shop/widgets/product_grid.dart';
import 'package:provider/provider.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    void selectPage() {
      Navigator.of(context).pushNamed(CartScreen.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Products Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (int slectedValue) {
              setState(() {
                if (slectedValue == 1) {
                  isFav = true;
                } else {
                  isFav = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show Favoruites'),
                value: 1,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: 0,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 36,
                ),
                onPressed: selectPage,
              ),
              value: cart.cartCount.toString(),
            ),
          ),
        ],
      ),
      body: ProductGrid(isFav),
      drawer: AppDrawer(),
    );
  }
}
