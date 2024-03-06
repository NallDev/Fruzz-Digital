import 'package:flutter/foundation.dart';
import 'package:my_story_app/data/network/api_service.dart';
import 'package:my_story_app/util/constant.dart';
import 'package:my_story_app/util/ui_state.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiService apiService;

  UiState _registerState = const Idle();

  RegisterProvider({required this.apiService});

  UiState get registerState => _registerState;

  Future doRegister(String name, String email, String password) async {
    _registerState = const Loading();
    notifyListeners();
    try {
      final register = await apiService.doRegister(name, email, password);
      _registerState = Success(register);
    } catch (exception) {
      _registerState =
          Error(exception.toString().replaceAll("Exception: ", textEmpty));
    } finally {
      notifyListeners();
    }
  }
}
