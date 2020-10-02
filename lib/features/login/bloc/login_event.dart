import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginInitialEvent extends LoginEvent {
  @override
  String toString() {
    return 'LoginInitialEvent';
  }
}

class LoginWithGooglePressedEvent extends LoginEvent {
  @override
  String toString() {
    return 'LoginWithGooglePressedEvent';
  }
}

class LoginWithCredentialsPressedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressedEvent(
      {@required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() {
    return 'LoginWithCredentialsPressedEvent';
  }
}

class RegisterEvent extends LoginEvent {
  final String email;
  final String password;

  RegisterEvent({@required this.email, @required this.password}) : super([email, password]);

  @override
  String toString() {
    return 'RegisterEvent<$email, $password>';
  }
}

class AnonymousAccountPressedEvent extends LoginEvent {
  @override
  String toString() {
    return 'AnonymousAccountPressedEvent';
  }
}

class OfflineModePressedEvent extends LoginEvent {
  @override
  String toString() {
    return 'OfflineModePressedEvent';
  }
}
