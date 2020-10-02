import 'package:flutter/material.dart';
import 'package:maverick_trials/core/models/trial.dart';
import 'package:maverick_trials/features/trial/add_edit/ui/trial_add_edit_view.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';
import 'package:maverick_trials/utils/number_formatter.dart';

class TrialCard extends StatefulWidget {
  final Trial trial;

  TrialCard({Key key,
    @required this.trial,
  }) : super(key: key);

  @override
  _TrialCardState createState() => _TrialCardState();
}

class _TrialCardState extends State<TrialCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('card tapped');
        Navigator.push(context,
          MaterialPageRoute(
            builder: (BuildContext context) => TrialAddEditView(
              trial: widget.trial,
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: _namePart(),
              ),
              Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: _ratingPart(),
                    ),
                    Expanded(
                      child: _fairnessPart()
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: _favoritePart(),
                            flex: 5,
                          ),
                          Expanded(
                            child: _trialTypePart(),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baseContainer({Widget child}){
    return Container(
      //color: Colors.orangeAccent,
      //padding: const EdgeInsets.all(2),
      child: child,
    );
  }

  Widget _namePart(){
    return _baseContainer(
      child: Container(
        child: ImportantText(
          text: widget.trial.name,
        ),
      ),
    );
  }

  Widget _trialTypePart(){
    return _baseContainer(
      child: Container(
        //color: Colors.greenAccent,
        //padding: const EdgeInsets.only(left: 4, bottom: 4),
        child: Icon(widget.trial.trialType == 'Group'
            ? Icons.group_work
            : Icons.person,
          ),
      ),
    );
  }

  Widget _favoritePart(){
    return _baseContainer(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: GestureDetector(
                  child: Icon(Icons.favorite_border,),
                  onTap: (){
                    print('Favorite tapped');
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 4),
                child: Text(friendlyFormatNumber(4539901))
              )
            ],
          ),
      ),
    );
  }

  Widget _ratingPart(){
    return _baseContainer(
      child: Container(
        //padding: const EdgeInsets.only(left: 4),
        child: Text('Rating: 3.5',)
      ),
    );
  }

  Widget _fairnessPart(){
    return _baseContainer(
      child: Container(
        //padding: const EdgeInsets.only(left: 4),
        child: Text('Fairness: 4.6', textAlign: TextAlign.end,)
      ),
    );
  }

  /*
  Widget _commentsPart(){
    return _baseContainer(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.comment,
                  color: Colors.purple,
                ),
                onTap: (){

                },
              ),
              Container(
                padding: const EdgeInsets.only(left: 4),
                child: Text(friendlyFormatNumber(3000),
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
    );
  }

   */
}
