import 'package:flutter/material.dart';

class BasicProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      backgroundColor: Colors.grey,
      strokeWidth: 15.0,
    );
  }
}
