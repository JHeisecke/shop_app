import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/cart.dart';
import './providers/order.dart';
import './providers/products_state.dart';
import './providers/auth.dart';
import './screens/orders_screen.dart';
import './screens/products_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/user_products_screen.dart';
import './screens/product_form_screen.dart';
import './screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        //produtcs se vuelve dependiente de Auth
        ChangeNotifierProxyProvider<Auth, ProductsState>(
          update: (ctx, auth, previousProducts) => ProductsState(
              auth.userId,
              auth.token,
              previousProducts.items == null ? [] : previousProducts.items),
          create: (_) => ProductsState('', '', []),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        //produtcs se vuelve dependiente de Auth
        ChangeNotifierProxyProvider<Auth, Order>(
          update: (ctx, auth, previousOrders) => Order(auth.userId, auth.token,
              previousOrders.orders == null ? [] : previousOrders.orders),
          create: (_) => Order('', '', []),
        ),
      ],
      //MaterialApp es rebuilt cuando Auth cambia
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
          title: 'MiTienda',
          theme: ThemeData(
            primaryColor: Colors.teal,
            accentColor: Colors.tealAccent,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? ProductsScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            ProductFormScreen.routeName: (ctx) => ProductFormScreen(),
          },
        ),
      ),
    );
  }
}
