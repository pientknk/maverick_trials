import 'package:flutter/material.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_bloc.dart';

class TrialAddView extends StatefulWidget {
  @override
  _TrialAddViewState createState() => _TrialAddViewState();
}

class _TrialAddViewState extends State<TrialAddView> {
  TrialAddEditBloc _trialFormBloc;

  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  int _currentStep = 0;

  @override
  void initState() {
    _trialFormBloc = TrialAddEditBloc();
    super.initState();
  }

  final List<bool> validSteps = [
    true,
    true,
    true,
  ];

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

    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
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
                      stream: _trialFormBloc.canSubmit,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return RaisedButton(
                          child: Text('Submit'),
                          onPressed: (snapshot.hasData && snapshot.data == true)
                              ? () {
                                  // submit process and navigate back to list
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

  @override
  void dispose() {
    _trialFormBloc?.dispose();
    super.dispose();
  }

  Widget _trialTypeDropDownFormField() {
    return StreamBuilder<String>(
      stream: _trialFormBloc.trialType,
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
                      items: _trialFormBloc.trialTypeOptions
                          .map((value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        _trialFormBloc.onTrialTypeChanged;
                      },
                    )
                  : CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _requirementsFormField() {
    return StreamBuilder<String>(
      stream: _trialFormBloc.requirements,
      builder: (context, snapshot) {
        return TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Requirements',
            hintText: 'Objects or environment required to play',
            errorText: snapshot.error,
          ),
          onChanged: _trialFormBloc.onRequirementsChanged,
        );
      },
    );
  }

  Widget _tieBreakerFormField() {
    return StreamBuilder<String>(
      stream: _trialFormBloc.tieBreaker,
      builder: (context, snapshot) {
        return TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Tie Breaker',
            hintText: 'Trial boss can decide or?',
            errorText: snapshot.error,
          ),
          onChanged: _trialFormBloc.onTieBreakerChanged,
        );
      },
    );
  }

  Widget _winConditionFormField() {
    return StreamBuilder<String>(
      stream: _trialFormBloc.winCondition,
      builder: (context, snapshot) {
        return TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Win Condition *',
            hintText: 'How is the winner determined?',
            errorText: snapshot.error,
          ),
          onChanged: _trialFormBloc.onWinCondChanged,
          validator: _trialFormBloc.validateRequiredField,
        );
      },
    );
  }

  Widget _rulesTextFormField() {
    return StreamBuilder<String>(
      stream: _trialFormBloc.rules,
      builder: (context, snapshot) {
        return TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Rules',
            hintText: 'To keep those cheaters at bay',
            errorText: snapshot.error,
          ),
          onChanged: _trialFormBloc.onRulesChanged,
        );
      },
    );
  }

  Widget _descriptionFormField() {
    return StreamBuilder<String>(
      stream: _trialFormBloc.description,
      builder: (context, snapshot) {
        return TextFormField(
          maxLines: null,
          decoration: InputDecoration(
            labelText: 'Description *',
            hintText: 'Describe what this trial is',
            errorText: snapshot.error,
          ),
          onChanged: _trialFormBloc.onDescriptionChanged,
          validator: _trialFormBloc.validateRequiredField,
        );
      },
    );
  }

  Widget _nameFormField() {
    return StreamBuilder<String>(
      stream: _trialFormBloc.name,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Name *',
            hintText: 'Name it something fun and distinct',
            errorText: snapshot.error,
          ),
          onChanged: _trialFormBloc.onNameChanged,
          validator: _trialFormBloc.validateRequiredField,
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Add Trial'),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 25.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

/*
  Widget _getBody(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
      Expanded(
        child: StreamBuilder(
          stream: _movieBloc.outDropDownValue,
          initialData: _movieBloc.dropdownValue,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            return Container(
              child: Center(
                child: DropdownButton<String>(
                value: snapshot.data,
                elevation: 16,
                style: const TextStyle(
                color: Colors.black54
                ),
            underline: Container(
            height: 2,
            color: Colors.black54,
            ),
            onChanged: (newValue)
            => _movieBloc.inMovieEvent.add(MovieCategorySelectedEvent(newValue)),
            items: _movieBloc.movieCategories
              .map<DropdownMenuItem<String>>((MovieCategory value) {
            return DropdownMenuItem<String>(
            value: value.value,
            child: Text(
            value.label
    ),
    );
    }).toList(),
    )
    )
    );
    },
    )
    )
    ],
    );

   */
}
