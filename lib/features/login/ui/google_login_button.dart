import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maverick_trials/features/login/bloc/login.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            BlocProvider.of<LoginBloc>(context).add(
              LoginWithGooglePressedEvent(),
            );
          },
          icon: Icon(
            FontAwesomeIcons.google,
            color: Colors.white,
          ),
          label: Text(
            'Sign in with Google',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
