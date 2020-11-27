import 'package:flutter/services.dart';
import 'package:maverick_trials/core/logging/logging.dart';
import 'package:maverick_trials/locator.dart';

class FirestoreExceptionHandler {
  const FirestoreExceptionHandler();

  static String _getFriendlyErrorMsgForCode(String code){
    switch (code) {
      case 'ERROR_INVALID_EMAIL':
      case 'ERROR_WRONG_PASSWORD':
      case 'ERROR_USER_NOT_FOUND':
        return 'Invalid email and or Password';
        break;
      case 'ERROR_USER_DISABLED':
        return 'Please try again later';
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        return 'You have entered too many incorrect email/password combinations. Try again later';
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        return 'Login via email and password is currently not allowed';
        break;
      case 'ERROR_LOGIN_GOOGLE':
        return 'Unable to log in using Google';
        break;
      case 'ERROR_NETWORK_REQUEST_FAILED':
        return 'No internet connection found';
      default:
        return null;
        break;
    }
  }

  static String tryGetMessage(dynamic error, StackTrace stackTrace){
    if(error is PlatformException){
        String message = _getFriendlyErrorMsgForCode(error.code);
        if(message == null){
          message = error?.details ?? 'Unknown Error';
          locator<Logging>().log(LogType.pretty, LogLevel.error, message, error, stackTrace);
        }
        else{
          locator<Logging>().log(LogType.pretty, LogLevel.warning, message, error, stackTrace);
        }

        return message;
    }
    else{
      locator<Logging>().log(LogType.pretty, LogLevel.error, 'Unknown Error in FirestoreExceptionHandler', error, stackTrace);
      return error.toString();
    }
  }
}