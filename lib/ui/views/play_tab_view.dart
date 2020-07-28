import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayTabView extends StatefulWidget {
  PlayTabView(this.index, this.hasActiveGame, {Key key}) : super(key: key);

  final bool hasActiveGame;
  final int index;

  @override
  State<StatefulWidget> createState() =>
      _PlayTabViewState(index, hasActiveGame);
}

class _PlayTabViewState extends State<PlayTabView> {
  int _index;
  bool hasActiveGame;

  _PlayTabViewState(this._index, this.hasActiveGame);

  @override
  Widget build(BuildContext context) {
    return hasActiveGame
        ? _buildActiveGameView(_index)
        : _buildNoActiveGameView();
  }

  Widget _buildActiveGameView(int index) {
    return Text("Active Game view for index $_index");
  }

  Widget _buildNoActiveGameView() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Text(
                "Looks like you don't have a game running. Get started by finding a game and playing!"),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                    onPressed: () {
                      //navigate to Home tab with filter set to games
                    },
                    child: Text("Find Games")),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  onPressed: () {
                    //navigate to Explore tab with filter set to games
                  },
                  child: Text("My Games"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
