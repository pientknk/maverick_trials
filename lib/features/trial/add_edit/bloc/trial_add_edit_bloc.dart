import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/core/repository/trial_repository.dart';
import 'package:maverick_trials/core/validation/length_validator.dart';
import 'package:maverick_trials/core/validation/required_field_validator.dart';
import 'package:maverick_trials/core/validation/required_length_validator.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_event.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_state.dart';
import 'package:rxdart/rxdart.dart';

const int kFieldMaxLength = 250;
const int kNameMaxLength = 30;

class TrialAddEditBloc extends Bloc<TrialAddEditEvent, TrialAddEditState>
    with RequiredFieldValidator, LengthValidator, RequiredLengthValidator {
  final TrialRepository trialRepository;

  final formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _descriptionController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _trialTypeController =
      BehaviorSubject<String>.seeded('Group');
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
  final BehaviorSubject<int> _stepperIndexController = BehaviorSubject<int>.seeded(0);

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

  int get stepperIndex => _stepperIndexController.stream.value;

  ValueStream<int> get stepperIndexStream => _stepperIndexController.stream;

  /// for the state of the submit button
  Stream<bool> get canSubmit => Rx.combineLatest4(
    name,
    description,
    trialType,
    winCondition,
    (a, b, c, d,) => true);
  
  Stream<bool> get stepOneValid => Rx.combineLatest3(
    name,
    description,
    trialType,
    (a, b, c) => true);
  
  Stream<bool> get stepTwoValid => Rx.combineLatest([winCondition], (values) => true);

  void addTrial() async {
    Trial trial = Trial.newTrial();
    trial.name = _nameController.stream.value;
    trial.description = _descriptionController.stream.value;
    trial.trialType = _trialTypeController.stream.value;
    trial.winCondition = _winCondController.stream.value;
    trial.rules = _rulesController.stream.value;
    trial.tieBreaker = _tieBreakerController.stream.value;
    trial.requirements = _requirementsController.stream.value;

    trial.creatorUserCareerID = 'Nick Pientka';
    trial.createdTime = DateTime.now();
    trial.trialRunCount = 0;
    trial.gameCount = 0;
  }

  TrialAddEditBloc({@required this.trialRepository});

  @override
  TrialAddEditState get initialState => StartState();

  @override
  Stream<TrialAddEditState> mapEventToState(TrialAddEditEvent event) async* {
    if(event is StepTappedEvent){
      onStepTap(event.stepIndex);
      yield StepperState(stepIndex: event.stepIndex);
    }

    if(event is StepContinueEvent){
      onStepContinue(event.stepCount);
      yield StepperState(stepIndex: stepperIndex);
    }

    if(event is StepCancelEvent){
      onStepCancel();
      yield StepperState(stepIndex: stepperIndex);
    }

    if (event is AddTrialEvent) {
      yield* _mapAddTrialEventToState(event);
    }

    if (event is EditTrialEvent) {
      yield* _mapEditTrialEventToState(event);
    }
  }

  Stream<TrialAddEditState> _mapAddTrialEventToState(
      AddTrialEvent event) async* {
    yield StateLoading();
    Trial trial = Trial.newTrial();
    _setTrial(trial);

    trial.creatorUserCareerID = 'Nick Pientka';
    trial.createdTime = DateTime.now();
    trial.trialRunCount = 0;
    trial.gameCount = 0;

    Trial addedTrial = await trialRepository.addTrial(event.trial);
    yield AddTrialStateSuccess(addedTrial);
  }

  Stream<TrialAddEditState> _mapEditTrialEventToState(
      EditTrialEvent event) async* {
    yield StateLoading();
    Trial trial = event.trial;
    _setTrial(trial);

    Trial editTrial = await trialRepository.updateTrial(trial);
    yield EditTrialStateSuccess(editTrial);
  }

  @override
  void onTransition(
      Transition<TrialAddEditEvent, TrialAddEditState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  void dispose() {
    _nameController.close();
    _descriptionController.close();
    _trialTypeController.close();
    _winCondController.close();
    _rulesController.close();
    _tieBreakerController.close();
    _requirementsController.close();
    _stepperIndexController.close();
  }

  void _setTrial(Trial trial) {
    trial.name = _nameController.stream.value;
    trial.description = _descriptionController.stream.value;
    trial.trialType = _trialTypeController.stream.value;
    trial.winCondition = _winCondController.stream.value;
    trial.rules = _rulesController.stream.value;
    trial.tieBreaker = _tieBreakerController.stream.value;
    trial.requirements = _requirementsController.stream.value;
  }

  void onStepCancel(){
    int currentIndex = _stepperIndexController.stream.value;
    if(--currentIndex >= 0){
      _stepperIndexController.sink.add(currentIndex);
    }
  }

  void onStepContinue(int stepCount) {
    int currentIndex = _stepperIndexController.stream.value;
    if(++currentIndex < stepCount){
      String name = _nameController.stream.value;
      print('OnStepContinue: name - $name');

      final formKey = formKeys[stepperIndex];
      if(formKey.currentState != null){
        if(formKey.currentState.validate()){
          _stepperIndexController.sink.add(currentIndex);
        }
      }
      else{
        print('onStepContinue: formkey current state is null');
      }
    }
  }

  void onStepTap(int stepIndex){
    if(stepIndex > stepperIndex){
      final formKey = formKeys[stepperIndex];
      if(formKey.currentState != null){
        if(formKey.currentState.validate()){
          _stepperIndexController.sink.add(stepIndex);
        }
      }
      else{
        print('onStepTap: formkey current state is null');
      }
    }
    else{
      _stepperIndexController.sink.add(stepIndex);
    }
  }

  void validateFormKey(int index){
    final formKey = formKeys[index];
    if(formKey.currentState != null){
      formKey.currentState.validate();
    }
  }
}
