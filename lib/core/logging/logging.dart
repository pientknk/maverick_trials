import 'package:logger/logger.dart';

class Logging {
  //call LogConsole.open(context) to view logs in app
  final Logger _logger = Logger(
    printer: SimplePrinter(printTime: true),
  );

  final Logger _prettyLogger = Logger(
    printer: PrettyPrinter(
      printTime: true,
      errorMethodCount: 4,
      methodCount: 4,
    ),
  );

  Logging({Level level = Level.verbose}){
    Logger.level = level;
  }

  void logPretty(LogLevel logLevel, String errorMsg, [dynamic error, StackTrace stackTrace]){
    switch(logLevel){
      case LogLevel.verbose:
        _prettyLogger.v(errorMsg, error, stackTrace);
        break;
      case LogLevel.debug:
        _prettyLogger.d(errorMsg, error, stackTrace);
        break;
      case LogLevel.info:
        _prettyLogger.i(errorMsg, error, stackTrace);
        break;
      case LogLevel.warning:
        _prettyLogger.w(errorMsg, error, stackTrace);
        break;
      case LogLevel.error:
        _prettyLogger.e(errorMsg, error, stackTrace);
        break;
      default:
        _prettyLogger.d('Logging Level \'$logLevel\' not supported at this time.');
        break;
    }
  }

  void logSimple(LogLevel logLevel, String errorMsg, [dynamic error, StackTrace stackTrace]){
    switch(logLevel){
      case LogLevel.verbose:
        _logger.v(errorMsg, error, stackTrace);
        break;
      case LogLevel.debug:
        _logger.d(errorMsg, error, stackTrace);
        break;
      case LogLevel.info:
        _logger.i(errorMsg, error, stackTrace);
        break;
      case LogLevel.warning:
        _logger.w(errorMsg, error, stackTrace);
        break;
      case LogLevel.error:
        _logger.e(errorMsg, error, stackTrace);
        break;
      default:
        _logger.d('Logging Level \'$logLevel\' not supported at this time.');
        break;
    }
  }

  void log(LogType logType, logLevel, String errorMsg, [dynamic error, StackTrace stackTrace]){
    switch (logType) {
      case LogType.pretty:
        logPretty(logLevel, errorMsg, error, stackTrace);
        break;
      case LogType.simple:
        logSimple(logLevel, errorMsg, error, stackTrace);
        break;
    }
  }
}

enum LogLevel { verbose, debug, info, warning, error }

enum LogType { pretty, simple }