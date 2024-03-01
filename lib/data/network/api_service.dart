import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_story_app/data/model/login/login_response.dart';
import 'package:my_story_app/util/constant.dart';

import '../model/register/register_response.dart';
import '../model/stories/stories_response.dart';

class ApiService {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";

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

      final stringJson = json.decode(response.body);
      var registerResponse = RegisterResponse.fromJson(stringJson);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return registerResponse;
      } else {
        throw Exception(registerResponse.message);
      }
    } on SocketException catch (_) {
      throw Exception(noConnectionMsg);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<LoginResult> doLogin(String email, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(Uri.parse("$_baseUrl/login"),
          headers: headers, body: body);

      final stringJson = json.decode(response.body);
      var loginResponse = LoginResponse.fromJson(stringJson);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return loginResponse.loginResult!;
      } else {
        throw Exception(loginResponse.message);
      }
    } on SocketException catch (_) {
      throw Exception(noConnectionMsg);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ListStory>> getStories(String token) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    try {
      final response = await http.get(Uri.parse("$_baseUrl/stories"),
          headers: headers);

      final stringJson = json.decode(response.body);
      var storiesResponse = StoriesResponse.fromJson(stringJson);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return storiesResponse.listStory;
      } else {
        throw Exception(storiesResponse.message);
      }
    } on SocketException catch (_) {
      throw Exception(noConnectionMsg);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> postStory(File imageFile, String description, String token) async {
    var headers = {
      "Content-type": "multipart/form-data",
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest('POST', Uri.parse("$_baseUrl/stories"))
      ..headers.addAll(headers)
      ..fields['description'] = description;

    try {
      request.files.add(await http.MultipartFile.fromPath('photo', imageFile.path));

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonResponse = json.decode(responseString);

      print("INI RESPONNYA : $jsonResponse");

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (jsonResponse['error'] == false) {
          return true;
        } else {
          return false;
        }
      } else {
        throw Exception(jsonResponse['message'].toString());
      }
    } on SocketException catch (_) {
      throw Exception(noConnectionMsg);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
