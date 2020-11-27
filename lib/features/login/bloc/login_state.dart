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
  String message;

  LoginSubmittingState({@required this.message}) : super([message]);

  @override
  String toString() {
    return 'LoginSubmittingState';
  }
}

class LoginFailureState extends LoginState {
  final String exception;

  LoginFailureState({@required this.exception}) : super([exception]);

  @override
  String toString() {
    return 'LoginFailureState<$exception>';
  }
}

class LoginEmailVerificationRequiredState extends LoginState {
  @override
  String toString() {
    return 'LoginEmailVerificationRequiredState';
  }
}

class LoginRegisterState extends LoginState {
  @override
  String toString() {
    return 'LoginRegisterState';
  }
}
