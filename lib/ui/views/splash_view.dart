import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ImportantText('Maverick Trials'),
      ),
    );
  }
}
