import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Text text;
  final Widget icon;
  final Color color;

  AppIconButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    @required this.icon,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
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
  final String text;
  final Color color;

  AppButton(
      {Key key,
      @required this.onPressed,
      @required this.text,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Text(text),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: onPressed,
          color: color,
        ),
      ),
    );
  }
}
