import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maverick_trials/features/register/bloc/register.dart';
import 'package:maverick_trials/features/register/ui/verify_email_dialog.dart';
import 'package:maverick_trials/ui/widgets/app_animated_icon_button.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:maverick_trials/ui/widgets/app_snack_bar.dart';
import 'package:maverick_trials/ui/widgets/app_text_fields.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';

class RegisterForm extends StatefulWidget {
  final String email;
  final String password;

  RegisterForm({this.email, this.password});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  RegisterBloc _registerBloc;
  FocusNode nicknameNode;
  FocusNode emailNode;
  FocusNode passwordNode;

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    nicknameNode = FocusNode();
    emailNode = FocusNode();
    passwordNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    nicknameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (BuildContext context, RegisterState state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              AppSnackBar(
                leading: CircularProgressIndicator(),
                text: 'Registering...',
                durationInMs: 1750,
              ).build(),
            );
        }

        if (state.isSuccess) {
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
              AppSnackBar(
                text: 'Registration Failed',
                durationInMs: 2500,
                leading: Icon(Icons.error),
                appSnackBarType: AppSnackBarType.error,
                action: SnackBarAction(
                  label: 'Details',
                  onPressed: (){

                })
              ).build(),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (BuildContext context, RegisterState state) {
          print('register form rebuilt within blocbuilder');
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          _header(),
                          _nicknameFormField(),
                          _emailFormField(),
                          _passwordFormField(),
                        ],
                      ),
                    ),
                  ),
                  _registerButton(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _registerButton(BuildContext context){
    return StreamBuilder<bool>(
        stream: _registerBloc.isRegisterButtonEnabled,
        builder:
          (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return AppButton(
            text: ButtonThemeText(text: 'Register'.toUpperCase()),
            onPressed: (snapshot.hasData && snapshot.data == true)
              ? () => _registerBloc.onRegisterButtonPressed(context)
              : null,
          );
        },
      );
  }

  Widget _header(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SecondaryText(
          text:
          'Create an account in order to save your hard work, add '
            'friends, and play games with them.'
        ),
      ),
    );
  }

  Widget _nicknameFormField(){
    return BasicStreamTextFormField(
      stream: _registerBloc.nickname,
      labelText: 'Nickname',
      hintText: 'FlamingJesus',
      onChanged: _registerBloc.onNicknameChanged,
      textInputAction: TextInputAction.next,
      currentFocusNode: nicknameNode,
      nextFocusNode: emailNode,
      suffixIcon: _animatedIconButton(),
      controller: _registerBloc.nicknameTextController,
      validator: _registerBloc.validateRequiredField,
    );
  }

  Widget _animatedIconButton(){
    return StreamBuilder<bool>(
      stream: _registerBloc.randomGeneratedNickname,
      builder:
        (BuildContext context, AsyncSnapshot<bool> snapshot) {
        print('AnimatedIconButton rebuilt');
        return Align(
          alignment: Alignment.centerRight,
          child: AppAnimatedIconButton(
            runAnimation: snapshot.data,
            icon: FaIcon(
              FontAwesomeIcons.random,
            ),
            startingSize: 20,
            endingSize: 24,
            onPressed: () {
              _registerBloc.onGenerateNicknameButtonPressed();
              if (nicknameNode.hasPrimaryFocus) {
                nicknameNode.unfocus();
              }
            },
          ),
        );
      },
    );
  }

  Widget _emailFormField(){
    print('email value ${widget.email}');
    return BasicStreamTextFormField(
      stream: _registerBloc.email,
      labelText: 'Email',
      hintText: 'myemail@gmail.com',
      onChanged: _registerBloc.onEmailChanged,
      textInputAction: TextInputAction.next,
      currentFocusNode: emailNode,
      nextFocusNode: passwordNode,
      validator: _registerBloc.validateRequiredField,
      initialValue: widget.email,
    );
  }

  Widget _passwordFormField(){
    return BasicStreamTextFormField(
      stream: _registerBloc.password,
      labelText: 'Password',
      hintText: '********',
      onChanged: _registerBloc.onPasswordChanged,
      textInputAction: TextInputAction.done,
      currentFocusNode: passwordNode,
      obscureText: true,
      validator: _registerBloc.validateRequiredField,
      initialValue: widget.password,
    );
  }
}
