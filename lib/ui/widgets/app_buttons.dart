import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/app_decorations.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget text;
  final Widget icon;
  final Color color;

  AppIconButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    @required this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton.icon(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          onPressed: onPressed,
          label: text,
          icon: icon,
          color: color,
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget text;
  final Color color;

  AppButton(
      {Key key,
      @required this.onPressed,
      @required this.text,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: text,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          onPressed: onPressed,
          color: color,
        ),
      ),
    );
  }
}

class AppCustomButton extends StatelessWidget {
  AppCustomButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      padding:
          const EdgeInsets.all(0.0), //set to 0 or else child gets padded in
      child: Ink(
        decoration: BoxDecoration(
          gradient: boxDecorationLinearGradient(),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Container(
          //min sizes for material buttons
          constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
          alignment: Alignment.center,
          child: Text('TESTING'),
        ),
      ),
      onPressed: () {},
    );
  }
}
