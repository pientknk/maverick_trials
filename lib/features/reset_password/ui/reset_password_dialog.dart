import 'package:flutter/material.dart';

class ResetPasswordDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Password reset email sent!'),
      content: Text('If you do not receive an email within a few minutes, '
          'please check your spam folder or try resetting your password again'),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        )
      ],
    );
  }
}
