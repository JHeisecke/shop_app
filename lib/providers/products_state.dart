import 'dart:convert';
import 'package:flutter/foundation.dart';

import './product.dart';
import '../api/rest_api_service.dart';
import '../constants/endpoints.dart';

/*
* We should only change data in this class to notify
*/
class ProductsState with ChangeNotifier {
  RestApiService _helper = RestApiService();
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((e) => e.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((e) => e.id == id);
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await _helper.get(Endpoints.products) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      response.forEach((key, product) {
        loadedProducts.add(Product(
          id: key,
          title: product['title'],
          description: product['description'],
          price: product['price'],
          imageUrl: product['imageUrl'],
          isFavorite: product['isFavorite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await _helper.post(
        Endpoints.products,
        json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );

      final newProduct = Product(
        id: response['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(Product product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == product.id);
    if (prodIndex >= 0) {
      final url = Endpoints.product + '${product.id}.json';
      await _helper.patch(
          url,
          json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }));
      _items[prodIndex] = product;
      notifyListeners();
    }
  }

  /*
  * Removemos el prod de la lista y hacemos una copia, hacemos la peticion
  * y si no funciona agregamos nuevamente la copia a la lista
  */
  void removeProduct(String id) {
    //optimistic updating
    final url = Endpoints.product + '${id}.json';
    final copyProductId = _items.indexWhere((prod) => prod.id == id);
    var copyProduct = _items[copyProductId];
    _items.removeAt(copyProductId);
    _helper.delete(url).then((_) {
      copyProduct = null;
    }).catchError((_) {
      _items.insert(copyProductId, copyProduct);
    });
    notifyListeners();
  }
}

/*final products = [
  Product(
    id: 'p1',
    title: 'Red Shirt',
    description: 'A red shirt - it is pretty red!',
    price: 29.99,
    imageUrl:
        'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  ),
  Product(
    id: 'p2',
    title: 'Trousers',
    description: 'A nice pair of trousers.',
    price: 59.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  ),
  Product(
    id: 'p3',
    title: 'Yellow Scarf',
    description: 'Warm and cozy - exactly what you need for the winter.',
    price: 19.99,
    imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  ),
  Product(
    id: 'p4',
    title: 'A Pan',
    description: 'Prepare any meal you want.',
    price: 49.99,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  ),
];*/
