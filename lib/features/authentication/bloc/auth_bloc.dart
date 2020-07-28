import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/repository/user_repository.dart';
import 'package:maverick_trials/core/validation/email_validator.dart';
import 'package:maverick_trials/core/validation/required_field_validator.dart';
import 'package:maverick_trials/core/validation/required_length_validator.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_event.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_state.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
    with RequiredFieldValidator, RequiredLengthValidator, EmailValidator {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  final BehaviorSubject<String> _usernameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final BehaviorSubject<String> _confirmPasswordController =
      BehaviorSubject<String>();

  Function(String) get onUsernameChanged => _usernameController.sink.add;

  Function(String) get onEmailChanged => _emailController.sink.add;

  Function(String) get onPasswordChanged => _passwordController.sink.add;

  Function(String) get onConfirmPasswordChanged =>
      _confirmPasswordController.sink.add;

  Stream<String> get username => _usernameController.stream
      .transform(validateRequiredLength(min: 4, max: 20));

  Stream<String> get email => _emailController.stream;

  Stream<String> get password => _passwordController.stream
      .transform(validateRequiredLength(min: 8, max: 32));

  Stream<String> get confirmPassword => _confirmPasswordController.stream
      .transform(validateRequiredLength(min: 8, max: 32));

  Stream<bool> get canRegister => Rx.combineLatest4(
      username,
      email,
      password,
      confirmPassword,
      (username, email, password, confirmPassword) =>
          (0 == password.compareTo(confirmPassword)));

  @override
  AuthenticationState get initialState => AuthenticationInitialState();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStartedEvent) {
      yield* _mapAuthenticationStartedToState();
    }
    if (event is AuthenticationLoggedInEvent) {
      yield* _mapAuthenticationLoggedInToState();
    }

    if (event is AuthenticationLoggedOutEvent) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await userRepository.isSignedIn();
    if (isSignedIn) {
      final name = await userRepository.getAuthUser();
      yield AuthenticationSuccessState(name: name);
    } else {
      yield AuthenticationFailureState(error: 'Unable to sign in');
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccessState(name: await userRepository.getAuthUser());
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationFailureState(error: 'User is logged out');
    userRepository.signOut();
  }

  @override
  void onTransition(
      Transition<AuthenticationEvent, AuthenticationState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Future<void> close() async {
    await _usernameController.close();
    await _emailController.close();
    await _passwordController.close();
    await _confirmPasswordController.close();
    return super.close();
  }
}
