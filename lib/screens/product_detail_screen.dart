import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/productDetails';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final productsData =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(productsData.title),
        centerTitle:true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 300,
            child: Image.network(
              productsData.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              alignment: Alignment.center,
              child: Text('${productsData.price}',
                  style: TextStyle(fontSize: 23, color: Colors.purple))),
              SizedBox(height:10,),
          Container(
              alignment: Alignment.center,
              child: Text(
                '${productsData.description}',
                style: TextStyle(color: Colors.blueGrey),
                softWrap: true,
              ))
        ],
      ),
    );
  }
}
