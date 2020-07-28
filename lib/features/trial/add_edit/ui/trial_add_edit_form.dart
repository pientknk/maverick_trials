import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_bloc.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_event.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_state.dart';

class TrialAddEditForm extends StatefulWidget {
  final Trial trial;

  TrialAddEditForm({@required this.trial});

  @override
  _TrialAddEditFormState createState() => _TrialAddEditFormState();
}

class _TrialAddEditFormState extends State<TrialAddEditForm> {
  TrialAddEditBloc _trialAddEditBloc;

  int _currentStep = 0;

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final List<bool> validSteps = [
    true,
    true,
    true,
  ];

  @override
  void initState() {
    _trialAddEditBloc = BlocProvider.of<TrialAddEditBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
          title: Text("Step 1"),
          isActive: true,
          state: (_currentStep == 0) ? StepState.editing : StepState.complete,
          content: Form(
            key: _formKeys[0],
            child: Column(
              children: <Widget>[
                _nameFormField(),
                _descriptionFormField(),
                _trialTypeDropDownFormField(),
              ],
            ),
          )),
      Step(
        title: Text("Step 2"),
        isActive: true,
        state: _currentStep < 1
            ? StepState.disabled
            : _currentStep == 1 ? StepState.editing : StepState.complete,
        content: Form(
          key: _formKeys[1],
          child: Column(
            children: <Widget>[
              _winConditionFormField(),
              _rulesTextFormField(),
            ],
          ),
        ),
      ),
      Step(
        title: Text("Step 3"),
        isActive: true,
        state: _currentStep < 2
            ? StepState.disabled
            : _currentStep == 2 ? StepState.editing : StepState.complete,
        content: Form(
          key: _formKeys[2],
          child: Column(
            children: <Widget>[
              _tieBreakerFormField(),
              _requirementsFormField(),
            ],
          ),
        ),
      ),
    ];

    return BlocListener<TrialAddEditBloc, TrialAddEditState>(
      bloc: _trialAddEditBloc,
      listener: (context, state) {
        if (state is AddTrialStateSuccess || state is EditTrialStateSuccess) {
          Navigator.pop(context);
        }
      },
      child: Column(
        children: <Widget>[
          Expanded(
            child: Stepper(
              type: StepperType.vertical,
              steps: steps,
              currentStep: _currentStep,
              onStepContinue: () {
                onStepContinue(steps.length);
              },
              onStepCancel: onStepCancel,
              onStepTapped: (step) => onStepTapped,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: StreamBuilder<bool>(
                      stream: _trialAddEditBloc.canSubmit,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return RaisedButton(
                          child: Text('Submit'),
                          onPressed: (snapshot.hasData && snapshot.data == true)
                              ? () {
                                  // submit process and navigate back to list
                                  _trialAddEditBloc.add(widget.trial == null
                                      ? AddTrialEvent(trial: widget.trial)
                                      : EditTrialEvent(trial: widget.trial));
                                }
                              // null will disable the button
                              : null,
                        );
                      }),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void onStepContinue(int length) {
    setState(() {
      if (_currentStep == length - 1) {
        //_complete = true;
      } else {
        if (_formKeys[_currentStep].currentState.validate()) {
          _formKeys[_currentStep].currentState.save();
          validSteps[_currentStep] = true;
          _currentStep += 1;
        } else {
          validSteps[_currentStep] = false;
        }
      }
    });
  }

  void onStepCancel() {
    if (_currentStep != 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  void onStepTapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  Widget _trialTypeDropDownFormField() {
    return StreamBuilder<String>(
      stream: _trialAddEditBloc.trialType,
      builder: (context, snapshot) {
        return Container(
          child: Center(
              child: snapshot.hasData
                  ? DropdownButtonFormField<String>(
                      value: snapshot.data,
                      decoration: InputDecoration(
                        labelText: 'Trial Type',
                        hintText: 'Choose a Trial Type',
                      ),
                      items: _trialAddEditBloc.trialTypeOptions
                          .map((value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        _trialAddEditBloc.onTrialTypeChanged;
                      },
                    )
                  : CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _requirementsFormField() {
    return StreamBuilder<String>(
      stream: _trialAddEditBloc.requirements,
      builder: (context, snapshot) {
        return TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Requirements',
            hintText: 'Objects or environment required to play',
            errorText: snapshot.error,
          ),
          onChanged: _trialAddEditBloc.onRequirementsChanged,
        );
      },
    );
  }

  Widget _tieBreakerFormField() {
    return StreamBuilder<String>(
      stream: _trialAddEditBloc.tieBreaker,
      builder: (context, snapshot) {
        return TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Tie Breaker',
            hintText: 'Trial boss can decide or?',
            errorText: snapshot.error,
          ),
          onChanged: _trialAddEditBloc.onTieBreakerChanged,
        );
      },
    );
  }

  Widget _winConditionFormField() {
    return StreamBuilder<String>(
      stream: _trialAddEditBloc.winCondition,
      builder: (context, snapshot) {
        return TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Win Condition *',
            hintText: 'How is the winner determined?',
            errorText: snapshot.error,
          ),
          onChanged: _trialAddEditBloc.onWinCondChanged,
          validator: _trialAddEditBloc.validateRequiredField,
        );
      },
    );
  }

  Widget _rulesTextFormField() {
    return StreamBuilder<String>(
      stream: _trialAddEditBloc.rules,
      builder: (context, snapshot) {
        return TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Rules',
            hintText: 'To keep those cheaters at bay',
            errorText: snapshot.error,
          ),
          onChanged: _trialAddEditBloc.onRulesChanged,
        );
      },
    );
  }

  Widget _descriptionFormField() {
    return StreamBuilder<String>(
      stream: _trialAddEditBloc.description,
      builder: (context, snapshot) {
        return TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Description *',
            hintText: 'Describe what this trial is',
            errorText: snapshot.error,
          ),
          onChanged: _trialAddEditBloc.onDescriptionChanged,
          validator: _trialAddEditBloc.validateRequiredField,
          maxLength: kFieldMaxLength,
        );
      },
    );
  }

  Widget _nameFormField() {
    return StreamBuilder<String>(
      stream: _trialAddEditBloc.name,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Name *',
            hintText: 'Name it something fun and distinct',
            errorText: snapshot.error,
          ),
          onChanged: _trialAddEditBloc.onNameChanged,
          validator: _trialAddEditBloc.validateRequiredField,
        );
      },
    );
  }
}
