import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maverick_trials/core/repository/user_repository.dart';
import 'package:maverick_trials/features/login/bloc/login.dart';
import 'package:maverick_trials/features/register/ui/register_page.dart';
import 'package:maverick_trials/features/reset_password/ui/reset_password_view.dart';
import 'package:maverick_trials/ui/shared/app_loading_indicator.dart';
import 'package:maverick_trials/ui/widgets/app_buttons.dart';

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
              return verifyEmailRequiredDialog();
            },
          );
        }
      },
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
                        forgotPasswordLink(),
                        StreamBuilder<bool>(
                          stream: _loginBloc.isLoginButtonEnabled,
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            return loginButton(snapshot);
                          },
                        ),
                        googleLoginButton(),
                        guestAccountButton(),
                        createAccountButton(),
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

  Widget createAccountButton(){
    return AppIconButton(
      text: Text('Create an Account'),
      icon: Icon(Icons.person_add),
      color: Colors.greenAccent,
      onPressed: (){
        Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
          //TODO: make this page take parameters for the currently entered email and password
          //field so that you can pass them into the create account fields for them (very convenient)
          return RegisterPage(userRepository: widget._userRepository);
        }));
      },
    );
  }

  Widget guestAccountButton(){
    return AppIconButton(
      text: Text('Create Guest Account',
        style: TextStyle(color: Colors.white)
      ),
      icon: FaIcon(
        FontAwesomeIcons.userNinja,
        color: Colors.white,
      ),
      onPressed: (){
        BlocProvider.of<LoginBloc>(context)
          .add(AnonymousAccountPressedEvent());
      },
      color: Colors.black,
    );
  }

  Widget googleLoginButton(){
    return AppIconButton(
      text: Text('Sign in with Google',
        style: TextStyle(color: Colors.white),
      ),
      icon: FaIcon(
        FontAwesomeIcons.google,
        color: Colors.white,
      ),
      color: Colors.redAccent,
      onPressed: (){
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressedEvent(),
        );
      },
    );
  }

  Widget loginButton(AsyncSnapshot<bool> snapshot){
    return AppIconButton(
      text: Text('LOGIN'),
      icon: Icon(Icons.verified_user),
      color: Colors.blueGrey[300],
      onPressed:
        (snapshot.hasData && snapshot.data == true)
          ? () => _loginBloc.onLoginButtonPressed()
          : null,
    );
  }

  Widget forgotPasswordLink(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: InkWell(
          child: Text(
            'Forgot password?',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {
            Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
              return ResetPasswordView(userRepository: widget._userRepository);
            }));
          },
        ),
      ),
    );
  }

  Widget verifyEmailRequiredDialog(){
    return AlertDialog(
      title: Text('You need to verify your email before logging in'),
      content: Text(
        'To ensure you are a real person with a real email address, you must verify your account.'),
      actions: <Widget>[
        FlatButton(
          child: Text("UGHH FINE"),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        )
      ],
    );
  }
}
