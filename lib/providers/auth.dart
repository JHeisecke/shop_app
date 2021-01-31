import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../api/rest_api_service.dart';
import '../constants/endpoints.dart';
import '../models/bad_request_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  RestApiService _helper = RestApiService();

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

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
      if (response['error'] != null) {
        throw BadRequestException(response['error']['message']);
      }

      _token = response['idToken'];
      _userId = response['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(response['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
