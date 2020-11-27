import 'package:flutter/material.dart';

class RequestNicknameView extends StatefulWidget {
  @override
  _RequestNicknameViewState createState() => _RequestNicknameViewState();
}

class _RequestNicknameViewState extends State<RequestNicknameView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        //make sure to add authBloc.add(AuthSuccessState(authLoginType: AuthLoginType.requireIntro))
        //body: ,
      ),
    );
  }
}
