import 'package:flutter/material.dart';

class AppFab extends StatefulWidget {
  final List<FloatingActionButton> fabs;

  AppFab({Key key, @required this.fabs}) : super(key: key);

  @override
  _AppFabState createState() => _AppFabState();
}

class _AppFabState extends State<AppFab> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 55.0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });

    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _buttonColor = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.00, 1.00, curve: Curves.linear)));

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _buildColumnWidgets(),
    );
  }

  List<Widget> _buildColumnWidgets() {
    List<Widget> widgets = List<Widget>();
    int length = widget.fabs.length;

    widget.fabs.forEach((fab) {
      widgets.add(Transform(
        transform: Matrix4.translationValues(
            0.0, _translateButton.value * length--, 0.0),
        child: fab,
      ));
    });

    widgets.add(toggle());

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

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _buttonColor.value,
      onPressed: animate,
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }
}
