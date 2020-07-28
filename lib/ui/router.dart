import 'package:flutter/material.dart';
import 'package:maverick_trials/features/trial/add_edit/ui/trial_add_edit_view.dart';
import 'package:maverick_trials/ui/views/trial_detail_view.dart';
import 'package:maverick_trials/ui/widgets/main_scaffold.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MainScaffold());
      case addTrialRoute:
        return MaterialPageRoute(builder: (_) => TrialAddEditView());
      case trialDetailsRoute:
        return MaterialPageRoute(builder: (_) => TrialDetailView());
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
