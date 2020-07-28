import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInitialState extends LoginState {
  @override
  String toString() {
    return 'LoginInitialState';
  }
}

class LoginSubmittingState extends LoginState {
  @override
  String toString() {
    return 'LoginSubmittingState';
  }
}

class LoginFailureState extends LoginState {
  final String errorCode;

  LoginFailureState({@required this.errorCode}) : super([errorCode]);

  @override
  String toString() {
    return 'LoginFailureState<$errorCode>';
  }
}

class LoginEmailVerificationRequiredState extends LoginState {
  @override
  String toString() {
    return 'LoginEmailVerificationRequiredState';
  }
}
