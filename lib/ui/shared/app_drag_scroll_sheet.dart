import 'package:flutter/material.dart';

class AppDragScrollSheet extends StatefulWidget {
  AppDragScrollSheet({this.body, Key key})
      : assert(body != null),
        super(key: key);

  final Widget body;

  @override
  State<StatefulWidget> createState() => _AppDragScrollSheet();
}

class _AppDragScrollSheet extends State<AppDragScrollSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.25,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  color: Colors.teal[200],
                ),
                padding: const EdgeInsets.all(8.0),
                child: widget.body,
              ));
        });
  }
}
