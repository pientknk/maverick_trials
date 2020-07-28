import 'package:equatable/equatable.dart';

abstract class StepStateBase extends Equatable {
  StepStateBase([List props = const []]) : super(props);
}

class StepState extends StepStateBase {
  @override
  String toString() {
    return 'g';
  }
}
