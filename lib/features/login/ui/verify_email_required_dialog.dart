import 'package:flutter/material.dart';

class VerifyEmailRequiredDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('You need to verify your email before logging in'),
      content: Text(
          'To ensure you are a real person with a real email address, you must verify your account.'),
      actions: <Widget>[
        FlatButton(
          child: Text("UGHH FINE"),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        )
      ],
    );
  }
}
