import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products_state.dart';
import '../items/product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
    the provider package that we want to establish a direct communication 
    channel to the provided instance of the products class and now the 
    provider package goes ahead it looks at the ProductsList of products_screen
    and there it finds no provider so it goes ahead and has a look at the parent
    of the products_screen and that's of course are MyApp widget in main.dart 
    because that's where I'm instantiating ChangeNotifier
    */
    final productsData = Provider.of<ProductsState>(context);
    final loadedProducts = productsData.items; //we use the getter in provider
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, i) => ChangeNotifierProvider(
        create: (ctx) => products[i],
        child: ProductItem(),
      ),
    );
  }
}
