abstract class UiState {}

class StateLoading extends UiState {}

class StateSuccess extends UiState {
  final dynamic data;

  StateSuccess(this.data);
}

class StateError extends UiState {
  final String message;

  StateError(this.message);
}