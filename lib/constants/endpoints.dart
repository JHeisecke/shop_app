class Endpoints {
  static final apiKey = '';
  static final authUrl = 'https://identitytoolkit.googleapis.com/v1/accounts';
  static final baseUrl = '';
  static final login = '$authUrl:signInWithPassword?key=$apiKey';
  static final signUp = '$authUrl:signUp?key=$apiKey';
  static final products = '$baseUrl/products.json';
  static final product = '$baseUrl/products/';
  static final userFavorites = '$baseUrl/userFavorites/';
  static final orders = '$baseUrl/orders.json';
}
