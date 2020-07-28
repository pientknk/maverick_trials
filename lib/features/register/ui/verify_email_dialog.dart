import 'package:flutter/material.dart';

class VerifyEmailDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Account created successfully!'),
      content: Text(
          'Please check your email and follow the provided link in order to verify your email address'),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ],
    );
  }
}
