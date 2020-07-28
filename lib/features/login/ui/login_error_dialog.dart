import 'package:flutter/material.dart';

class LoginErrorDialog extends StatelessWidget {
  final String errorMsg;

  LoginErrorDialog({@required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('An error occurred while trying to log in'),
      content: Text(errorMsg),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
        FlatButton(
          child: Text("REPORT"),
          //TODO: navigate to a report issue screen where they can send an email?
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        )
      ],
    );
  }
}
