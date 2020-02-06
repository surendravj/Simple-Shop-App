import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/order.dart';
import 'package:shop/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('Your Cart'))),
        body: Column(
          children: <Widget>[
            Card(
              elevation: 5,
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text('\$${cart.totalAmount}',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                        child: Text('Order Now'),
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false).addOrder(
                              cart.items.values.toList(), cart.totalAmount);
                              cart.clearCart();
                        },
                        textColor: Theme.of(context).primaryColor)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.cartCount,
                itemBuilder: (ctx, i) {
                  return CartItems(
                      cart.items.values.toList()[i].id,
                      cart.items.values.toList()[i].title,
                      cart.items.values.toList()[i].price,
                      cart.items.values.toList()[i].quantity,
                      cart.items.keys.toList()[i]);
                },
              ),
            )
          ],
        ));
  }
}
