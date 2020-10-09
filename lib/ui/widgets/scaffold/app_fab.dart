import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maverick_trials/features/trial/add_edit/ui/trial_add_edit_view.dart';

class AppFab extends StatefulWidget {
  AppFab({Key key}) : super(key: key);

  @override
  _AppFabState createState() => _AppFabState();
}

class _AppFabState extends State<AppFab> with SingleTickerProviderStateMixin {
  final int durationMS = 500;
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateRotation;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeInOutSine;
  double _fabHeight = 55.0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationMS),
    )..addListener(() {
        setState(() {});
      });

    _animateRotation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_animationController);

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.75, curve: _curve),
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buttonColor = ColorTween(
      begin: Theme.of(context).primaryColor,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.00, 1.00, curve: Curves.linear),
    )
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _buildColumnWidgets(),
    );
  }

  List<FloatingActionButton> getFABs(){
    return [
      FloatingActionButton(
        //shape: const DiamondBorder(),
        heroTag: 'AddTrial',
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrialAddEditView(),
                )
              );
        },
        tooltip: 'Add Trial',
        child: Icon(Icons.text_fields),
      ),
      FloatingActionButton(
        //shape: const DiamondBorder(),
        heroTag: 'AddGame',
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          /*Navigator.push(
                context,
                MaterialPageRoute(
                  //builder: (context) => GameAddView(),
                )
              );

               */
        },
        tooltip: 'Add Game',
        child: Icon(Icons.games),
      ),
    ];
  }

  List<Widget> _buildColumnWidgets() {
    List<Widget> widgets = List<Widget>();
    List<FloatingActionButton> fabs = getFABs();
    int length = fabs.length;

    fabs.forEach((fab) {
      widgets.add(Transform(
        transform: Matrix4.translationValues(
            0.0, _translateButton.value * length--, 0.0),
        child: fab,
      ));
    });

    widgets.add(togglingFab());

    return widgets;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    isOpened = !isOpened;
  }

  Widget togglingFab() {
    return FloatingActionButton(
      //shape: const DiamondBorder(),
      backgroundColor: _buttonColor.value,
      onPressed: (){
        if(isOpened){
          print('eventually this should nav to game start screen');
          /*Navigator.push(
                context,
                MaterialPageRoute(
                  //builder: (context) => GamePlayView(),
                )
              );

               */
        }
        animate();
      },
      child: Transform.rotate(
        angle: _animateRotation.value,
        child: AnimatedCrossFade(
          duration: Duration(milliseconds: durationMS),
          crossFadeState: !isOpened
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
          firstChild: Icon(Icons.menu,
            key: UniqueKey()),
          secondChild: Icon(Icons.play_arrow,
            key: UniqueKey()),
          firstCurve: _curve,
          secondCurve: _curve,
        ),
      ),
    );
  }
}
