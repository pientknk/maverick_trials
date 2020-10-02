import 'package:flutter/material.dart';
import 'package:maverick_trials/features/home/ui/home_view.dart';
import 'package:maverick_trials/features/trial/add_edit/ui/trial_add_edit_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeView());
      case addTrialRoute:
        return MaterialPageRoute(builder: (_) => TrialAddEditView());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          );
        });
    }
  }

  static const String homeRoute = '/';
  static const String addTrialRoute = '/addTrial';
  static const String trialDetailsRoute = '/trialDetails';
}
