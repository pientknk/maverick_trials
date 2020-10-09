import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';
import 'package:maverick_trials/utils/constants.dart';
import 'package:supercharged/supercharged.dart';

class AppSnackBar {
  /// typically an icon or loading indicator
  final Widget leading;

  ///created a snackbar button with the label and onpressed action
  final SnackBarAction action;
  final String text;
  final int durationInMs;
  /// determines the color theme of the snackbar, for example, AppSnackBarType.error will be red
  final AppSnackBarType appSnackBarType;

  AppSnackBar(
      {@required this.text,
      this.action,
      this.durationInMs = 2000,
      this.leading,
      this.appSnackBarType = AppSnackBarType.notification});

  SnackBar build() {
    return SnackBar(
      backgroundColor: _getBackgroundColorForBarType(),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: leading ?? Container(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: AccentThemeText(
                text: text,
                textAlign: TextAlign.center,
                isBold: true,
              ),
            ),
          ),
        ],
      ),
      duration: durationInMs.milliseconds,
      behavior: SnackBarBehavior.floating,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: Constants.circularBorderRadius,
      ),
      action: action,
    );
  }

  Color _getBackgroundColorForBarType() {
    switch(this.appSnackBarType){
      case AppSnackBarType.error:
        return Colors.red[400];
      case AppSnackBarType.notification:
        return null;
      case AppSnackBarType.success:
        return Colors.green[700];

    }

    return null;
}
}

enum AppSnackBarType {
  error,
  notification,
  success,
}
