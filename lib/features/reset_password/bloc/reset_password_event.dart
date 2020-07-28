import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ResetPasswordEvent extends Equatable {
  ResetPasswordEvent([List props = const []]) : super(props);
}

class ResetPasswordInitialEvent extends ResetPasswordEvent {
  @override
  String toString() {
    return 'ResetPasswordInitialEvent';
  }
}

class ResetPasswordPressedEvent extends ResetPasswordEvent {
  final String email;

  ResetPasswordPressedEvent({@required this.email}) : super([email]);

  @override
  String toString() {
    return 'ResetPasswordPressedEvent<$email>';
  }
}
