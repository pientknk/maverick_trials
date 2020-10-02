import 'package:flutter/material.dart';

class Constants {
  const Constants();

  static const String trialsCollection = "trials";
  static const int trialsSnapshotLimit = 2;
  static const String gamesCollection = "games";

  static BorderRadius circularBorderRadius = BorderRadius.circular(8.0);
  static ShapeBorder defaultRoundedRectangleShape = RoundedRectangleBorder(
    borderRadius: circularBorderRadius
  );
}
