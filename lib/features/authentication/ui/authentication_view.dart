import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_bloc.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_event.dart';
import 'package:maverick_trials/features/authentication/bloc/auth_state.dart';

class AuthenticationView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Authentication'),
              leading: Container(),
            ),
            body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (BuildContext context, AuthenticationState state) {
                if (state is AuthenticationInitialState) {
                  Column(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            _usernameField(context),
                            _emailField(context),
                            _passwordField(context),
                            _confirmPasswordField(context),
                          ],
                        ),
                      ),
                      ListTile(
                        title: RaisedButton(
                          child: Text('Log in (Success)'),
                          onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context).add(
                                AuthenticationLoggedInEvent(name: 'Success'));
                          },
                        ),
                      ),
                      // Button to fake the authentication (failure)
                      ListTile(
                        title: RaisedButton(
                          child: Text('Log in (Failure)'),
                          onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context).add(
                                AuthenticationLoggedInEvent(name: "Failure"));
                          },
                        ),
                      )
                    ],
                  );
                  return Text("Not authenticated");
                } else if (state is AuthenticationInProgressState) {
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    backgroundColor: Colors.grey,
                    strokeWidth: 15.0,
                  );
                } else if (state is AuthenticationSuccessState) {
                  //Navigate to App Init view
                } else if (state is AuthenticationFailureState) {
                  return Text('Authentication Failed!');
                }

                return Text("Unknown Authentication State");
              },
            )),
      ),
    );
  }

  Widget _usernameField(BuildContext context) {
    return StreamBuilder<String>(
      stream: BlocProvider.of<AuthenticationBloc>(context).email,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Username',
            hintText: 'Something unique to identify yourself',
            errorText: snapshot.error,
          ),
          onChanged:
              BlocProvider.of<AuthenticationBloc>(context).onUsernameChanged,
          validator: BlocProvider.of<AuthenticationBloc>(context)
              .validateRequiredField,
        );
      },
    );
  }

  Widget _emailField(BuildContext context) {
    return StreamBuilder<String>(
      stream: BlocProvider.of<AuthenticationBloc>(context).email,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'example@gmail.com',
            errorText: snapshot.error,
          ),
          onChanged:
              BlocProvider.of<AuthenticationBloc>(context).onEmailChanged,
          validator: BlocProvider.of<AuthenticationBloc>(context)
              .validateRequiredField,
        );
      },
    );
  }

  Widget _passwordField(BuildContext context) {
    return StreamBuilder<String>(
      stream: BlocProvider.of<AuthenticationBloc>(context).password,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Phrases Are The Best Passwords',
            errorText: snapshot.error,
          ),
          onChanged:
              BlocProvider.of<AuthenticationBloc>(context).onPasswordChanged,
          validator: BlocProvider.of<AuthenticationBloc>(context)
              .validateRequiredField,
        );
      },
    );
  }

  Widget _confirmPasswordField(BuildContext context) {
    return StreamBuilder<String>(
      stream: BlocProvider.of<AuthenticationBloc>(context).confirmPassword,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            hintText: 'Enter your password again',
            errorText: snapshot.error,
          ),
          onChanged: BlocProvider.of<AuthenticationBloc>(context)
              .onConfirmPasswordChanged,
          validator: BlocProvider.of<AuthenticationBloc>(context)
              .validateRequiredField,
        );
      },
    );
  }

  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPop() async {
    return false;
  }
}
