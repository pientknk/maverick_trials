import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/repository/user/firebase_user_repository.dart';
import 'package:maverick_trials/features/reset_password/bloc/reset_password.dart';
import 'package:maverick_trials/features/reset_password/ui/reset_password_form.dart';

class ResetPasswordView extends StatelessWidget {
  final FirebaseUserRepository _userRepository;

  ResetPasswordView({Key key, @required FirebaseUserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Reset Password"),
      ),
      body: Center(
        child: BlocProvider<ResetPasswordBloc>(
          create: (BuildContext context) =>
              ResetPasswordBloc(userRepository: _userRepository),
          child: ResetPasswordForm(),
        ),
      ),
    );
  }
}
