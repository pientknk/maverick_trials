import 'package:flutter/material.dart';

class Helpers{
  const Helpers();

  static void dismissKeyboard(BuildContext context) => FocusScope.of(context).unfocus();
}