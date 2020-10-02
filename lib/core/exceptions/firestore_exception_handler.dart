import 'package:flutter/services.dart';

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
        return 'Error: $code';
        break;
    }
  }

  static String tryGetPlatformExceptionMessage(dynamic error){
    print('FirestoreExceptionHandler: ${error.toString()}');
    if(error is PlatformException){

      if(error.details != null){
        return error.details;
      }
      else{
        return _getFriendlyErrorMsgForCode(error.code);
      }
    }
    else{
      print(error.toString());
      return 'An Unknown error occurred.';
    }
  }
}