import 'package:flutter/material.dart';
import 'package:maverick_trials/base/diamond_border.dart';
import 'package:maverick_trials/core/theme/theme_colors.dart';
import 'package:maverick_trials/utils/constants.dart';

class AppTheme {
  bool isDark;

  AppTheme({@required this.isDark});

  ThemeData get themeData{
    Color eerieBlack = Color(0xff262525);
    Color jetGrey = Color(0xff403F40);
    Color davysGrey = Color(0xff5B585A);
    Color sonicSilver = Color(0xff6B7376);
    Color cadetGrey = Color(0xff5d737e);
    Color greenSheen = Color(0xff64b6ac);
    Color richBlack = Color(0xff000500);
    Color lincolnGreen = Color(0xff036016);
    Color carnelianRed = Color(0xffba2422);
    Color pigmentRed = Color(0xffEA2422);
    Color tartOrange = Color(0xffFF383D);

    ThemeData themeData = isDark ? ThemeData.dark() : ThemeData.light();
    Color bodyTextColor = themeData.textTheme.bodyText1.color;

    ColorScheme colorScheme = ColorScheme(
      brightness: themeData.brightness,
      primary: jetGrey,
      primaryVariant: richBlack,
      secondary: greenSheen,
      secondaryVariant: greenSheen,
      background: eerieBlack,
      surface: sonicSilver,
      onBackground: bodyTextColor,
      onSurface: bodyTextColor,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      error: pigmentRed,
    );

    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: Constants.circularBorderRadius,
    );

    InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
      isDense: true,
      filled: false,
      errorStyle: TextStyle(color: tartOrange),
      enabledBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(color: Colors.white, width: 1.0),
      ),
      errorBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(color: tartOrange, width: 1.0),
      ),
      focusedBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(color: greenSheen, width: 1.0),
      ),
      disabledBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(color: cadetGrey, width: 1.0),
      ),
      focusedErrorBorder: outlineInputBorder.copyWith(
        borderSide: BorderSide(color: tartOrange, width: 1.0),
      ),
    );

    DialogTheme dialogTheme = DialogTheme(
      backgroundColor: jetGrey,
      shape: Constants.defaultRoundedRectangleShape,
    );

    CardTheme cardTheme = CardTheme(
      color: jetGrey,
      elevation: 4.0,
      shadowColor: greenSheen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    );

    ButtonThemeData buttonThemeData = ButtonThemeData(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      colorScheme: colorScheme,
      buttonColor: greenSheen,
      disabledColor: sonicSilver,
      textTheme: ButtonTextTheme.primary,
    );

    IconThemeData iconTheme = IconThemeData(
      color: greenSheen,
      opacity: 0.9,
    );

    IconThemeData accentIconTheme = iconTheme.copyWith(color: Colors.white);

    BottomNavigationBarThemeData bottomNavigationBarThemeData = BottomNavigationBarThemeData(
      backgroundColor: jetGrey,
      selectedItemColor: greenSheen,
      unselectedItemColor: Colors.white,
      selectedIconTheme: iconTheme,
      unselectedIconTheme: accentIconTheme,
    );

    FloatingActionButtonThemeData fabThemeData = FloatingActionButtonThemeData(
      elevation: 3.0,
      backgroundColor: greenSheen,
      foregroundColor: richBlack,
      shape: const DiamondBorder(),
      //focusColor: Colors.blueAccent,
    );

    ThemeData appThemeData = ThemeData.from(
      colorScheme: colorScheme,
      textTheme: themeData.textTheme)
    .copyWith(
      buttonColor: greenSheen,
      disabledColor: sonicSilver,
      cursorColor: greenSheen,
      highlightColor: greenSheen,
      toggleableActiveColor: greenSheen,
      iconTheme: iconTheme,
      accentIconTheme: accentIconTheme,
      floatingActionButtonTheme: fabThemeData,
      dialogTheme: dialogTheme,
      cardTheme: cardTheme,
      buttonTheme: buttonThemeData,
      inputDecorationTheme: inputDecorationTheme,
      bottomNavigationBarTheme: bottomNavigationBarThemeData,
      primaryColorLight: jetGrey,
      primaryColorDark: greenSheen,
    );

    return appThemeData;
  }
}