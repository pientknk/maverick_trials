import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_bloc.dart';
import 'package:maverick_trials/features/trial/add_edit/bloc/trial_add_edit_state.dart';
import 'package:maverick_trials/features/trial/add_edit/ui/trial_add_edit_form.dart';
import 'package:maverick_trials/ui/shared/loading_view.dart';

class TrialAddEditView extends StatefulWidget {
  final Trial trial;

  TrialAddEditView({@required this.trial});

  @override
  _TrialAddEditViewState createState() => _TrialAddEditViewState();
}

class _TrialAddEditViewState extends State<TrialAddEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBlocBuilder(),
    );
  }

  BlocBuilder _buildBlocBuilder() {
    return BlocBuilder(
      bloc: BlocProvider.of<TrialAddEditBloc>(context),
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            Container(
              child: TrialAddEditForm(trial: widget.trial),
            ),
            Align(
              alignment: Alignment.center,
              child: Visibility(
                child: LoadingView(),
                visible: state is StateLoading,
              ),
            )
          ],
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(widget.trial.name == null ? 'Trial Add' : 'Trial Details'),
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
