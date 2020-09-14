import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/features/game/add_edit/bloc/game_add_edit.dart';

class GameAddEditForm extends StatefulWidget {
  final Game game;

  GameAddEditForm({Key key, @required this.game}) : super(key: key);

  @override
  _GameAddEditFormState createState() => _GameAddEditFormState();
}

class _GameAddEditFormState extends State<GameAddEditForm> {
  final formKey = GlobalKey<FormState>();
  GameAddEditBloc _gameAddEditBloc;
  FocusNode nameNode;
  FocusNode descriptionNode;
  FocusNode trialBossOptionNode;

  @override
  void initState() {
    _gameAddEditBloc = BlocProvider.of<GameAddEditBloc>(context);
    nameNode = FocusNode();
    descriptionNode = FocusNode();
    trialBossOptionNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _gameAddEditBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameAddEditBloc, GameAddEditState>(
      bloc: _gameAddEditBloc,
      listener: (context, state){

      },
      child: BlocBuilder<GameAddEditBloc, GameAddEditState>(
        builder: (BuildContext context, GameAddEditState state){
          return Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        children: <Widget>[

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
