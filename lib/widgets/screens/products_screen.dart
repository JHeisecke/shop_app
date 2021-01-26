import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../items/product_item.dart';

class ProductsScreen extends StatelessWidget {
  final List<Product> loadedProducts = products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, i) => ProductItem(
          id: loadedProducts[i].id,
          imageUrl: loadedProducts[i].imageUrl,
          title: loadedProducts[i].title,
        ),
      ),
    );
  }
}
