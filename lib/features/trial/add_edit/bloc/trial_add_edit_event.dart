import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/trial.dart';

abstract class TrialAddEditEvent extends Equatable {
  TrialAddEditEvent([List props = const []]) : super(props);
}

class AddTrialEvent extends TrialAddEditEvent {
  final Trial trial;

  AddTrialEvent({this.trial}) : super([trial]);

  @override
  String toString() {
    return 'AddTrialEvent<${trial?.name}>';
  }
}

class EditTrialEvent extends TrialAddEditEvent {
  final Trial trial;

  EditTrialEvent({this.trial}) : super([trial]);

  @override
  String toString() {
    return 'EditTrialEvent<${trial?.name}>';
  }
}

class StepTappedEvent extends TrialAddEditEvent {
  final int stepIndex;

  StepTappedEvent({@required this.stepIndex}) : super([stepIndex]);

  @override
  String toString() {
    return 'StepperStepTappedEvent<$stepIndex>';
  }
}

class StepCancelEvent extends TrialAddEditEvent {
  @override
  String toString() {
    return 'StepCancelEvent';
  }
}

class StepContinueEvent extends TrialAddEditEvent {
  final int stepCount;

  StepContinueEvent({@required this.stepCount}) : super([stepCount]);

  @override
  String toString() {
    return 'StepContinueEvent<$stepCount>';
  }
}
