import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/repository/user_repository.dart';
import 'package:maverick_trials/core/validation/email_validator.dart';
import 'package:maverick_trials/core/validation/required_field_validator.dart';
import 'package:maverick_trials/core/validation/required_length_validator.dart';
import 'package:maverick_trials/features/register/bloc/register.dart';
import 'package:maverick_trials/utils/word_generator.dart';
import 'package:rxdart/rxdart.dart';

const int kPasswordMaxLength = 32;
const int kPasswordMinLength = 8;

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>
    with RequiredLengthValidator, EmailValidator, RequiredFieldValidator {
  final UserRepository _userRepository;

  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final TextEditingController nicknameTextController = TextEditingController();
  final BehaviorSubject<String> _nicknameController = BehaviorSubject<String>();
  final BehaviorSubject<bool> _nicknameRunAnimationController = BehaviorSubject<bool>.seeded(false);

  Function(String) get onEmailChanged => _emailController.sink.add;

  Function(String) get onPasswordChanged => _passwordController.sink.add;

  Function(String) get onNicknameChanged => _nicknameController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);

  Stream<String> get password => _passwordController.stream.transform(
      validateRequiredLength(min: kPasswordMinLength, max: kPasswordMaxLength));

  Stream<String> get nickname => _nicknameController.stream
      .transform(validateRequiredLength(min: 4, max: 20));

  Stream<bool> get isRegisterButtonEnabled =>
      Rx.combineLatest3(nickname, email, password, (a, b, c) => true);

  Stream<bool> get randomGeneratedNickname => _nicknameRunAnimationController.stream;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.initial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterSubmittedEvent) {
      yield RegisterState.loading();
      try {
        //first check firebase to see if the nickname is taken by searching on users by id
        // if no results then its a new nickname and we can sign them up
        bool success = await _userRepository.signUp(
          nickname: event.nickname,
          email: event.email,
          password: event.password,
        );
        if (!success) {
          yield RegisterState.failure();
        } else {
          yield RegisterState.success();
        }
      } catch (e) {
        print(e);
        yield RegisterState.failure();
      }
    }
  }

  @override
  Future<void> close() {
    _emailController.close();
    _passwordController.close();
    _nicknameController.close();
    _nicknameRunAnimationController.close();
    nicknameTextController.dispose();
    return super.close();
  }

  void onRegisterButtonPressed(BuildContext context) {
    _nicknameRunAnimationController.sink.add(false);
    FocusScope.of(context).unfocus();
    this.add(RegisterSubmittedEvent(
      nickname: _nicknameController.stream.value,
      email: _emailController.stream.value,
      password: _passwordController.stream.value,
    ));
  }

  void onGenerateNicknameButtonPressed() {
    _nicknameRunAnimationController.sink.add(true);

    String generatedWordPair = WordGenerator.generateWordPair();
    nicknameTextController.value = nicknameTextController.value.copyWith(text: generatedWordPair);
    onNicknameChanged(generatedWordPair);
  }
}
