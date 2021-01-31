class Endpoints {
  static final apiKey = '';
  static final authUrl = 'https://identitytoolkit.googleapis.com/v1/accounts';
  static final login = authUrl + ':signInWithPassword?key=' + apiKey;
  static final signUp = authUrl + ':signUp?key=' + apiKey;
  static final products = 'products.json';
  static final product = 'products/';
  static final orders = 'orders.json';
}
