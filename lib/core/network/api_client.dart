import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:new_practice_project/core/network/api_endpoints.dart';
import 'package:new_practice_project/core/network/api_exception.dart';

class ApiClient {
  Future<Map<String,dynamic>> getQuote() async {
    try {
      final response = await http.get(Uri.parse(ApiEndpoints.baseUrl));

      if (response.isSuccessful) {
        return jsonDecode(response.body) as Map<String,dynamic>;
      }
      throw ApiException(
        statusCode: response.statusCode,
        message: 'Request failed with status code ${response.statusCode}',
      );
    } on SocketException {
      throw const ApiException(
        statusCode: 0,
        message: 'No Internet connection.',
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(statusCode: 500, message: e.toString());
    }
  }
}

extension ApiExtension on http.Response {
  bool get isSuccessful => statusCode >= 200 && statusCode < 300;
}
