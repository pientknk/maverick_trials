import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/auth/auth_login_type.dart';
import 'package:maverick_trials/features/auth/bloc/auth.dart';
import 'package:maverick_trials/features/home/ui/home_view.dart';
import 'package:maverick_trials/features/intro/ui/intro_pager.dart';
import 'package:maverick_trials/features/login/ui/login_view.dart';
import 'package:maverick_trials/features/register/ui/request_nickname_view.dart';
import 'package:maverick_trials/ui/views/splash_view.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
          if (state is AuthInitialState) {
            return SplashView();
          }

          if (state is AuthSuccessState) {
            // i think the switch here causes problems with routing views
            switch(state.authLoginType){
              case AuthLoginType.success:
                return HomeView();
              case AuthLoginType.requestNickname:
                return RequestNicknameView();
              case AuthLoginType.requestIntro:
                return IntroPager();
                break;
              default:
                print('Error: Unknown AuthLoginType Type: ${state.authLoginType}');
                return HomeView();
                break;
            }
          }

          if (state is AuthFailureState) {
            return LoginView();
          }

          return SplashView();
        },
    );
  }
}
