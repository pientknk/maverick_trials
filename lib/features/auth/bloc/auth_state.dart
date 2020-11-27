import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/features/auth/auth_login_type.dart';

abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

class AuthInitialState extends AuthState {
  @override
  String toString() {
    return runtimeType.toString();
  }
}

class AuthSuccessState extends AuthState {
  final AuthLoginType authLoginType;
  final User user;

  AuthSuccessState({@required this.authLoginType, this.user})
    : super([authLoginType, user]);

  @override
  String toString() {
    return "${this.runtimeType.toString()} {"
      " authLoginType: $authLoginType"
      " user: ${user.toString()}"
      " }";
  }
}

class AuthInProgressState extends AuthState {
  @override
  String toString() {
    return runtimeType.toString();
  }
}

class AuthFailureState extends AuthState {
  final String error;

  AuthFailureState({
    @required this.error,
  }) : super([error]);

  @override
  String toString() {
    return 'AuthenticationFailureState<$error>';
  }
}
