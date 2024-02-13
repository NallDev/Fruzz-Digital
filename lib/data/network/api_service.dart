import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/register/register_response.dart';

class ApiService {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1/";

  Future<RegisterResponse> doRegister(String name, String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      'name' : name,
      'email' : email,
      'password' : password,
    });

    final response = await http.post(Uri.parse("$_baseUrl/register"), headers: headers, body: body);

    print(response.body);

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("error");
    }
  }
}