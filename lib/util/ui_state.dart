abstract class UiState<T> {
  const UiState();
}

class Idle extends UiState {
  const Idle();
}

class Success<T> extends UiState<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends UiState<T> {
  final String message;
  const Error(this.message);
}

class Loading extends UiState {
  const Loading();
}
