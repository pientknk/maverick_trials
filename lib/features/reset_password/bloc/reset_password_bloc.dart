import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/repository/user/firebase_user_repository.dart';
import 'package:maverick_trials/core/validation/email_validator.dart';
import 'package:maverick_trials/core/validation/required_field_validator.dart';
import 'package:maverick_trials/features/reset_password/bloc/reset_password.dart';
import 'package:rxdart/rxdart.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState>
    with RequiredFieldValidator, EmailValidator {
  final FirebaseUserRepository _userRepository;

  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();

  Function(String) get onEmailChanged => _emailController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<bool> get isSendResetEmailButtonEnabled =>
      email.transform(StreamTransformer<String, bool>.fromHandlers(
          handleData: (email, sink) {
        if (email.isNotEmpty) {
          sink.add(true);
        }
      }));

  ResetPasswordBloc({@required FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  void onResetEmailButtonPressed() {
    this.add(ResetPasswordPressedEvent(
      email: _emailController.stream.value,
    ));
  }

  @override
  ResetPasswordState get initialState => ResetPasswordState.initial();

  @override
  Stream<ResetPasswordState> mapEventToState(ResetPasswordEvent event) async* {
    yield ResetPasswordState.loading();
    if (event is ResetPasswordPressedEvent) {
      _userRepository.resetPassword(email: event.email);
      yield ResetPasswordState.success();
    }
  }

  @override
  Future<void> close() {
    _emailController.close();
    return super.close();
  }
}
