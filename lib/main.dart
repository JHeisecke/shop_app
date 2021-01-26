import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/screens/products_screen.dart';
import './widgets/screens/product_detail_screen.dart';
import './providers/products_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ProductsState(),
      child: MaterialApp(
        title: 'MiTienda',
        theme: ThemeData(
          primaryColor: Colors.teal,
          accentColor: Colors.tealAccent,
          fontFamily: 'Lato',
        ),
        home: ProductsScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
