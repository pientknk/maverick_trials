import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/core/repository/trial_repository.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_bloc.dart';
import 'package:maverick_trials/features/trial/add_edit/ui/trial_add_edit_form.dart';

class TrialAddEditView extends StatefulWidget {
  final Trial trial;

  TrialAddEditView({@required this.trial});

  @override
  _TrialAddEditViewState createState() => _TrialAddEditViewState();
}

class _TrialAddEditViewState extends State<TrialAddEditView> {
  @override
  Widget build(BuildContext context) {
    final TrialRepository trialRepository = TrialRepository();

    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocProvider<TrialAddEditBloc>(
        create: (BuildContext context){
          return TrialAddEditBloc(
            trialRepository: trialRepository,
          );
        },
        child: TrialAddEditForm(trial: widget.trial),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(widget.trial == null ? 'Trial Add' : 'Trial Details'),
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
}
