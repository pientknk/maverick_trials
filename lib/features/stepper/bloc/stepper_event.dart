import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class StepperEvent extends Equatable {
  StepperEvent([List props = const []]) : super(props);
}

class StepTappedEvent extends StepperEvent {
  final int stepIndex;

  StepTappedEvent({@required this.stepIndex}) : super([stepIndex]);

  @override
  String toString() {
    return 'StepTappedEvent<$stepIndex>';
  }
}

class StepCancelledEvent extends StepperEvent {
  final int stepIndex;

  StepCancelledEvent({@required this.stepIndex}) : super([stepIndex]);

  @override
  String toString() {
    return 'StepCancelledEvent<$stepIndex>';
  }
}

class StepContinueEvent extends StepperEvent {
  final int stepIndex;

  StepContinueEvent({@required this.stepIndex}) : super([stepIndex]);

  @override
  String toString() {
    return 'StepContinueEvent<$stepIndex>';
  }
}
