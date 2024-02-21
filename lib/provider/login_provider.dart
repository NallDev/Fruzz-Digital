import 'package:flutter/foundation.dart';
import 'package:my_story_app/data/local/preferences_helper.dart';
import 'package:my_story_app/util/constant.dart';

import '../data/network/api_service.dart';
import '../util/ui_state.dart';

class LoginProvider extends ChangeNotifier {
  final ApiService apiService;

  UiState _loginState = const Idle();

  LoginProvider({required this.apiService});

  UiState get loginState => _loginState;

  Future doLogin(String email, String password) async {
    _loginState = const Loading();
    notifyListeners();

    try {
      final loginResult = await apiService.doLogin(email, password);
      await PreferencesHelper().setSession(loginResult);
      getSession();
    } catch (exception) {
      _loginState = Error(exception.toString().replaceAll("Exception: ", textEmpty));
    } finally {
      notifyListeners();
    }
  }

  void getSession() async {
    var session = await PreferencesHelper().getSession();
    if (session != null) {
      _loginState = Success(session);
    } else {
      _loginState = const Error(sessionNotStoreMsg);
    }
  }
}