import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../api/rest_api_service.dart';
import '../constants/endpoints.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  RestApiService _helper = RestApiService();

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, Endpoints.signUp);
  }

  Future<void> logIn(String email, String password) async {
    return _authenticate(email, password, Endpoints.login);
  }

  Future<void> _authenticate(String email, String password, String url) async {
    try {
      final response = await _helper.post(
        url,
        json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      print(response);
    } catch (error) {
      print(error);
    }
  }
}
