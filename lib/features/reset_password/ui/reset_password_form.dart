import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/reset_password/bloc/reset_password.dart';
import 'package:maverick_trials/features/reset_password/ui/reset_password_button.dart';
import 'package:maverick_trials/features/reset_password/ui/reset_password_dialog.dart';

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  ResetPasswordBloc _resetPasswordBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (BuildContext context, ResetPasswordState state) {
        if (state.isSuccess) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return ResetPasswordDialog();
            },
          ).then((value) => Navigator.of(context).pop());
        }
      },
      child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
        builder: (BuildContext context, ResetPasswordState state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  StreamBuilder<String>(
                    stream: _resetPasswordBloc.email,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'myemail@gmail.com',
                          errorText: snapshot.error,
                        ),
                        onChanged: _resetPasswordBloc.onEmailChanged,
                        validator: _resetPasswordBloc.validateRequiredField,
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  StreamBuilder<bool>(
                    stream: _resetPasswordBloc.isSendResetEmailButtonEnabled,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return ResetPasswordButton(
                        onPressed: (snapshot.hasData && snapshot.data == true)
                            ? () =>
                                _resetPasswordBloc.onResetEmailButtonPressed()
                            : null,
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
