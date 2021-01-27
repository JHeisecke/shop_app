import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../../providers/product.dart';
import '../../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: productData.id,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 6))
              ],
            ),
            child: Image.network(
              productData.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          //only rebuilds this part of the widget,
          //consumer always listens to changes, child argument in builder
          //parameter doesnt get rebuilt
          leading: Consumer<Product>(
            builder: (context, value, child) => IconButton(
              icon: Icon(productData.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                productData.toggleFavoriteStatus();
              },
            ),
          ),
          title: Text(
            productData.title,
            style: TextStyle(color: Colors.white),
          ),
          trailing: Consumer<Product>(
            builder: (context, value, child) => IconButton(
                icon: Icon(Icons.shopping_cart),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  cart.addItem(
                      productData.id, productData.price, productData.title);
                }),
          ),
        ),
      ),
    );
  }
}
