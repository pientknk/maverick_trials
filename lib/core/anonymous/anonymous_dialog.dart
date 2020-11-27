import 'package:flutter/material.dart';

class AnonymousDialog extends StatefulWidget {
  @override
  _AnonymousDialogState createState() => _AnonymousDialogState();
}

class _AnonymousDialogState extends State<AnonymousDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("You've created an Anonymous Account!"),
      content: Text("This account is only temporary. It lets you see the app as well as "
        "do everything a normal account can. However, when you fully close "
        "the app or log out you will lose all your data. If you'd like to keep your data, you "
        "can create a full account anytime by going under the app drawer and selecting 'Create Account'"),
      actions: [
        FlatButton(
          child: Text('OK'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
