import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/order.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: orderData.orderLength != 0
          ? ListView.builder(
              itemBuilder: (ctx, i) {
                return OrderItems(orderData.items[i]);
              },
              itemCount: orderData.items.length,
            )
          : Center(
              child: Text('Nothing Is Ordered'),
            ),
      drawer: AppDrawer(),
    );
  }
}
