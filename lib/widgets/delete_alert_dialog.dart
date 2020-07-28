import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatefulWidget {
  final String title;
  final String details;
  final GestureTapCallback onDelete;

  DeleteAlertDialog(
      {Key key,
      @required this.title,
      @required this.details,
      @required this.onDelete});

  @override
  _DeleteAlertDialogState createState() => _DeleteAlertDialogState();
}

class _DeleteAlertDialogState extends State<DeleteAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.details),
      actions: <Widget>[
        FlatButton(
          child: Text("DELETE"),
          onPressed: widget.onDelete,
        ),
        FlatButton(
          child: Text("CANCEL"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
