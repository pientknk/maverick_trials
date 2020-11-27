import 'package:flutter/material.dart';

/// Wrap any widget with this wrapper and give it a status
/// to determine how it will display in the app, this is useful
/// for hiding widgets without commenting out code
class WidgetWrapper extends StatelessWidget {
  final Widget child;
  final WidgetStatus widgetStatus;

  WidgetWrapper({this.child, this.widgetStatus});

  @override
  Widget build(BuildContext context) {
    switch(widgetStatus){
      case WidgetStatus.implementing:
        return Visibility(
          visible: false,
          child: child,
        );
      case WidgetStatus.testing:
      case WidgetStatus.completed:
        return child;
      default:
        return child;
    }
  }

}

enum WidgetStatus { implementing, testing, completed }