import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login/widgets/login-form.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/user_repository.dart';

import 'bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  final UserRepository _userRepository;

  LoginPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        builder: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }
}
