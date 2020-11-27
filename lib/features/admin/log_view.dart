import 'package:flutter/material.dart';
import 'package:logger_flutter/logger_flutter.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';

class LogView extends StatefulWidget {
  @override
  _LogViewState createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: AppButton(text: 'View Logs',
            onPressed: (){
              MaterialPageRoute(builder: (_) => LogConsole(dark: true,));
            },
          ),
        ),
      ],
    );
  }
}
