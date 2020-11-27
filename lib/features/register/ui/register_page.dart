import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/features/register/bloc/register.dart';
import 'package:maverick_trials/features/register/ui/register_form.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage();

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: BlocProvider<RegisterBloc>(
        create: (BuildContext context) =>
          RegisterBloc(),
        child: RegisterForm(),
      ),
    );
  }
}

