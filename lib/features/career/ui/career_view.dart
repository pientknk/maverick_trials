import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class CareerView extends StatefulWidget {
  @override
  _CareerViewState createState() => _CareerViewState();
}

class _CareerViewState extends State<CareerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Career'),
      ),
      body: Center(
        child: ImportantText('Coming Soon...'),
      ),
    );
  }
}
