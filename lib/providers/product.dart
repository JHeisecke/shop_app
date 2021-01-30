import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../api/rest_api_service.dart';
import '../constants/endpoints.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite; //not final bc it can change

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false, //initiliaze isFavorite with false per default
  });
  RestApiService _helper = RestApiService();

  Future<void> toggleFavoriteStatus(String id) async {
    final copyIsFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Endpoints.product + '$id.json';
    await _helper
        .patch(
            url,
            json.encode({
              'isFavorite': isFavorite,
            }))
        .catchError((_) {
      isFavorite = copyIsFavorite;
      notifyListeners();
    });
  }
}
