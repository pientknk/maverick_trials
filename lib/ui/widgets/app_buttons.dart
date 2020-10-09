import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/app_decorations.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Widget icon;
  final Color color;
  final bool isBold;

  AppIconButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    @required this.icon,
    this.isBold,
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
          label: ButtonThemeText(text, isBold: isBold,),
          icon: icon,
          color: color,
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isBold;
  final Color color;

  AppButton(
      {Key key,
      @required this.onPressed,
      @required this.text,
        this.isBold,
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
          child: ButtonThemeText(text, isBold: isBold,),
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
