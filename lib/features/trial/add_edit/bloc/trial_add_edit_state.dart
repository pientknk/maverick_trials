import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/trial.dart';

abstract class TrialAddEditState extends Equatable {
  TrialAddEditState([List props = const []]) : super(props);
}

class StartState extends TrialAddEditState {
  @override
  String toString() {
    return 'StartState<TrialAddEditState>';
  }
}

class StateLoading extends TrialAddEditState {
  @override
  String toString() {
    return 'StateLoading<TrialAddEditState>';
  }
}

class AddTrialStateSuccess extends TrialAddEditState {
  final Trial trial;

  AddTrialStateSuccess(this.trial) : super([trial]);

  @override
  String toString() {
    return 'AddTrialStateSuccess<${trial.name}>';
  }
}

class AddTrialStateFailure extends TrialAddEditState {
  final String error;

  AddTrialStateFailure(this.error) : super([error]);

  @override
  String toString() {
  return 'AddTrialStateFailure<$error>';
  }
}

class EditTrialStateSuccess extends TrialAddEditState {
  final Trial trial;

  EditTrialStateSuccess(this.trial) : super([trial]);

  @override
  String toString() {
    return 'EditTrialStateSuccess<${trial.name}>';
  }
}

class EditTrialStateFailure extends TrialAddEditState {
  final String error;

  EditTrialStateFailure(this.error) : super([error]);

  @override
  String toString() {
    return 'EditTrialStateFailure<$error>';
  }
}

class StepperState extends TrialAddEditState {
  final int stepIndex;

  StepperState({@required this.stepIndex}) : super([stepIndex]);

  @override
  String toString() {
    return 'StepperState<$stepIndex>';
  }
}
