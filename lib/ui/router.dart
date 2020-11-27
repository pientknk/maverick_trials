import 'package:flutter/material.dart';
import 'package:maverick_trials/features/about/ui/about_view.dart';
import 'package:maverick_trials/features/admin/admin_view.dart';
import 'package:maverick_trials/features/career/ui/career_view.dart';
import 'package:maverick_trials/features/home/ui/home_view.dart';
import 'package:maverick_trials/features/intro/ui/intro_pager.dart';
import 'package:maverick_trials/features/register/ui/register_page.dart';
import 'package:maverick_trials/features/register/ui/request_nickname_view.dart';
import 'package:maverick_trials/features/reset_password/ui/reset_password_view.dart';
import 'package:maverick_trials/features/settings/ui/avatar_selection_view.dart';
import 'package:maverick_trials/features/settings/ui/settings_view.dart';
import 'package:maverick_trials/features/trial/add_edit/ui/trial_add_edit_view.dart';
import 'package:maverick_trials/features/user/ui/friends_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeView());
      case addTrialRoute:
        return MaterialPageRoute(builder: (_) => TrialAddEditView());
      case trialDetailsRoute:
        var trial = settings.arguments;
        return MaterialPageRoute(builder: (_) => TrialAddEditView(trial: trial));
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ResetPasswordView());
      case introRoute:
        return MaterialPageRoute(builder: (_) => IntroPager());
      case nicknameRoute:
        return MaterialPageRoute(builder: (_) => RequestNicknameView());
      case settingsRoute:
        var settingsBloc = settings.arguments;
        return MaterialPageRoute(builder: (_) => SettingsView(settingsBloc: settingsBloc,));
      case careerRoute:
        return MaterialPageRoute(builder: (_) => CareerView());
      case friendsRoute:
        return MaterialPageRoute(builder: (_) => FriendsView());
      case aboutRoute:
        return MaterialPageRoute(builder: (_) => AboutView());
      case adminRoute:
        return MaterialPageRoute(builder: (_) => AdminView());
      case avatarRoute:
        var settingsBloc = settings.arguments;
        return MaterialPageRoute(builder: (_) => AvatarSelectionView(settingsBloc: settingsBloc,));
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
  static const String trialDetailsRoute = '/trialDetail';
  static const String registerRoute = '/register';
  static const String resetPasswordRoute = '/resetPassword';
  static const String introRoute = '/intro';
  static const String nicknameRoute = '/nickname';
  static const String settingsRoute = '/settings';
  static const String careerRoute = '/career';
  static const String friendsRoute = '/friends';
  static const String aboutRoute = '/about';
  static const String adminRoute = '/admin';
  static const String avatarRoute = '/settings/avatar';
}
