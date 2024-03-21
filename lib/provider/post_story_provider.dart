import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:my_story_app/data/local/preferences_helper.dart';
import 'package:my_story_app/util/image_compressor.dart';
import 'package:my_story_app/util/ui_state.dart';

import '../data/network/api_service.dart';
import '../util/constant.dart';

class PostStoryProvider extends ChangeNotifier {
  final ApiService apiService;

  UiState _postStoryState = const Idle();

  PostStoryProvider({required this.apiService});

  UiState get postStoryState => _postStoryState;

  void postStory(File imageFile, String description, String latitude, String longitude) async {
    _postStoryState = const Loading();
    notifyListeners();
    var image = await imageCompressing(imageFile);
    try {
      if (image == null) throw ("Failed to compress");
      var session = await PreferencesHelper().getSession();
      var postStory =
          apiService.postStory(File(image.path), description, latitude, longitude, session!.token);

      _postStoryState = Success(postStory);
    } catch (exception) {
      _postStoryState =
          Error(exception.toString().replaceAll("Exception: ", textEmpty));
    } finally {
      notifyListeners();
    }
  }
}
