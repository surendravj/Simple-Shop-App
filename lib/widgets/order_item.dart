import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/providers/order.dart';

class OrderItems extends StatefulWidget {
  final OrderItem order;
  OrderItems(this.order);
  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.total}'),
            subtitle: Text(widget.order.dateTime.toString()),
            trailing: IconButton(
              icon:
                  _expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          _expanded
              ? Container(
                  padding: EdgeInsets.all(10),
                  height: min(widget.order.products.length * 20.0 + 50, 130),
                  child: ListView(
                    children: widget.order.products
                        .map(
                          (prod) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  prod.title,
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  '${prod.quantity}x \$${prod.price}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize:18),
                                ),
                              ]),
                        )
                        .toList(),
                  ),
                )
              : Text('')
        ],
      ),
    );
  }
}
