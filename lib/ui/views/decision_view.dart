import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_bloc.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_state.dart';
import 'package:maverick_trials/features/authentication/ui/authentication_view.dart';
import 'package:maverick_trials/ui/widgets/main_scaffold.dart';

///
/// I want the application to automate the redirection to the AuthenticationPage
/// or to the HomePage, based on the authentication status.
///
class DecisionView extends StatefulWidget {
  @override
  _DecisionViewState createState() => _DecisionViewState();
}

class _DecisionViewState extends State<DecisionView> {
  AuthenticationState oldAuthenticationState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state != oldAuthenticationState) {
          oldAuthenticationState = state;

          if (state is AuthenticationSuccessState) {
            _redirectToPage(context, MainScaffold());
          } else if (state is AuthenticationInProgressState) {
          } else if (state is AuthenticationFailureState) {
          } else if (state is AuthenticationInitialState) {
            _redirectToPage(context, AuthenticationView());
          }
        }

        return Container();
      },
    );
  }

  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);

      Navigator.of(context)
          .pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
    });
  }
}
