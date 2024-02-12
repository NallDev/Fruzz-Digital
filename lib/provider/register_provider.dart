import 'package:flutter/foundation.dart';
import 'package:my_story_app/data/network/api_service.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiService apiService;

  RegisterState? _registerState;
  String? _message;
  bool _isErrorRegister = true;

  RegisterProvider({required this.apiService});

  RegisterState? get registerState => _registerState;
  String? get message => _message;
  bool get isErrorRegister => _isErrorRegister;

  Future<dynamic> doRegister(String name, String email, String password) async {
    _registerState = RegisterState.loading;
    notifyListeners();
    try {
      final register = await apiService.doRegister(name, email, password);
      _registerState = RegisterState.success;
      notifyListeners();

      _isErrorRegister = register.error;
      return _message = register.message;
    } catch (exception) {
      _registerState = RegisterState.error;
      notifyListeners();

      return _message = exception.toString();
    }
  }
}

enum RegisterState {loading, success, error}