import 'package:flutter/foundation.dart';
import 'package:my_story_app/data/network/api_service.dart';

import '../util/ui_state.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiService apiService;

  RegisterProvider({required this.apiService});

  Future<dynamic> doRegister(String name, String email, String password) async {
    // do loading
    try {
      final register = await apiService.doRegister(name, email, password);

      // do success
    } catch (exception) {
      // do error
    }
  }
}

