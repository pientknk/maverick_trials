import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class StepperStateBase extends Equatable {
  StepperStateBase([List props = const []]) : super(props);
}

class StartState extends StepperStateBase {
  @override
  String toString() {
    return 'StartState<StepperState>';
  }
}

class StepSuccess extends StepperStateBase {
  final Step step;

  StepSuccess({this.step}) : super([step]);

  @override
  String toString() {
    return 'StepSuccess<${step.title}>';
  }
}

class StepFailure extends StepperStateBase {
  final Step step;

  StepFailure({this.step}) : super([step]);

  @override
  String toString() {
    return 'StepFailure<${step.title}>';
  }
}

class StepperState extends StepperStateBase {
  final int stepIndex;
  final int stepCount;

  StepperState({@required this.stepIndex, @required this.stepCount})
      : super([stepIndex, stepCount]);

  StepperState copyWith({int stepIndex, int stepCount}) {
    return StepperState(
      stepIndex: stepIndex ?? this.stepIndex,
      stepCount: stepCount ?? this.stepCount,
    );
  }

  @override
  String toString() {
    return 'StepperState<$stepIndex, $stepCount>';
  }
}
