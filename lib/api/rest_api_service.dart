import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/endpoints.dart';
import '../models/fetch_data_exception.dart';

class RestApiService {
  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No hay conexión a internet');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    var responseJson;
    try {
      final response = await http.post(url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No hay conexión a internet');
    }

    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    var responseJson;
    try {
      final response = await http.put(url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No hay conexión a internet');
    }
    return responseJson;
  }

  Future<dynamic> patch(String url, dynamic body) async {
    var responseJson;
    try {
      final response = await http.patch(url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No hay conexión a internet');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var apiResponse;
    try {
      final response = await http.delete(url);
      apiResponse = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No hay conexión a internet');
    }

    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body);
      print('response: $responseJson');
      return responseJson;
    case 400:
      print(response.body.toString());
      throw Exception(response.body.toString());
      break;
    //throw BadRequestException();
    case 401:
      print(response.body.toString());
      throw Exception(response.body.toString());
      break;
    case 403:
      print(response.body.toString());
      throw Exception(response.body.toString());
      break;
    //throw UnauthorisedException(response.body.toString());
    case 500:
      print(response.body.toString());
      throw Exception(response.body.toString());
      break;
    default:
      throw Exception(
          'Error occured while Communication with Server with StatusCode :' +
              '${response.statusCode}');
    //throw FetchDataException(
    //);
  }
}
