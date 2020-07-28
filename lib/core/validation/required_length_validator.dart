import 'dart:async';

import 'package:flutter/foundation.dart';

class RequiredLengthValidator {
  StreamTransformer<String, String> validateRequiredLength(
          {@required int min, @required int max}) =>
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
        if (value.isEmpty) {
          sink.addError('Required Field');
        } else if (value.length < min || value.length > max) {
          sink.addError('Length must be between $min and $max');
        } else {
          sink.add(value);
        }
      });
}
