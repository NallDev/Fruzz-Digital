import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/register/register_response.dart';

class ApiService {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1/";

  Future<RegisterResponse> doRegister(
      String name, String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      'name': name,
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(Uri.parse("$_baseUrl/register"),
          headers: headers, body: body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = json.decode(response.body);
        return RegisterResponse.fromJson(responseData);
      } else {
        final errorData = json.decode(response.body);
        throw Exception('Failed to register: ${errorData["message"]}');
      }
    } on SocketException catch (_) {
      throw Exception('Please check your internet connection');
    } catch (e) {
      throw Exception('Something error, please try again later');
    }
  }
}
