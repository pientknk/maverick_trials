import 'package:flutter/material.dart';
import 'package:maverick_trials/ui/widgets/diamond_border.dart';
import 'package:maverick_trials/ui/widgets/theme/theme_colors.dart';
import 'package:maverick_trials/utils/constants.dart';

class AppTheme {
  bool isDark;

  AppTheme({@required this.isDark});

  ThemeData get themeData{
    ThemeData themeData = isDark ? ThemeData.dark() : ThemeData.light();
    Color bodyTextColor = themeData.textTheme.bodyText1.color;

    ColorScheme colorScheme = ColorScheme(
      brightness: themeData.brightness,
      primary: ThemeColors.jetGrey,
      primaryVariant: ThemeColors.richBlack,
      secondary: ThemeColors.greenSheen,
      secondaryVariant: ThemeColors.greenSheen,
      background: ThemeColors.eerieBlack,
      surface: ThemeColors.sonicSilver,
      onBackground: bodyTextColor,
      onSurface: bodyTextColor,
      onError: ThemeColors.accentColor,
      onPrimary: ThemeColors.accentColor,
      onSecondary: ThemeColors.accentColor,
      error: ThemeColors.pigmentRed,
    );

    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: Constants.circularBorderRadius,
    );

    InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      isDense: true,
      filled: false,
      errorStyle: TextStyle(color: ThemeColors.tartOrange),
      enabledBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(color: ThemeColors.accentColor, width: 1.0),
      ),
      errorBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(color: ThemeColors.tartOrange, width: 1.0),
      ),
      focusedBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(color: ThemeColors.greenSheen, width: 1.0),
      ),
      disabledBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(color: ThemeColors.cadetGrey, width: 1.0),
      ),
      focusedErrorBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(color: ThemeColors.tartOrange, width: 1.0),
      ),
    );

    DialogTheme dialogTheme = DialogTheme(
      backgroundColor: ThemeColors.jetGrey,
      shape: Constants.defaultRoundedRectangleShape,
    );

    CardTheme cardTheme = CardTheme(
      color: ThemeColors.jetGrey,
      elevation: 4.0,
      shadowColor: ThemeColors.greenSheen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    );

    ButtonThemeData buttonThemeData = ButtonThemeData(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      colorScheme: colorScheme,
      buttonColor: ThemeColors.greenSheen,
      disabledColor: ThemeColors.sonicSilver,
      textTheme: ButtonTextTheme.primary,
    );

    IconThemeData iconTheme = IconThemeData(
      color: ThemeColors.greenSheen,
      opacity: 0.9,
    );

    IconThemeData accentIconTheme = iconTheme.copyWith(color: ThemeColors.accentColor);

    AppBarTheme appBarTheme = AppBarTheme(
      elevation: 4.0,
      iconTheme: iconTheme,
      shadowColor: ThemeColors.jetGrey,
      actionsIconTheme: accentIconTheme,
    );

    BottomAppBarTheme bottomAppBarTheme = BottomAppBarTheme(
      color: ThemeColors.eerieBlack,
      elevation: 0.0,
    );

    BottomNavigationBarThemeData bottomNavigationBarThemeData = BottomNavigationBarThemeData(
      backgroundColor: ThemeColors.jetGrey,
      selectedItemColor: ThemeColors.greenSheen,
      unselectedItemColor: ThemeColors.accentColor,
      selectedIconTheme: iconTheme,
      unselectedIconTheme: accentIconTheme,
    );

    FloatingActionButtonThemeData fabThemeData = FloatingActionButtonThemeData(
      elevation: 3.0,
      backgroundColor: ThemeColors.greenSheen,
      foregroundColor: ThemeColors.richBlack,
      shape: const DiamondBorder(),
      //focusColor: Colors.blueAccent,
    );

    ThemeData appThemeData = ThemeData.from(
      colorScheme: colorScheme,
      textTheme: themeData.textTheme)
    .copyWith(
      accentColor: ThemeColors.greenSheen,
      buttonColor: ThemeColors.greenSheen,
      disabledColor: ThemeColors.sonicSilver,
      cursorColor: ThemeColors.greenSheen,
      highlightColor: ThemeColors.greenSheen,
      toggleableActiveColor: ThemeColors.greenSheen,
      iconTheme: iconTheme,
      accentIconTheme: accentIconTheme,
      floatingActionButtonTheme: fabThemeData,
      dialogTheme: dialogTheme,
      cardTheme: cardTheme,
      buttonTheme: buttonThemeData,
      inputDecorationTheme: inputDecorationTheme,
      bottomNavigationBarTheme: bottomNavigationBarThemeData,
      appBarTheme: appBarTheme,
      bottomAppBarTheme: bottomAppBarTheme,
      primaryColorLight: ThemeColors.jetGrey,
      primaryColorDark: ThemeColors.greenSheen,
      scaffoldBackgroundColor: ThemeColors.eerieBlack,
    );

    return appThemeData;
  }
}