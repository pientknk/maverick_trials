import 'package:equatable/equatable.dart';

abstract class RequestNicknameState extends Equatable {
  RequestNicknameState([List props = const []]) : super(props);
}

class InitialState extends RequestNicknameState {
  @override
  String toString() {
    return 'InitialState<RequestNicknameState>';
  }
}

class LoadingState extends RequestNicknameState {
  @override
  String toString() {
    return 'LoadingState<RequestNicknameState>';
  }
}

class SuccessState extends RequestNicknameState {
  @override
  String toString() {
    return 'SuccessState<RequestNicknameState>';
  }
}

class FailureState extends RequestNicknameState {
  @override
  String toString() {
    return 'FailureState<RequestNicknameState>';
  }
}
