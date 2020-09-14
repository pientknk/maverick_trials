import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maverick_trials/core/repository/user_repository.dart';
import 'package:maverick_trials/core/validation/email_validator.dart';
import 'package:maverick_trials/core/validation/required_field_validator.dart';
import 'package:maverick_trials/core/validation/required_length_validator.dart';
import 'package:maverick_trials/features/authentication/bloc/auth.dart';
import 'package:maverick_trials/features/login/bloc/login_event.dart';
import 'package:maverick_trials/features/login/bloc/login_state.dart';
import 'package:rxdart/rxdart.dart';

const int kPasswordMaxLength = 32;
const int kPasswordMinLength = 8;

class LoginBloc extends Bloc<LoginEvent, LoginState>
    with EmailValidator, RequiredFieldValidator, RequiredLengthValidator {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _emailResetController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  Function(String) get onEmailChanged => _emailController.sink.add;

  Function(String) get onEmailResetChanged => _emailResetController.sink.add;

  Function(String) get onPasswordChanged => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get emailReset =>
      _emailResetController.stream.transform(validateEmail);

  Stream<String> get password => _passwordController.stream.transform(
      validateRequiredLength(min: kPasswordMinLength, max: kPasswordMaxLength));

  Stream<bool> get isLoginButtonEnabled =>
      Rx.combineLatest2(email, password, (a, b) => true);

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  void onLoginButtonPressed() {
    this.add(LoginWithCredentialsPressedEvent(
      email: _emailController.stream.value,
      password: _passwordController.stream.value,
    ));
  }

  @override
  LoginState get initialState => LoginInitialState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInitialEvent) {
      yield* _mapLoginInitialEventToState();
    }

    if (event is LoginWithGooglePressedEvent) {
      yield* _mapLoginWithGooglePressedToState();
    }

    if (event is LoginWithCredentialsPressedEvent) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }

    if (event is AnonymousAccountPressedEvent) {
      yield* _mapAnonymousAccountEventToState();
    }

    if (event is OfflineModePressedEvent) {
      yield* _mapOfflineModePressedEventToState();
    }
  }

  Stream<LoginState> _mapLoginInitialEventToState() async* {
    yield LoginInitialState();
  }

  Stream<LoginState> _mapAnonymousAccountEventToState() async* {
    yield LoginSubmittingState();

    LoginState loginState = LoginInitialState();
    //may need to find a way to check if this user already signed up anonymously? in case they log out and try to log back in
    //or provide a warning when logging out of an anonymous account saying they will lose all their data
    await userRepository.signInAnonymously().then((value) {
      authenticationBloc
          .add(AuthenticationLoggedInEvent(name: "Anonymous Login"));
    }).catchError((e) {
      print('anonymous account login error: $e');
      if (e is PlatformException) {
        loginState = LoginFailureState(errorCode: e.code);
      } else {
        loginState = LoginFailureState(errorCode: e.toString());
      }
    });

    yield loginState;
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    yield LoginSubmittingState();

    LoginState loginState = LoginInitialState();
    await userRepository.signInWithGoogle().then((value) {
      authenticationBloc.add(AuthenticationLoggedInEvent(name: 'Google Login'));
    }).catchError((e) {
      print('login with google error: $e');
      if (e is PlatformException) {
        loginState = LoginFailureState(errorCode: e.code);
      } else {
        loginState = LoginFailureState(errorCode: e.toString());
      }
    });

    yield loginState;
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginSubmittingState();

    LoginState loginState = LoginInitialState();

    await userRepository
        .signInWithCredentials(email: email, password: password)
        .then((value) async {
      bool isEmailVerified = await userRepository.isEmailVerified;
      if (isEmailVerified) {
        authenticationBloc
            .add(AuthenticationLoggedInEvent(name: 'Credentials Login'));
      } else {
        //userRepository.signOut();
        loginState = LoginEmailVerificationRequiredState();
      }
    }).catchError((error) {
      if (error is PlatformException) {
        loginState = LoginFailureState(errorCode: error.code);
      } else {
        loginState = LoginFailureState(errorCode: 'ERROR_LOGIN_CREDENTIALS');
      }
    });

    yield loginState;
  }

  Stream<LoginState> _mapOfflineModePressedEventToState() async* {
    authenticationBloc
      .add(AuthenticationLoggedInEvent(name: 'Offline Login'));
  }

  @override
  Future<void> close() {
    _emailController.close();
    _emailResetController.close();
    _passwordController.close();
    return super.close();
  }
}
