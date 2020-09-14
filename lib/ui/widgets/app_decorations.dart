import 'package:flutter/material.dart';

Gradient boxDecorationLinearGradient() => LinearGradient(
  colors: [
    Colors.lightBlueAccent,
    Colors.green,
    Colors.green,
    Colors.lightBlueAccent,
  ],
  stops: [0.0, 0.2, 0.8, 1.0],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);