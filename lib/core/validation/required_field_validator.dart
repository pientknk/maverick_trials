import 'dart:async';

class RequiredFieldValidator {
  final StreamTransformer<String, String> validateRequiredFieldStream =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isEmpty) {
      sink.addError('Required Field');
    } else {
      sink.add(value);
    }
  });

  Function(String) get validateRequiredField => _requiredFieldValidator;

  String _requiredFieldValidator(String value) {
    if (value.isEmpty) {
      return 'Required Field';
    }

    return null;
  }
}
