import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/ui/shared/app_bottom_sheet.dart';

class GameDetailView extends StatefulWidget {
  GameDetailView({Key key, this.game})
      : assert(game != null),
        super(key: key);

  final Game game;

  @override
  State<StatefulWidget> createState() => _GameDetailViewState();
}

class _GameDetailViewState extends State<GameDetailView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool isEditable = false;
  Game game;

  @override
  void initState() {
    game = widget.game;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: _buildDetails(),
      ),
    );
  }

  List<Widget> _getMoreOptionsList() {
    return [];
  }

  Widget _buildDetails() {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              enabled: isEditable,
              initialValue: game.name,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Trial Boss Option',
              ),
              enabled: isEditable,
              initialValue: game.trialBossOption,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Created Time',
              ),
              enabled: isEditable,
              initialValue: game.createdTime.toString(),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Created By',
              ),
              enabled: isEditable,
              initialValue: game.creatorUserCareerID,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Number of players',
              ),
              enabled: isEditable,
              initialValue: game.gameUserCount.toString(),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Rating',
              ),
              enabled: isEditable,
              initialValue: game.ratingID,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Trials',
              ),
              enabled: isEditable,
              initialValue: game.trialIDs.toString(),
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
                        leading: Icon(Icons.text_fields),
                        title: Row(
                          children: <Widget>[
                            Expanded(child: Text('Game Runs')),
                            Chip(
                              backgroundColor: Colors.green,
                              label: Text(game.gameRunCount.toString(),
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
                        leading: Icon(Icons.text_fields),
                        title: Row(
                          children: <Widget>[
                            Expanded(child: Text('Trials for this game')),
                            Chip(
                              backgroundColor: Colors.green,
                              label: Text(game.trialCount.toString(),
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
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Game Details'),
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
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.more_vert,
            size: 25.0,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: _scaffoldKey.currentContext,
              builder: (builder) {
                return AppBottomSheet(
                  listItems: _getMoreOptionsList().reversed.toList(),
                );
              },
              backgroundColor: Colors.transparent,
            );
          },
        )
      ],
    );
  }
}
