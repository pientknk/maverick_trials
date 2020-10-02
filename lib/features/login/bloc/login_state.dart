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
  final String error;

  LoginFailureState({@required this.error}) : super([error]);

  @override
  String toString() {
    return 'LoginFailureState<$error>';
  }
}

class LoginEmailVerificationRequiredState extends LoginState {
  @override
  String toString() {
    return 'LoginEmailVerificationRequiredState';
  }
}

class LoginRegisterState extends LoginState {
  final String email;
  final String password;

  LoginRegisterState({this.email, this.password}) : super([email, password]);

  @override
  String toString() {
    return 'LoginRegisterState<$email, $password>';
  }
}
