import 'dart:convert';

import 'package:my_story_app/util/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login/login_response.dart';

class PreferencesHelper {
  Future<void> setSession(LoginResult loginResult) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(loginResult.toJson());
    await prefs.setString(sessionKey, jsonString);
  }

  Future<LoginResult?> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(sessionKey) == true) {
      String jsonString = prefs.getString(sessionKey)!;
      Map<String, dynamic> session = json.decode(jsonString);
      return LoginResult.fromJson(session);
    }
    return null;
  }

  Future<void> deleteSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(sessionKey);
  }
}
