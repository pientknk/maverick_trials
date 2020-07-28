import 'dart:async';

import 'package:flutter/foundation.dart';

class LengthValidator {
  StreamTransformer<String, String> validateLength({@required int max}) =>
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
        if (value.length > max) {
          sink.addError('Length must be less than $max');
        } else {
          sink.add(value);
        }
      });
}
