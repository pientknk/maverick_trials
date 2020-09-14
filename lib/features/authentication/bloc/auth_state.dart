import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class AuthenticationInitialState extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationInitialState';
  }
}

class AuthenticationSuccessState extends AuthenticationState {
  final String name;

  AuthenticationSuccessState({@required this.name}) : super([name]);

  @override
  String toString() {
    return 'AuthenticationSuccessState';
  }
}

class AuthenticationInProgressState extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationInProgressState';
  }
}

class AuthenticationFailureState extends AuthenticationState {
  final String error;

  AuthenticationFailureState({
    @required this.error,
  }) : super([error]);

  @override
  String toString() {
    return 'AuthenticationFailureState<$error>';
  }
}
