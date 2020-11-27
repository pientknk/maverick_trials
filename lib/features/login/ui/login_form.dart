import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maverick_trials/features/login/bloc/login.dart';
import 'package:maverick_trials/features/register/ui/register_page.dart';
import 'package:maverick_trials/features/reset_password/ui/reset_password_view.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';
import 'package:maverick_trials/ui/widgets/scaffold/app_snack_bar.dart';
import 'package:maverick_trials/ui/widgets/app_text_fields.dart';
import 'package:maverick_trials/ui/widgets/app_text_link.dart';
import 'package:maverick_trials/ui/widgets/app_texts.dart';
import 'package:maverick_trials/utils/helpers.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;
  final _formKey = GlobalKey<FormState>();
  FocusNode emailNode;
  FocusNode passwordNode;

  @override
  void initState() {
    print('init login form');
    emailNode = FocusNode();
    passwordNode = FocusNode();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    print('dispose login form');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginInitialState) {
          //any additional resetting should be done here if needed otherwise delete this
          print('Login initial state');
        }

        if (state is LoginRegisterState) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return RegisterPage();
              }));
        }

        if (state is LoginFailureState) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              AppSnackBar(
                  appSnackBarType: AppSnackBarType.error,
                  text: state.exception,
                  durationInMs: 3000,
                  action: SnackBarAction(
                    label: 'Report',
                    onPressed: () {},
                  )).build(),
            );
        }

        if (state is LoginSubmittingState) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              AppSnackBar(
                leading: CircularProgressIndicator(),
                text: state.message,
                durationInMs: 20000,
              ).build(),
            );
        }

        if (state is LoginEmailVerificationRequiredState) {
          Scaffold.of(context)
            ..hideCurrentSnackBar();
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return verifyEmailRequiredDialog();
            },
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (BuildContext context, LoginState state) {
          return WillPopScope(
            onWillPop: _onWillPop,
            child: SafeArea(
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Center(
                        child: FlutterLogo(
                          size: 65,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: ImportantText('MAVERICK TRIALS')),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            _emailField(),
                            _passwordField(),
                            forgotPasswordLink(),
                            _loginButton(),
                            Container(
                              height: 85,
                            ),
                            createAccountButton(),
                            googleLoginButton(),
                            guestAccountButton(),
                            //offlineModeButton(),
                          ],
                        ),
                      ),
                    ],
                  )),
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

  Widget createAccountButton() {
    return AppIconButton(
      text: 'Create New Account',
      icon: Icon(Icons.person_add),
      onPressed: () {
        print('create act button pressed');
        _loginBloc.registerButtonPressed();
      },
    );
  }

  Widget guestAccountButton() {
    return AppIconButton(
      text: 'preview app',
      icon: FaIcon(
        FontAwesomeIcons.userNinja,
      ),
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(AnonymousAccountPressedEvent());
      },
      //color: Colors.black,
    );
  }

  Widget googleLoginButton() {
    return AppIconButton(
      text: 'Log in with Google',
      icon: FaIcon(
        FontAwesomeIcons.google,
      ),
      //color: Colors.redAccent,
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressedEvent(),
        );
      },
    );
  }

  Widget loginButton(AsyncSnapshot<bool> snapshot) {
    return AppIconButton(
      text: 'log in',
      icon: Icon(Icons.verified_user),
      //color: Colors.blueGrey[300],
      onPressed: (snapshot.hasData && snapshot.data == true)
          ? () {
              Helpers.dismissKeyboard(context);
              _loginBloc.onLoginButtonPressed();
            }
          : null,
    );
  }

  Widget offlineModeButton() {
    return AppIconButton(
      text: 'Offline Mode',
      icon: Icon(Icons.signal_wifi_off),
      //color: Colors.deepOrangeAccent,
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(OfflineModePressedEvent());
      },
    );
  }

  Widget forgotPasswordLink() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: AppTextLink(
        alignment: Alignment.centerRight,
        label: 'Forgot password?',
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ResetPasswordView();
          }));
        },
      ),
    );
  }

  Widget verifyEmailRequiredDialog() {
    return AlertDialog(
      title: Text('You need to verify your email before logging in'),
      content: Text(
          'To ensure you are a real person with a real email address, you must verify your account.'),
      actions: <Widget>[
        FlatButton(
          textColor: Colors.blue[300],
          child: Text("UGHH FINE"),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        )
      ],
    );
  }

  Widget _passwordField() {
    return BasicStreamTextFormField(
      stream: _loginBloc.password,
      labelText: 'Password',
      hintText: '********',
      obscureText: true,
      onChanged: _loginBloc.onPasswordChanged,
      textInputAction: TextInputAction.done,
      currentFocusNode: passwordNode,
      validator: _loginBloc.validateRequiredField,
    );
  }

  Widget _loginButton() {
    return StreamBuilder<bool>(
      stream: _loginBloc.isLoginButtonEnabled,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return loginButton(snapshot);
      },
    );
  }

  Widget _emailField() {
    return BasicStreamTextFormField(
      stream: _loginBloc.email,
      labelText: 'Email',
      hintText: 'myemail@gmail.com',
      onChanged: _loginBloc.onEmailChanged,
      textInputAction: TextInputAction.next,
      currentFocusNode: emailNode,
      nextFocusNode: passwordNode,
      validator: _loginBloc.validateRequiredField,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
