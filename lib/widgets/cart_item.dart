import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String productId;
  CartItems(this.id, this.title, this.price, this.quantity, this.productId);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.redAccent,
        child: Icon(
          Icons.delete,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(10),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are You sure'),
                  content: Text('You want to delete the item from the cart'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                    ),  
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                    )
                  ],
                ));
      },
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(child: Text('\$${(price)}'))),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            title: Text(title),
            subtitle: Text('Total:\$${(price * quantity)}'),
            trailing: Text('${(quantity)}x'),
          ),
        ),
      ),
    );
  }
}
