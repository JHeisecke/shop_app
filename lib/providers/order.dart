import 'dart:convert';
import 'package:flutter/foundation.dart';

import './cart.dart';
import '../api/rest_api_service.dart';
import '../constants/endpoints.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  RestApiService _helper = RestApiService();
  final String authToken;
  final String userId;

  Order(this.userId, this.authToken, _orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timestamp = DateTime.now();
    final response = await _helper.post(
        Endpoints.orders + '/$userId.json?auth=$authToken',
        json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      OrderItem(
        id: response['name'],
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    final List<OrderItem> loadedOrders = [];
    try {
      final response =
          await _helper.get(Endpoints.orders + '/$userId.json?auth=$authToken')
              as Map<String, dynamic>;
      response.forEach((id, orderData) {
        loadedOrders.add(OrderItem(
          id: id,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map((e) => CartItem(
                    id: e['id'],
                    price: e['price'],
                    quantity: e['quantity'],
                    title: e['title'],
                  ))
              .toList(),
          dateTime: DateTime.parse(orderData['dateTime']),
        ));
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      _orders = [];
      notifyListeners();
      throw error;
    }
  }
}
