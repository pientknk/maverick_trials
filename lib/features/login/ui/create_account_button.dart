import 'package:flutter/material.dart';
import 'package:maverick_trials/core/repository/user_repository.dart';
import 'package:maverick_trials/features/register/ui/register_page.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              //TODO: make this page take parameters for the currently entered email and password
              //field so that you can pass them into the create account fields for them (very convenient)
              return RegisterPage(userRepository: _userRepository);
            }));
          },
          label: Text('Create an Account'),
          icon: Icon(Icons.person_add),
          color: Colors.greenAccent,
        ),
      ),
    );
  }
}
