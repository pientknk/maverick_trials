import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:maverick_trials/core/logging/app_report_mode.dart';
import 'package:maverick_trials/core/services/sentry_dsn.dart';
import 'package:sentry/sentry.dart';

class CatcherConfig {
  static Catcher standardCatcher(Widget rootWidget) {
    //release configuration
    CatcherOptions releaseOptions = CatcherOptions(AppReportMode(), [
      ConsoleHandler(),
      SentryHandler(SentryClient(
        dsn: sentryDSN,
        environmentAttributes: const Event(
          environment: 'PROD',
          release: 'MaverickTrials@0.0.1',
        ))
      )
    ]);

    //debug configuration
    CatcherOptions debugOptions = CatcherOptions(AppReportMode(), [
      ConsoleHandler(),
      SentryHandler(SentryClient(
          dsn: sentryDSN,
          environmentAttributes: const Event(
            environment: 'PROD',
            release: 'MaverickTrials.0.0.1',
          ),
        ),
      ),
    ]);

    //profile configuration
    CatcherOptions profileOptions = CatcherOptions(
      DialogReportMode(),
      [ConsoleHandler(), ToastHandler()],
      handlerTimeout: 5000,
      customParameters: {"example": "example_parameter"},
    );

    return Catcher(rootWidget,
        debugConfig: debugOptions,
        releaseConfig: releaseOptions,
        profileConfig: profileOptions);
  }
}
