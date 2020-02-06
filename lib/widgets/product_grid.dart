import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './product_item.dart';
import '../providers/products_provider.dart';

class ProductGrid extends StatelessWidget {
  final bool isFav;
  ProductGrid(this.isFav);
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = isFav? productData.favItems:productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 2 / 2),
    );
  }
}
