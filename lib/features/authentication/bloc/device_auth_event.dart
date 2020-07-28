import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

abstract class DeviceAuthenticationEvent extends Equatable {
  DeviceAuthenticationEvent([List props = const []]) : super(props);
}

class DeviceAuthenticationLoginEvent extends DeviceAuthenticationEvent {
  final BiometricType authType;
  final bool didAuth;

  DeviceAuthenticationLoginEvent({
    @required this.authType,
    @required this.didAuth,
  }) : super([authType, didAuth]);

  @override
  String toString() {
    return 'DeviceAuthenticationLoginEvent';
  }
}

class DeviceAuthenticationSetupEvent extends DeviceAuthenticationEvent {
  @override
  String toString() {
    return 'DeviceAuthenticationSetupEvent';
  }
}
