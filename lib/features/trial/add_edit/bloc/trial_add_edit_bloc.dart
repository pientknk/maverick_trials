import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/exceptions/firestore_exception_handler.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_trial_repository.dart';
import 'package:maverick_trials/core/validation/length_validator.dart';
import 'package:maverick_trials/core/validation/required_field_validator.dart';
import 'package:maverick_trials/core/validation/required_length_validator.dart';
import 'package:maverick_trials/features/authentication/bloc/auth.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_event.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_state.dart';
import 'package:maverick_trials/locator.dart';
import 'package:rxdart/rxdart.dart';

const int kFieldMaxLength = 250;
const int kNameMaxLength = 30;

class TrialAddEditBloc extends Bloc<TrialAddEditEvent, TrialAddEditState>
    with RequiredFieldValidator, LengthValidator, RequiredLengthValidator {
  final AuthenticationBloc authBloc;
  final Trial trial;
  final trialRepository = locator<FirebaseTrialRepository>();

  final formKey = GlobalKey<FormState>();

  final BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _descriptionController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _trialTypeController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _winCondController = BehaviorSubject<String>();
  final BehaviorSubject<String> _rulesController = BehaviorSubject<String>();
  final BehaviorSubject<String> _tieBreakerController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _requirementsController =
      BehaviorSubject<String>();
  final List<String> trialTypeOptions = [
    'Group',
    'Individual',
  ];

  /// Inputs
  Function(String) get onNameChanged => _nameController.sink.add;

  Function(String) get onDescriptionChanged => _descriptionController.sink.add;

  Function(String) get onTrialTypeChanged => _trialTypeController.sink.add;

  Function(String) get onWinCondChanged => _winCondController.sink.add;

  Function(String) get onRulesChanged => _rulesController.sink.add;

  Function(String) get onTieBreakerChanged => _tieBreakerController.sink.add;

  Function(String) get onRequirementsChanged =>
      _requirementsController.sink.add;

  /// Validation
  Stream<String> get name => _nameController.stream
      .transform(validateRequiredLength(min: 3, max: kNameMaxLength));

  Stream<String> get description => _descriptionController.stream
      .transform(validateRequiredLength(min: 10, max: kFieldMaxLength));

  Stream<String> get trialType =>
      _trialTypeController.stream.transform(validateRequiredFieldStream);

  Stream<String> get winCondition =>
      _winCondController.stream.transform(validateRequiredFieldStream);

  Stream<String> get rules =>
      _rulesController.stream.transform(validateLength(max: kFieldMaxLength));

  Stream<String> get tieBreaker => _tieBreakerController.stream
      .transform(validateLength(max: kFieldMaxLength));

  Stream<String> get requirements => _requirementsController.stream
      .transform(validateLength(max: kFieldMaxLength));

  /// for the state of the submit button
  Stream<bool> get canSubmit => Rx.combineLatest3(
    name,
    description,
    winCondition,
    (a, b, c,) => true);

  Future<Trial> createNewTrial() async {
    User user = await authBloc.userRepository.getCurrentUser();

    Trial trial = Trial.newTrial()
      ..uID = user.userUID
      ..creatorUserCareerID = user.nickname;

    _setTrial(trial);

    return trial;
  }

  TrialAddEditBloc({@required this.authBloc, @required this.trial})
    : assert(authBloc != null){
    onTrialTypeChanged(trial?.trialType);
  }

  @override
  TrialAddEditState get initialState => StartState();

  @override
  Stream<TrialAddEditState> mapEventToState(TrialAddEditEvent event) async* {
    if (event is AddTrialEvent) {
      yield* _mapAddTrialEventToState(event);
    }

    if (event is EditTrialEvent) {
      yield* _mapEditTrialEventToState(event);
    }
  }

  Stream<TrialAddEditState> _mapAddTrialEventToState(
      AddTrialEvent event) async* {
    yield StateSaving();

    if(validateForm()){
      try{
        Trial trial = await createNewTrial();

        await trialRepository.add(trial);

        yield AddTrialStateSuccess(trial);
      }
      catch(error, stacktrace){
        print(stacktrace);
        yield FailureState(FirestoreExceptionHandler.tryGetMessage(error));
      }
    }
    else{
      yield FailureState('Please fix all errors in the form');
    }

  }

  Stream<TrialAddEditState> _mapEditTrialEventToState(
      EditTrialEvent event) async* {
    yield StateSaving();
    Trial trial = event.trial;

    _setTrial(trial);

    try{
      await trialRepository.update(trial);

      yield EditTrialStateSuccess(trial);
    }
    catch(error){
      yield FailureState(FirestoreExceptionHandler.tryGetMessage(error));
    }
  }

  @override
  void onTransition(
      Transition<TrialAddEditEvent, TrialAddEditState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Future<void> close() {
    _nameController.close();
    _descriptionController.close();
    _trialTypeController.close();
    _winCondController.close();
    _rulesController.close();
    _tieBreakerController.close();
    _requirementsController.close();

    return super.close();
  }

  void _setTrial(Trial trial) {
    trial.name = _nameController.stream.value ?? trial.name;
    trial.description = _descriptionController.stream.value ?? trial.description;
    trial.trialType = _trialTypeController.stream.value ?? trial.trialType;
    trial.winCondition = _winCondController.stream.value ?? trial.winCondition;
    trial.rules = _rulesController.stream.value ?? trial.rules;
    trial.tieBreaker = _tieBreakerController.stream.value ?? trial.tieBreaker;
    trial.requirements = _requirementsController.stream.value ?? trial.requirements;
  }

  bool validateForm(){
    if(formKey.currentState != null){
      return formKey.currentState.validate();
    }

    return false;
  }
}
