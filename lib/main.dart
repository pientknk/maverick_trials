import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/base/simple_bloc_delegate.dart';
import 'package:maverick_trials/core/repository/user_repository.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_bloc.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_event.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_state.dart';
import 'package:maverick_trials/features/login/ui/login_view.dart';
import 'package:maverick_trials/locator.dart';
import 'package:maverick_trials/ui/router.dart';
import 'package:maverick_trials/ui/shared/app_loading_indicator.dart';
import 'package:maverick_trials/ui/views/splash_view.dart';
import 'package:maverick_trials/ui/widgets/main_scaffold.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final UserRepository userRepository = UserRepository();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (BuildContext context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStartedEvent());
    },
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          //remove keyboard if its up and this doesn't work?
        },
        child: MaterialApp(
          title: 'Mav Trials',
          theme: ThemeData(primarySwatch: Colors.green),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationInitialState) {
                return SplashView();
              }

              if (state is AuthenticationSuccessState) {
                print('mainscaffold');
                return MainScaffold();
              }

              if (state is AuthenticationFailureState) {
                print('loginview');
                return LoginView(
                  userRepository: userRepository,
                );
              }

              if (state is AuthenticationInProgressState) {
                return BasicProgressIndicator();
              }

              return SplashView();
            },
          ),
          onGenerateRoute: Router.generateRoute,
        ));
  }
}
