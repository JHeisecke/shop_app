import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_state.dart';
import '../items/user_product_item.dart';
import '../app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/manage-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sus Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) {
              return Column(
                children: [
                  UserProductItem(
                    productsData.items[i].title,
                    productsData.items[i].imageUrl,
                  ),
                  Divider(),
                ],
              );
            }),
      ),
    );
  }
}
