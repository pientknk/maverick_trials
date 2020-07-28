import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/register/bloc/register.dart';
import 'package:maverick_trials/features/register/ui/register_button.dart';
import 'package:maverick_trials/features/register/ui/verify_email_dialog.dart';
import 'package:maverick_trials/ui/shared/app_loading_indicator.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  RegisterBloc _registerBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (BuildContext context, RegisterState state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    BasicProgressIndicator(),
                  ],
                ),
                duration: Duration(seconds: 1),
              ),
            );
        }

        if (state.isSuccess) {
          //we don't want to do this, we should have them verify their address first
          /*
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLoggedInEvent(name: state.isSuccess.toString())
          );

           */
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return VerifyEmailDialog();
            },
          ).then((value) => Navigator.of(context).pop());
        }

        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.error),
                    Text('Registration Failed'),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (BuildContext context, RegisterState state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  StreamBuilder<String>(
                    stream: _registerBloc.nickname,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextFormField(
                        //TODO: build a random name generator to use for suggestions and have extra button to pick random nickname for user
                        decoration: InputDecoration(
                          labelText: 'Nickname',
                          hintText: 'flamingjesus',
                          errorText: snapshot.error,
                        ),
                        onChanged: _registerBloc.onNicknameChanged,
                        validator: _registerBloc.validateRequiredField,
                      );
                    },
                  ),
                  StreamBuilder<String>(
                    stream: _registerBloc.email,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'myemail@gmail.com',
                          errorText: snapshot.error,
                        ),
                        onChanged: _registerBloc.onEmailChanged,
                        validator: _registerBloc.validateRequiredField,
                      );
                    },
                  ),
                  StreamBuilder<String>(
                    stream: _registerBloc.password,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: '********',
                          errorText: snapshot.error,
                        ),
                        onChanged: _registerBloc.onPasswordChanged,
                        validator: _registerBloc.validateRequiredField,
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  StreamBuilder<bool>(
                    stream: _registerBloc.isRegisterButtonEnabled,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return RegisterButton(
                        onPressed: (snapshot.hasData && snapshot.data == true)
                            ? () => _registerBloc.onRegisterButtonPressed()
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
