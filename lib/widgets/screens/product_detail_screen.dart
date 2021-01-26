import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_state.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product_detail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    /*
    * Because we dont need to reload this screen when something changes in the
    * list we set the parameter "listen" to false
    */
    final product = Provider.of<ProductsState>(
      context,
      listen: false,
    ).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
