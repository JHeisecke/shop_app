import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_state.dart';
import '../screens/product_form_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ProductFormScreen.routeName,
                    arguments: id,
                  );
                },
                color: Theme.of(context).primaryColor),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<ProductsState>(context, listen: false)
                    .removeProduct(id);
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
