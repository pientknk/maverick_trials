import 'package:equatable/equatable.dart';
import 'package:maverick_trials/core/models/user.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class AuthStartedEvent extends AuthEvent {
  @override
  String toString() {
    return runtimeType.toString();
  }
}

class AuthLoggedInEvent extends AuthEvent {
  final User user;

  AuthLoggedInEvent({this.user})
    : super([user]);

  @override
  String toString() {
    return "${runtimeType.toString()} { "
      "${user.toString()}"
      " }";
  }
}

class AuthLoggedOutEvent extends AuthEvent {
  @override
  String toString() {
    return runtimeType.toString();
  }
}

class AuthRequestIntroEvent extends AuthEvent {
  @override
  String toString() {
    return runtimeType.toString();
  }
}