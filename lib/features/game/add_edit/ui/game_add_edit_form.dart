import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/features/game/add_edit/bloc/game_add_edit.dart';
import 'package:maverick_trials/ui/widgets/theme/theme_icons.dart';

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
          return Scrollbar(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16.0),
              children: [
                Form(
                  key: formKey,
                  child: Container(
                    color: Colors.white70,
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                          initialValue: widget.game.name,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Trial Boss Option',
                          ),
                          initialValue: widget.game.trialBossOption,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Created Time',
                          ),
                          initialValue: widget.game.createdTime.toString(),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Created By',
                          ),
                          initialValue: widget.game.creatorUserCareerID,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Number of players',
                          ),
                          initialValue: widget.game.gameUserCount.toString(),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Rating',
                          ),
                          initialValue: widget.game.ratingID,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Trials',
                          ),
                          initialValue: widget.game.trialIDs.toString(),
                        ),
                        Column(
                          children: <Widget>[
                            Material(
                              color: Colors.green[100],
                              child: Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    //TODO: navigate to Game Runs with this gameID?
                                  },
                                  child: ListTile(
                                    leading: ThemeIcons.gamesIcon,
                                    title: Row(
                                      children: <Widget>[
                                        Expanded(child: Text('Game Runs')),
                                        Chip(
                                          backgroundColor: Colors.green,
                                          label: Text(widget.game.gameRunCount.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            )),
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Material(
                              color: Colors.green[100],
                              child: Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    //TODO: navigate to Trial Runs with this trialID?
                                  },
                                  child: ListTile(
                                    leading: ThemeIcons.trialsIcon,
                                    title: Row(
                                      children: <Widget>[
                                        Expanded(child: Text('Trials for this game')),
                                        Chip(
                                          backgroundColor: Colors.green,
                                          label: Text(widget.game.trialCount.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            )),
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(Icons.arrow_forward),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
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
