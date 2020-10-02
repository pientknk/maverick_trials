import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/register/bloc/register.dart';
import 'package:maverick_trials/features/register/ui/register_form.dart';

class RegisterPage extends StatefulWidget {
  final String email;
  final String password;

  RegisterPage({this.email, this.password});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        title: Text('Register'),
      ),
      body: BlocProvider<RegisterBloc>(
        create: (BuildContext context) =>
          RegisterBloc(email: widget.email, password: widget.password),
        child: RegisterForm(email: widget.email, password: widget.password,),
      ),
    );
  }
}

