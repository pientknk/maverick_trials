import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class ComingSoonBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ImportantText('This feature is coming soon!', fontSize: 24,),
      ),
    );
  }
}
