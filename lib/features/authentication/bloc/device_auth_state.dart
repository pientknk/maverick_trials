import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

abstract class DeviceAuthenticationState extends Equatable {
  DeviceAuthenticationState([List props = const []]) : super(props);
}

class DeviceAuthenticatedState extends DeviceAuthenticationState {
  final BiometricType authType;

  DeviceAuthenticatedState({
    @required this.authType,
  }) : super([authType]);

  @override
  String toString() {
    return 'DeviceAuthenticatedState';
  }
}

class DeviceNotAuthenticatedState extends DeviceAuthenticationState {
  @override
  String toString() {
    return 'DeviceNotAuthenticatedState';
  }
}

class DeviceAuthenticatingState extends DeviceAuthenticationState {
  final BiometricType authType;

  DeviceAuthenticatingState({@required this.authType}) : super([authType]);

  @override
  String toString() {
    return 'DeviceAuthenticatingState';
  }
}

class DeviceAuthenticationFailureState extends DeviceAuthenticationState {
  final String error;

  DeviceAuthenticationFailureState({@required this.error}) : super([error]);

  @override
  String toString() {
    return 'DeviceAuthenticationFailureState';
  }
}
