import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maverick_trials/core/models/game.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';
import 'package:maverick_trials/utils/number_formatter.dart';

class GameCard extends StatefulWidget {
  final Game game;

  GameCard({Key key, @required this.game}) : super(key: key);

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('game card tapped');
        /*
        Navigator.push(context,
          MaterialPageRoute(
            builder: (BuildContext context) => GameAddEditView(
              game: widget.game,
            ),
          ),
        );

         */
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Theme.of(context).primaryColor,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _namePart(),
              _ratingPart(),
              _fairnessPart(),
              _gameRunsPart(),
              _trialCountPart(),
              _playersPart(),
              _trialBossTypePart(),
              _creatorPart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baseContainer({Widget child}){
    return Container(
      color: Colors.orangeAccent,
      padding: const EdgeInsets.all(4),
      child: child,
    );
  }

  Widget _namePart(){
    return _baseContainer(
      child: ImportantText(widget.game.name,
        textColor: Colors.white,
      ),
    );
  }

  Widget _trialCountPart(){
    return _baseContainer(
      child: Text('Trials: ${widget.game.trialCount}',
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _creatorPart(){
    return _baseContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FaIcon(
            FontAwesomeIcons.pencilRuler,
            color: Colors.white,
          ),
          Text(widget.game.creatorUserCareerID,
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _ratingPart(){
    return _baseContainer(
      child: Text('Rating: 4.1',
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _fairnessPart(){
    return _baseContainer(
      child: Text('Fairness: 4.6',
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _trialBossTypePart(){
    return _baseContainer(
      child: FaIcon(FontAwesomeIcons.random,
        color: Colors.white,
      ),
    );
  }

  Widget _gameRunsPart(){
    return _baseContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FaIcon(FontAwesomeIcons.solidPlayCircle,
            color: Colors.white,
          ),
          Text(friendlyFormatNumber(1300),
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
        ],
      )
    );
  }

  Widget _playersPart(){
    return _baseContainer(
      child: Text('3-6 Players',
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
      ),
    );
  }
}
