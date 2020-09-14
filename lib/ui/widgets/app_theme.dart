import 'package:flutter/material.dart';

class AppTheme {
  Color backgroundColor;
  Color accentColor;
  bool isDark;

  AppTheme({@required this.isDark});

  ThemeData get themeData{
    ThemeData themeData = isDark ? ThemeData.dark() : ThemeData.light();
    Color bodyTextColor = themeData.textTheme.bodyText1.color;
    ColorScheme colorScheme = ColorScheme(
      brightness: themeData.brightness,
      primary: accentColor,
      primaryVariant: accentColor,
      secondary: accentColor,
      secondaryVariant: accentColor,
      background: backgroundColor,
      surface: Colors.grey[800],
      onBackground: bodyTextColor,
      onSurface: bodyTextColor,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      error: Colors.red[400],
    );

    //Setting this causes problems with FloatingActionButtons theme
    //Warning: The support for configuring the foreground color of FloatingActionButtons
    // using ThemeData.accentIconTheme has been deprecated. Please use
    // ThemeData.floatingActionButtonTheme instead.
    IconThemeData iconTheme = IconThemeData(
      color: Colors.grey[400],
      opacity: 0.9,
    );

    FloatingActionButtonThemeData fabThemeData = FloatingActionButtonThemeData(
      elevation: 3.0,
      backgroundColor: Colors.grey,
      foregroundColor: Colors.white,
      focusColor: Colors.blueAccent,
    );

    ThemeData appThemeData = ThemeData.from(
      colorScheme: colorScheme,
      textTheme: themeData.textTheme)
    .copyWith(
      buttonColor: accentColor,
      cursorColor: accentColor,
      highlightColor: accentColor,
      toggleableActiveColor: accentColor,
      accentIconTheme: iconTheme,
      floatingActionButtonTheme: fabThemeData,
    );

    return appThemeData;
  }
}