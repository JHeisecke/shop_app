import 'package:flutter/material.dart';

import '../items/products_list.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop"),
      ),
      body: ProductsGrid(),
    );
  }
}
