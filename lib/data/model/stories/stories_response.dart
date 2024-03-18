import 'package:freezed_annotation/freezed_annotation.dart';

part 'stories_response.g.dart';
part 'stories_response.freezed.dart';

@Freezed()
class StoriesResponse with _$StoriesResponse {
  const factory StoriesResponse({
    required bool error,
    required String message,
    @JsonKey(name: "listStory") required List<ListStory> listStory,
  }) = _StoriesResponse;

  factory StoriesResponse.fromJson(Map<String, dynamic> json) => _$StoriesResponseFromJson(json);
}

@Freezed()
class ListStory with _$ListStory {
  const factory ListStory({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required DateTime createdAt,
    double? lat,
    double? lon,
  }) = _ListStory;

  factory ListStory.fromJson(Map<String, dynamic> json) => _$ListStoryFromJson(json);
}
