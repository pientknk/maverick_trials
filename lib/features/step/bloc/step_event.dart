import 'package:equatable/equatable.dart';

abstract class StepEvent extends Equatable {
  StepEvent([List props = const []]) : super(props);
}

class StepIndexedEvent extends StepEvent {
  @override
  String toString() {
    return 'StepIndexedEvent<StepEvent>';
  }
}

class StepEditingEvent extends StepEvent {
  @override
  String toString() {
    return 'StepEditingEvent<StepEvent>';
  }
}

class StepCompleteEvent extends StepEvent {
  @override
  String toString() {
    return 'StepValidEvent<StepEvent>';
  }
}

class StepDisabledEvent extends StepEvent {
  @override
  String toString() {
    return 'StepDisabledEvent<StateEvent>';
  }
}

class StepErrorEvent extends StepEvent {
  @override
  String toString() {
    return 'StepInvalidEvent<StepEvent>';
  }
}
