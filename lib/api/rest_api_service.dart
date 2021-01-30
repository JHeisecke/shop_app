import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class RestApiService {
  final _baseUrl =
      'https://flutter-shop-app-80b97-default-rtdb.firebaseio.com/';

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      //throw FetchDataException('No Internet connection');
      print('No hay conexión a internet');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      //throw FetchDataException('No Internet connection');
      print('No hay conexión a internet');
    }

    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    var responseJson;
    try {
      final response = await http.put(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      //throw FetchDataException('No Internet connection');
      print('No hay conexión a internet');
    }

    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var apiResponse;
    try {
      final response = await http.delete(_baseUrl + url);
      apiResponse = _returnResponse(response);
    } on SocketException {
      //throw FetchDataException('No Internet connection');
      print('No hay conexión a internet');
    }

    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      print('response: $responseJson');
      return responseJson;
    case 400:
      print(response.body.toString());
      break;
    //throw BadRequestException(response.body.toString());
    case 401:
      print(response.body.toString());
      break;
    case 403:
      print(response.body.toString());
      break;
    //throw UnauthorisedException(response.body.toString());
    case 500:
      print(response.body.toString());
      break;
    default:
      print('Ocurrio un error inesperado');
    //throw FetchDataException(
    //'Error occured while Communication with Server with StatusCode :
    //${response.statusCode}');
  }
}
