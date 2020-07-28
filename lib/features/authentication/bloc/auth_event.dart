import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AuthenticationStartedEvent extends AuthenticationEvent {
  @override
  String toString() {
    return 'AuthenticationStartedEvent';
  }
}

class AuthenticationLoggedInEvent extends AuthenticationEvent {
  final String name;

  AuthenticationLoggedInEvent({@required this.name}) : super([name]);

  @override
  String toString() {
    return 'AuthenticationLoggedInEvent<$name>';
  }
}

class AuthenticationLoggedOutEvent extends AuthenticationEvent {
  @override
  String toString() {
    return 'AuthenticationLoggedOutEvent';
  }
}
