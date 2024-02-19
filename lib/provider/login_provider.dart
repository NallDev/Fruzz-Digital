import 'package:flutter/foundation.dart';

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
      final login = await apiService.doLogin(email, password);
      _loginState = Success(login);
    } catch (exception) {
      _loginState = Error(exception.toString().replaceAll("Exception: ", ""));
    } finally {
      notifyListeners();
    }
  }
}