import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_user_repository.dart';
import 'package:maverick_trials/features/app_init/bloc/app_init_bloc.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_bloc.dart';
import 'package:maverick_trials/features/login/bloc/login_bloc.dart';
import 'package:maverick_trials/features/login/bloc/login_event.dart';

class ApplicationInitializationView extends StatefulWidget {
  final FirebaseUserRepository userRepository;

  ApplicationInitializationView({@required this.userRepository});

  @override
  _ApplicationInitializationViewState createState() =>
      _ApplicationInitializationViewState();
}

class _ApplicationInitializationViewState
    extends State<ApplicationInitializationView> {
  ApplicationInitializationBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) {
        return LoginBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
        )..add(LoginInitialEvent());
      },
    );
    /*
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, ApplicationInitializationState state){
        if(state is ApplicationInitializationNotInitializedState){
          return SplashView();
        }

        if(state is ApplicationInitializationInitializingState){
          return basicProgressIndicator();
        }

        if(state is ApplicationInitializationInitializedState){
          return _appInitScreen();
        }

        if(state is ApplicationInitialization){

          // As we cannot directly redirect to the Home page inside the builder,
          // we use the WidgetsBinding.instance.addPostFrameCallback() method to
          // request Flutter to execute a method as soon as the rendering is complete
          WidgetsBinding.instance.addPostFrameCallback((_){
            Navigator.of(context).pushReplacementNamed('/home');
          });
        }
        else if(state is NotInitializedState){
          return Text('Not initialized... ${state.progress}%');
        }

        final InitializingState initializingState = state as InitializingState;
        return Text('Initializing... ${initializingState.progress}');
      },
    );

     */
  }

  @override
  void initState() {
    _bloc = ApplicationInitializationBloc();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }
}
