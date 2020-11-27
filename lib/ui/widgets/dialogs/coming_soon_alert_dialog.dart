import 'package:flutter/material.dart';

class ComingSoonAlertDialog extends StatefulWidget {
  @override
  _ComingSoonAlertDialogState createState() => _ComingSoonAlertDialogState();
}

class _ComingSoonAlertDialogState extends State<ComingSoonAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("OOPS"),
      content: Text("Whelp, it looks like this doesn't do anything yet. Try again after the next update."),
      actions: [
        FlatButton(
          child: Text('OK'),
          onPressed: (){
            Navigator.of(context).pop();
          }
        )
      ],
    );
  }
}
