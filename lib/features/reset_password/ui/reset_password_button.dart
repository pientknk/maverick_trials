import 'package:flutter/material.dart';

class ResetPasswordButton extends StatelessWidget {
  final VoidCallback _onPressed;

  ResetPasswordButton({Key key, @required VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: _onPressed,
          child: Text('RESET PASSWORD'),
        ),
      ),
    );
  }
}
