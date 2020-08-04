import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_bloc.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_event.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_state.dart';
import 'package:maverick_trials/ui/shared/app_loading_indicator.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';


class TrialAddEditForm extends StatefulWidget {
  final Trial trial;

  TrialAddEditForm({Key key, @required this.trial})
    : super(key: key);

  @override
  _TrialAddEditFormState createState() => _TrialAddEditFormState();
}

class _TrialAddEditFormState extends State<TrialAddEditForm> {
  TrialAddEditBloc _trialAddEditBloc;

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  @override
  void initState() {
    _trialAddEditBloc = BlocProvider.of<TrialAddEditBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _trialAddEditBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrialAddEditBloc, TrialAddEditState>(
      bloc: _trialAddEditBloc,
      listener: (context, state) {
        if(state is StateLoading){
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BasicProgressIndicator(),
                    Text('Loading Form...'),
                  ],
                ),
                duration: Duration(seconds: 2),
              ),
            );
        }

        if (state is AddTrialStateSuccess || state is EditTrialStateSuccess) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<TrialAddEditBloc, TrialAddEditState>(
        builder: (BuildContext context, TrialAddEditState state){
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 10,
                child: _buildTrialStepper()
              ),
              Expanded(
                flex: 1,
                child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: StreamBuilder<bool>(
                              stream: _trialAddEditBloc.canSubmit,
                              builder: (context, snapshot) {
                                return AppIconButton(
                                  text: Text("Create"),
                                  color: Colors.grey[300],
                                  icon: Icon(Icons.add),
                                  onPressed: (snapshot.hasData && snapshot.data == true)
                                    ? () {
                                    _trialAddEditBloc.add(widget.trial == null
                                      ? AddTrialEvent(trial: widget.trial)
                                      : EditTrialEvent(trial: widget.trial));
                                  }
                                    : null,
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _nextButton(VoidCallback onStepContinue){
    FlatButton nextButton = FlatButton(
      onPressed: onStepContinue,
      child: Text('NEXT',
        style: Theme.of(context).accentTextTheme.button,
      ),
      color: Theme.of(context).primaryColor,
    );

    if(_trialAddEditBloc.stepperIndex == 0){
      return StreamBuilder<bool>(
        stream: _trialAddEditBloc.stepOneValid,
        builder: (context, snapshot) {
          return FlatButton(
            onPressed: (snapshot.hasData && snapshot.data == true)
              ? onStepContinue
              : (){
                _trialAddEditBloc.validateFormKey(0);
              },
            child: Text('NEXT',
              style: Theme.of(context).accentTextTheme.button,
            ),
            color: Theme.of(context).primaryColor,
            //disabledColor: Theme.of(context).disabledColor,
          );
        }
      );
    }
    else if(_trialAddEditBloc.stepperIndex == 1){
      return StreamBuilder<bool>(
        stream: _trialAddEditBloc.stepTwoValid,
        builder: (context, snapshot) {
          return FlatButton(
            onPressed: onStepContinue,
            child: Text('NEXT',
              style: Theme.of(context).accentTextTheme.button,
            ),
            color: Theme.of(context).primaryColor,
          );
        }
      );
    }
    else{
      return nextButton;
    }
  }

  Widget _stepperNextOptionOnly(VoidCallback onStepContinue){
    return Row(
      children: <Widget>[
        _nextButton(onStepContinue),
      ],
    );
  }

  Widget _stepperBothOptions(VoidCallback onStepContinue, VoidCallback onStepCancel) {
    return Row(
      children: <Widget>[
        _nextButton(onStepContinue),
        FlatButton(
          onPressed: onStepCancel,
          child: Text('BACK'),
        ),
      ],
    );
  }

  Widget _buildTrialStepper(){
    List<Step> steps = _buildTrialSteps();

    return Stepper(
      controlsBuilder: (BuildContext context,
        {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
        if(_trialAddEditBloc.stepperIndex == 0){
          return _stepperNextOptionOnly(onStepContinue);
        }
        else if(_trialAddEditBloc.stepperIndex != steps.length - 1){
          return _stepperBothOptions(onStepContinue, onStepCancel);
        }
        else{
          return Container();
        }
      },
      type: StepperType.vertical,
      steps: steps,
      currentStep: _trialAddEditBloc.stepperIndex,
      onStepContinue: () => _trialAddEditBloc.add(StepContinueEvent(stepCount: steps.length)),
      onStepCancel: () => _trialAddEditBloc.add(StepCancelEvent()),
      onStepTapped: (step) => _trialAddEditBloc.add(StepTappedEvent(stepIndex: step)),
    );
  }

  List<Step> _buildTrialSteps(){
    return [
      Step(
        title: Text("Name, Description, and Trial Type"),
        isActive: true,
        state: (_trialAddEditBloc.stepperIndex == 0) ? StepState.editing : StepState.complete,
        content: Form(
          key: _trialAddEditBloc.formKeys[0],
          child: Column(
            children: <Widget>[
              _nameFormField(),
              _descriptionFormField(),
              _trialTypeDropDownFormField(),
            ],
          ),
        )
      ),
      Step(
        title: Text("Win Condition and Rules"),
        isActive: true,
        state: _trialAddEditBloc.stepperIndex < 1
          ? StepState.disabled
          : _trialAddEditBloc.stepperIndex == 1 ? StepState.editing : StepState.complete,
        content: Form(
          key: _trialAddEditBloc.formKeys[1],
          child: Column(
            children: <Widget>[
              _winConditionFormField(),
              _rulesTextFormField(),
            ],
          ),
        ),
      ),
      Step(
        title: Text("Tie Breaker and Requirements"),
        isActive: true,
        state: _trialAddEditBloc.stepperIndex < 2
          ? StepState.disabled
          : _trialAddEditBloc.stepperIndex == 2 ? StepState.editing : StepState.complete,
        content: Form(
          key: _trialAddEditBloc.formKeys[2],
          child: Column(
            children: <Widget>[
              _tieBreakerFormField(),
              _requirementsFormField(),
            ],
          ),
        ),
      ),
      Step(
        title: Text("Done"),
        isActive: true,
        state: _trialAddEditBloc.stepperIndex == 3
          ? StepState.complete : StepState.editing,
        content: Form(
          key: _trialAddEditBloc.formKeys[3],
          child: Container()
        ),
      ),
    ];
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
            labelText: 'Win Condition*',
            hintText: 'How is the winner determined?',
            errorText: snapshot.error,
            helperText: '*Required'
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
            labelText: 'Description*',
            hintText: 'Describe what this trial is',
            errorText: snapshot.error,
            helperText: '*Required',
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
            labelText: 'Name*',
            hintText: 'Name it something fun and distinct',
            errorText: snapshot.error,
            helperText: '*Required',
          ),
          onChanged: _trialAddEditBloc.onNameChanged,
          validator: _trialAddEditBloc.validateRequiredField,
        );
      },
    );
  }
}
