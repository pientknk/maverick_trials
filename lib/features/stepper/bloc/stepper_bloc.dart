import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/stepper/bloc/stepper_event.dart';
import 'package:maverick_trials/features/stepper/bloc/stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  final int stepCount;

  StepperBloc({@required this.stepCount});

  @override
  StepperState get initialState =>
      StepperState(stepIndex: 0, stepCount: stepCount);

  @override
  void onTransition(Transition<StepperEvent, StepperState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<StepperState> mapEventToState(StepperEvent event) async* {
    if (event is StepTappedEvent) {
      yield state.copyWith(stepIndex: event.stepIndex);
    } else if (event is StepCancelledEvent) {
      yield state.copyWith(
          stepIndex: state.stepCount - 1 >= 0 ? state.stepIndex - 1 : 0);
    } else if (event is StepContinueEvent) {
      yield state.copyWith(
          stepIndex: state.stepIndex + 1 < stepCount ? state.stepIndex + 1 : 0);
    }
  }
}
