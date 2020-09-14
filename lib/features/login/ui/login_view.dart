import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/repository/user_repository.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_bloc.dart';
import 'package:maverick_trials/features/login/bloc/login_bloc.dart';

import 'login_form.dart';

class LoginView extends StatelessWidget {
  final UserRepository userRepository;

  LoginView({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocProvider<LoginBloc>(
        create: (BuildContext context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(
          userRepository: userRepository,
        ),
      ),
    );
  }
}
