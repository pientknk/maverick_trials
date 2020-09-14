import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class RegisterInitialEvent extends RegisterEvent {
  @override
  String toString() {
    return 'RegisterInitialEvent';
  }
}

class RegisterSubmittedEvent extends RegisterEvent {
  final String nickname;
  final String email;
  final String password;

  RegisterSubmittedEvent(
      {@required this.nickname, @required this.email, @required this.password})
      : super([email, password]);

  @override
  String toString() {
    return 'RegisterSubmittedEvent<$nickname, $email, $password>';
  }
}

class RegisterUpdateEvent extends RegisterEvent {
  final String nickname;

  RegisterUpdateEvent({@required this.nickname}) : super([nickname]);

  @override
  String toString() {
    return 'RegisterUpdateEvent';
  }
}
