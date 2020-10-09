import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/simple_bloc_delegate.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_bloc.dart';
import 'package:maverick_trials/features/authentication/ui/authentication_view.dart';
import 'package:maverick_trials/locator.dart';
import 'package:maverick_trials/ui/router.dart';
import 'package:maverick_trials/ui/widgets/theme/app_theme.dart';

import 'features/authentication/bloc/auth_event.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(App());
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
      child: BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) {
            return AuthenticationBloc()..add(AuthenticationStartedEvent());
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mav Trials',
          theme: appTheme.themeData,
          home: AuthenticationView(),
          onGenerateRoute: Router.generateRoute,
        ),
      ),
    );
  }
}
