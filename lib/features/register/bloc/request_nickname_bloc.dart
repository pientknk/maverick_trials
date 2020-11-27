import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/exceptions/firestore_exception_handler.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_user_repository.dart';
import 'package:maverick_trials/core/validation/required_field_validator.dart';
import 'package:maverick_trials/core/validation/required_length_validator.dart';
import 'package:maverick_trials/features/auth/bloc/auth.dart';
import 'package:maverick_trials/features/register/bloc/request_nickname_event.dart';
import 'package:maverick_trials/features/register/bloc/request_nickname_state.dart';
import 'package:maverick_trials/locator.dart';
import 'package:maverick_trials/utils/word_generator.dart';
import 'package:rxdart/rxdart.dart';

class RequestNicknameBloc extends Bloc<RequestNicknameEvent, RequestNicknameState>
  with RequiredFieldValidator, RequiredLengthValidator {
  final AuthBloc authBloc;

  RequestNicknameBloc({@required this.authBloc});

  final FirebaseUserRepository _userRepository = locator<FirebaseUserRepository>();

  final BehaviorSubject<String> _nicknameController = BehaviorSubject<String>();
  final TextEditingController nicknameTextController = TextEditingController();
  final BehaviorSubject<bool> _nicknameRunAnimationController = BehaviorSubject<bool>.seeded(false);

  Function(String) get onNicknameChanged => _nicknameController.sink.add;

  Stream<String> get nickname => _nicknameController.stream
    .transform(validateRequiredLength(min: 4, max: 20));

  Stream<bool> get randomGeneratedNickname => _nicknameRunAnimationController.stream;

  @override
  Future<void> close() {
    _nicknameController.close();
    nicknameTextController.dispose();
    _nicknameRunAnimationController.close();
    return super.close();
  }

  @override
  RequestNicknameState get initialState => InitialState();

  @override
  Stream<RequestNicknameState> mapEventToState(RequestNicknameEvent event) async* {
    if(event is SubmitNickname){
      yield LoadingState();
      try{
        FirebaseUser firebaseUser = await _userRepository.setFirebaseUserFields(displayName: event.nickname);
        User user = await _userRepository.getCurrentUser(firebaseUser: firebaseUser);
        authBloc.add(AuthLoggedInEvent(user: user));
      }
      catch(e, st){
        FirestoreExceptionHandler.tryGetMessage(e, st);
        yield FailureState();
      }
    }
  }

  void onRegisterButtonPressed(BuildContext context) {
    _nicknameRunAnimationController.sink.add(false);
    FocusScope.of(context).unfocus();
    this.add(SubmitNickname(
      nickname: _nicknameController.stream.value,
    ));
  }

  void onGenerateNicknameButtonPressed() async {
    _nicknameRunAnimationController.sink.add(true);

    String generatedWordPair = WordGenerator.generateWordPair();
    await Future.delayed(Duration(milliseconds: 500));
    nicknameTextController.value = nicknameTextController.value.copyWith(text: generatedWordPair);
    onNicknameChanged(generatedWordPair);
  }

  @override
  void onTransition(Transition<RequestNicknameEvent, RequestNicknameState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}