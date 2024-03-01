import 'package:flutter/foundation.dart';
import 'package:my_story_app/data/network/api_service.dart';
import 'package:my_story_app/util/ui_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../data/local/preferences_helper.dart';
import '../data/model/stories/stories_response.dart';
import '../util/constant.dart';

class StoriesProvider extends ChangeNotifier {
  final ApiService apiService;
  UiState _storiesState = const Idle();
  List<ListStory> _listStory = [];
  List<ListStory> _randomStory = [];

  StoriesProvider({required this.apiService});

  UiState get storiesState => _storiesState;
  List<ListStory> get listStory => _listStory;
  List<ListStory> get randomStory => _randomStory;

  Future<void> getStories() async {
    _storiesState = const Loading();
    print("DO LOADING");
    notifyListeners();
    try {
      var session = await PreferencesHelper().getSession();
      final stories = await apiService.getStories(session!.token);

      _listStory = List.from(stories)..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      _randomStory = List.from(stories)..shuffle();
      _randomStory = _randomStory.take(5).toList();
      _storiesState = Success(stories);
      print("DO SUCCESS");
      notifyListeners();
    } catch (exception) {
      _storiesState =
          Error(exception.toString().replaceAll("Exception: ", textEmpty));
      print("DO ERROR");
      notifyListeners();
    }
  }
}