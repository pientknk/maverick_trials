import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_bloc.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_event.dart';

///
/// OnPressed of this button will be handled by the AuthenticationBloc
/// which in turn will emit an AuthentiationState (isAuthenticated = false)
/// which will be handled by the DecisionPage via the BlocEventStateBuilder
/// which will redirect the user to the AuthenticationPage
///
class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text('LOGOUT'),
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationLoggedOutEvent());
          },
        ),
      ],
    );
  }
}
