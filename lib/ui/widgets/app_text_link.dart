import 'package:flutter/material.dart';

class AppTextLink extends StatelessWidget {
  ///Alignment of the text - defaults to Alignment.center
  final Alignment alignment;
  final VoidCallback onTap;
  final String label;

  AppTextLink({@required this.onTap, @required this.label,
    this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: InkWell(
          child: Text(label,
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
