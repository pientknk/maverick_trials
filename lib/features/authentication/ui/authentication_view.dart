import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/authentication/bloc/auth.dart';
import 'package:maverick_trials/features/home/ui/home_view.dart';
import 'package:maverick_trials/features/login/ui/login_view.dart';
import 'package:maverick_trials/ui/views/splash_view.dart';

class AuthenticationView extends StatefulWidget {
  @override
  _AuthenticationViewState createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationInitialState) {
            return SplashView();
          }

          if (state is AuthenticationSuccessState) {
            print('Home View');
            return HomeView();
          }

          if (state is AuthenticationFailureState) {
            print(state);
            print('loginview');
            return LoginView();
          }

          return SplashView();
        },
    );
  }
}
