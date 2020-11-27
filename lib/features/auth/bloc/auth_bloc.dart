import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_settings_repository.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_user_repository.dart';
import 'package:maverick_trials/core/validation/email_validator.dart';
import 'package:maverick_trials/core/validation/required_field_validator.dart';
import 'package:maverick_trials/core/validation/required_length_validator.dart';
import 'package:maverick_trials/features/auth/auth_login_type.dart';
import 'package:maverick_trials/features/auth/bloc/auth_event.dart';
import 'package:maverick_trials/features/auth/bloc/auth_state.dart';
import 'package:maverick_trials/locator.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>
    with RequiredFieldValidator, RequiredLengthValidator, EmailValidator {
  final userRepository = locator<FirebaseUserRepository>();
  final settingsRepository = locator<FirebaseSettingsRepository>();

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
  AuthState get initialState => AuthInitialState();

  @override
  Stream<AuthState> mapEventToState(
      AuthEvent event) async* {
    if (event is AuthStartedEvent) {
      yield* _mapAuthenticationStartedToState();
    }

    if (event is AuthLoggedInEvent) {
      yield* _mapAuthenticationLoggedInToState(event);
    }

    if(event is AuthRequestIntroEvent){
      yield*  _mapAuthRequestIntroEventToState();
    }

    if (event is AuthLoggedOutEvent) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAuthenticationStartedToState() async* {
    User user = await userRepository.getCurrentUser();

    bool isSignedIn = await userRepository.isSignedIn(user?.firebaseUser);
    if (isSignedIn) {
      yield getAuthSuccessState(user);
    }
    else {
      yield AuthFailureState(error: 'Unable to sign in. No user session found.');
    }
  }

  Stream<AuthState> _mapAuthenticationLoggedInToState(AuthLoggedInEvent event) async* {
    User user = event?.user ?? await userRepository.getCurrentUser();
    if(user == null){
      FirebaseUser firebaseUser = await userRepository.getAuthUser();
      if(firebaseUser.isAnonymous){
        yield AuthSuccessState(authLoginType: AuthLoginType.success);
      }
      else{
        yield AuthFailureState(error: 'Unauthorized User attemping to login.');
      }
    }
    else{
      yield getAuthSuccessState(user);
    }
  }

  Stream<AuthState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthFailureState(error: 'User is logged out.');
    userRepository.signOut();
  }

  Stream<AuthState> _mapAuthRequestIntroEventToState() async* {
    yield AuthSuccessState(authLoginType: AuthLoginType.requestIntro);
  }

  @override
  void onTransition(
      Transition<AuthEvent, AuthState> transition) {
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

  AuthState getAuthSuccessState(User user){
    if(user != null){
      if(user.firebaseUser.isAnonymous){
        return AuthSuccessState(authLoginType: AuthLoginType.success, user: user);
      }
      else if(!user.hasNickname){
        return AuthSuccessState(authLoginType: AuthLoginType.requestNickname, user: user);
      }
      else if(!user.hasCompletedIntro){
        return AuthSuccessState(authLoginType: AuthLoginType.requestIntro, user: user);
      }
      else{
        return AuthSuccessState(authLoginType: AuthLoginType.success, user: user);
      }
    }
    else{
      return AuthFailureState(error: 'No user found');
    }
  }
}
