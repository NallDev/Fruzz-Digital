import 'package:flutter/foundation.dart';
import 'package:my_story_app/data/network/api_service.dart';
import 'package:my_story_app/util/ui_state.dart';

import '../data/local/preferences_helper.dart';
import '../util/constant.dart';

class StoriesProvider extends ChangeNotifier {
  final ApiService apiService;
  UiState _storiesState = Idle();

  StoriesProvider({required this.apiService});

  UiState get storiesState => _storiesState;

  void getStories() async {
    _storiesState = Loading();
    notifyListeners();
    try {
      var token = await getToken();
      final register = await apiService.getStories(token!);
      _storiesState = Success(register);
    } catch (exception) {
      _storiesState = Error(exception.toString().replaceAll("Exception: ", textEmpty));
    } finally {
      notifyListeners();
    }
  }

  Future<String?> getToken() async {
    var session = await PreferencesHelper().getSession();
    return session?.token;
  }
}