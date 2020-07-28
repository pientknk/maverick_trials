import 'package:flutter/material.dart';
import 'package:maverick_trials/core/repository/user_repository.dart';
import 'package:maverick_trials/features/reset_password/ui/reset_password_view.dart';

class ForgotPasswordLink extends StatelessWidget {
  final UserRepository _userRepository;

  ForgotPasswordLink({Key key, UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
              return ResetPasswordView(userRepository: _userRepository);
            }));
          },
        ),
      ),
    );
  }
}
