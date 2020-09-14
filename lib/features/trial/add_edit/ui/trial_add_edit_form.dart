import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_bloc.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_event.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_state.dart';
import 'package:maverick_trials/ui/shared/app_loading_indicator.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:maverick_trials/ui/widgets/app_text_fields.dart';

class TrialAddEditForm extends StatefulWidget {
  final Trial trial;

  TrialAddEditForm({Key key, @required this.trial}) : super(key: key);

  @override
  _TrialAddEditFormState createState() => _TrialAddEditFormState();
}

class _TrialAddEditFormState extends State<TrialAddEditForm> {
  TrialAddEditBloc _trialAddEditBloc;
  FocusNode nameNode;
  FocusNode descriptionNode;
  FocusNode winCondNode;
  FocusNode rulesNode;
  FocusNode tiebreakerNode;
  FocusNode requirementsNode;

  @override
  void initState() {
    _trialAddEditBloc = BlocProvider.of<TrialAddEditBloc>(context);
    nameNode = FocusNode();
    descriptionNode = FocusNode();
    winCondNode = FocusNode();
    rulesNode = FocusNode();
    tiebreakerNode = FocusNode();
    requirementsNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _trialAddEditBloc.close();
    nameNode.dispose();
    descriptionNode.dispose();
    winCondNode.dispose();
    rulesNode.dispose();
    tiebreakerNode.dispose();
    requirementsNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrialAddEditBloc, TrialAddEditState>(
      bloc: _trialAddEditBloc,
      listener: (context, state) {
        if (state is StateLoading) {
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

        if (state is StateSaving) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BasicProgressIndicator(),
                    Text('Saving Trial...'),
                  ],
                ),
                duration: Duration(seconds: 2),
              ),
            );
        }

        if (state is AddTrialStateSuccess || state is EditTrialStateSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.check_circle),
                    Text('Saved Successfully'),
                  ],
                ),
                duration: Duration(seconds: 2),
              ),
            );
          Navigator.pop(context);
        }

        if (state is FailureState) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.error),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(state.error),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
        }
      },
      child: BlocBuilder<TrialAddEditBloc, TrialAddEditState>(
        builder: (BuildContext context, TrialAddEditState state) {
          return Form(
            key: _trialAddEditBloc.formKey,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        children: _buildForm(),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: widget.trial == null ? createButton() : updateButton(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget createButton() {
    return StreamBuilder<bool>(
      stream: _trialAddEditBloc.canSubmit,
      builder: (context, snapshot) {
        return AppIconButton(
          text: Text('Create'),
          color: Colors.grey[300],
          icon: Icon(Icons.add),
          onPressed: (snapshot.hasData && snapshot.data == true)
              ? () {
                  _trialAddEditBloc.add(AddTrialEvent(trial: widget.trial));
                }
              : null,
        );
      },
    );
  }

  Widget updateButton() {
    return AppIconButton(
      text: Text('Update'),
      color: Theme.of(context).primaryColor,
      icon: Icon(Icons.save),
      onPressed: () {
        _trialAddEditBloc.add(EditTrialEvent(trial: widget.trial));
      },
    );
  }

  List<Widget> _buildForm() {
    return [
      _nameFormField(),
      _descriptionFormField(),
      _winConditionFormField(),
      _trialTypeDropDownFormField(),
      _rulesTextFormField(),
      _tieBreakerFormField(),
      _requirementsFormField(),
    ];
  }

  Widget _trialTypeDropDownFormField() {
    return BasicStreamDropDownFormField(
      stream: _trialAddEditBloc.trialType,
      labelText: Trial.friendlyFieldNames[TrialFields.trialType],
      hintText: 'Choose a Trial Type',
      menuItems: _trialAddEditBloc.trialTypeOptions
          .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
          .toList(),
      onChanged: _trialAddEditBloc.onTrialTypeChanged,
    );
  }

  Widget _requirementsFormField() {
    return BasicStreamTextFormField(
      stream: _trialAddEditBloc.requirements,
      initialValue: widget.trial?.requirements,
      labelText: Trial.friendlyFieldNames[TrialFields.requirements],
      hintText: 'Objects or environment required to play',
      onChanged: _trialAddEditBloc.onRequirementsChanged,
      textInputAction: TextInputAction.done,
      currentFocusNode: requirementsNode,
    );
  }

  Widget _tieBreakerFormField() {
    return BasicStreamTextFormField(
      stream: _trialAddEditBloc.tieBreaker,
      initialValue: widget.trial?.tieBreaker,
      labelText: Trial.friendlyFieldNames[TrialFields.tieBreaker],
      hintText: 'Trial boss can decide this',
      onChanged: _trialAddEditBloc.onTieBreakerChanged,
      textInputAction: TextInputAction.next,
      currentFocusNode: tiebreakerNode,
      nextFocusNode: requirementsNode,
    );
  }

  Widget _winConditionFormField() {
    return BasicStreamTextFormField(
      stream: _trialAddEditBloc.winCondition,
      initialValue: widget.trial?.winCondition,
      labelText: Trial.friendlyFieldNames[TrialFields.winCondition],
      hintText: 'How is the winner determined?',
      requiredField: true,
      onChanged: _trialAddEditBloc.onWinCondChanged,
      textInputAction: TextInputAction.done,
      currentFocusNode: winCondNode,
    );
  }

  Widget _rulesTextFormField() {
    return BasicStreamTextFormField(
      stream: _trialAddEditBloc.rules,
      initialValue: widget.trial?.rules,
      labelText: Trial.friendlyFieldNames[TrialFields.rules],
      hintText: 'To keep those cheaters at bay',
      onChanged: _trialAddEditBloc.onRulesChanged,
      textInputAction: TextInputAction.next,
      currentFocusNode: rulesNode,
      nextFocusNode: tiebreakerNode,
    );
  }

  Widget _descriptionFormField() {
    return BasicStreamTextFormField(
      stream: _trialAddEditBloc.description,
      initialValue: widget.trial?.description,
      labelText: Trial.friendlyFieldNames[TrialFields.description],
      hintText: 'Describe what this trial is all about',
      requiredField: true,
      onChanged: _trialAddEditBloc.onDescriptionChanged,
      textInputAction: TextInputAction.next,
      currentFocusNode: descriptionNode,
      nextFocusNode: winCondNode,
    );
  }

  Widget _nameFormField() {
    return BasicStreamTextFormField(
      stream: _trialAddEditBloc.name,
      initialValue: widget.trial?.name,
      labelText: Trial.friendlyFieldNames[TrialFields.name],
      hintText: 'Name it something fun and distinct',
      requiredField: true,
      onChanged: _trialAddEditBloc.onNameChanged,
      textInputAction: TextInputAction.next,
      currentFocusNode: nameNode,
      nextFocusNode: descriptionNode,
    );
  }
}
