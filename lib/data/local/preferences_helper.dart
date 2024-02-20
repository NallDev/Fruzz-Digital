import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/login/login_response.dart';

class PreferencesHelper {
  Future<void> setSession(LoginResult loginResult) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(loginResult.toJson());
    await prefs.setString('session', jsonString);
  }

  Future<LoginResult?> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('session') == true) {
      String jsonString = prefs.getString('session')!;
      Map<String, dynamic> session = json.decode(jsonString);
      return LoginResult.fromJson(session);
    }
    return null;
  }

  Future<void> deleteSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('session');
  }
}