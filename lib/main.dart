import 'package:catcher/catcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/auth/bloc/auth.dart';
import 'package:maverick_trials/features/auth/ui/auth_view.dart';
import 'package:maverick_trials/simple_bloc_delegate.dart';
import 'package:maverick_trials/locator.dart';
import 'package:maverick_trials/ui/router.dart';
import 'package:maverick_trials/ui/widgets/theme/app_theme.dart';
import 'package:maverick_trials/core/logging/catcher_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  CatcherConfig.standardCatcher(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme(isDark: true);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        //remove keyboard if its up and this doesn't work?
      },
      child: BlocProvider<AuthBloc>(
        create: (BuildContext context) {
          return AuthBloc()..add(AuthStartedEvent());
        },
        child: MaterialApp(
          navigatorKey: Catcher.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Mav Trials',
          theme: appTheme.themeData,
          home: AuthView(),
          onGenerateRoute: Router.generateRoute,
        ),
      ),
    );
  }
}
