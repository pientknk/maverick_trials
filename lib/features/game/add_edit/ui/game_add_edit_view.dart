import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/features/auth/bloc/auth.dart';
import 'package:maverick_trials/features/game/add_edit/bloc/game_add_edit.dart';
import 'package:maverick_trials/features/game/add_edit/ui/game_add_edit_form.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class GameAddEditView extends StatefulWidget {
  final Game game;

  GameAddEditView({Key key, this.game}) : super(key: key);

  @override
  _GameAddEditViewState createState() => _GameAddEditViewState();
}

class _GameAddEditViewState extends State<GameAddEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocProvider<GameAddEditBloc>(
        create: (BuildContext context){
          return GameAddEditBloc(
            authBloc: BlocProvider.of<AuthBloc>(context),
            game: widget.game,
          );
        },
        child: GameAddEditForm(game: widget.game),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: AccentThemeText(text: widget.game == null ? 'Game Add' : 'Game Details'),
      leading: IconButton(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
