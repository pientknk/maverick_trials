import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/stepper/bloc/stepper_bloc.dart';
import 'package:maverick_trials/features/stepper/bloc/stepper_event.dart';
import 'package:maverick_trials/features/stepper/bloc/stepper_state.dart';

class StepperView extends StatefulWidget {
  final List<Step> steps;

  StepperView({@required this.steps});

  @override
  _StepperViewState createState() => _StepperViewState();
}

class _StepperViewState extends State<StepperView> {
  StepperBloc _stepperBloc;

  @override
  Widget build(BuildContext context) {
    _stepperBloc = BlocProvider.of<StepperBloc>(context);
    return Container(
        child: BlocBuilder(
            bloc: _stepperBloc,
            builder: (BuildContext context, StepperState state) {
              return Stepper(
                steps: widget.steps,
                currentStep: state.stepIndex,
                type: StepperType.vertical,
                onStepTapped: (step) {
                  _stepperBloc.add(StepTappedEvent(stepIndex: step));
                },
                onStepCancel: () {
                  _stepperBloc.add(StepCancelledEvent());
                },
                onStepContinue: () {
                  _stepperBloc.add(StepContinueEvent());
                },
              );
            }));
  }
}
