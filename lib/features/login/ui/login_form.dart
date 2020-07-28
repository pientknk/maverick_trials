import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maverick_trials/core/repository/user_repository.dart';
import 'package:maverick_trials/features/login/bloc/login.dart';
import 'package:maverick_trials/features/login/ui/create_account_button.dart';
import 'package:maverick_trials/features/login/ui/forgot_password_link.dart';
import 'package:maverick_trials/features/login/ui/google_login_button.dart';
import 'package:maverick_trials/features/login/ui/guest_account_button.dart';
import 'package:maverick_trials/features/login/ui/login_button.dart';
import 'package:maverick_trials/features/login/ui/verify_email_required_dialog.dart';
import 'package:maverick_trials/ui/shared/app_loading_indicator.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginInitialState) {
          //any additional resetting should be done here if needed otherwise delete this
          print('Login initial state');
        }

        if (state is LoginFailureState) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.error),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(widget._userRepository
                                .getErrorMsgForCode(state.errorCode)))),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 4),
              ),
            );
        }

        if (state is LoginSubmittingState) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BasicProgressIndicator(),
                    Text('Logging in...'),
                  ],
                ),
                duration: Duration(seconds: 2),
              ),
            );
        }

        if (state is LoginEmailVerificationRequiredState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return VerifyEmailRequiredDialog();
            },
          );
        }
      },
      //bloc builder for loginbloc allows us to rebuild when the login bloc has a new state
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState state) {
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Container(
              padding: const EdgeInsets.only(left: 12, top: 25, right: 12),
              child: Column(
                children: <Widget>[
                  Center(
                      child: FlutterLogo(
                    size: 65,
                  )),
                  Center(child: Text('MAVERICK TRIALS')),
                  Center(
                      child: Text(
                          'Play with friends or family and compete for fame and glory')),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        StreamBuilder<String>(
                          stream: _loginBloc.email,
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'myemail@gmail.com',
                                errorText: snapshot.error,
                              ),
                              onChanged: _loginBloc.onEmailChanged,
                              validator: _loginBloc.validateRequiredField,
                            );
                          },
                        ),
                        StreamBuilder<String>(
                          stream: _loginBloc.password,
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            return TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: '********',
                                errorText: snapshot.error,
                              ),
                              onChanged: _loginBloc.onPasswordChanged,
                              validator: _loginBloc.validateRequiredField,
                            );
                          },
                        ),
                        ForgotPasswordLink(
                          userRepository: widget._userRepository,
                        ),
                        StreamBuilder<bool>(
                          stream: _loginBloc.isLoginButtonEnabled,
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            return LoginButton(
                              onPressed:
                                  (snapshot.hasData && snapshot.data == true)
                                      ? () => _loginBloc.onLoginButtonPressed()
                                      : null,
                            );
                          },
                        ),
                        GoogleLoginButton(),
                        GuestAccountButton(),
                        CreateAccountButton(
                            userRepository: widget._userRepository),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPop() async {
    return false;
  }
}
