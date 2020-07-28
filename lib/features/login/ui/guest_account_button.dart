import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maverick_trials/features/login/bloc/login.dart';

class GuestAccountButton extends StatelessWidget {
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
            BlocProvider.of<LoginBloc>(context)
                .add(AnonymousAccountPressedEvent());
          },
          label: Text(
            'Create Guest Account',
            style: TextStyle(color: Colors.white),
          ),
          icon: FaIcon(
            FontAwesomeIcons.userNinja,
            color: Colors.white,
          ),
          color: Colors.black,
        ),
      ),
    );
  }
}
