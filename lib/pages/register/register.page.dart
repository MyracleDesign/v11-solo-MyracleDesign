import 'package:flutter/material.dart';
import 'package:flutter_app/pages/register/bloc/bloc.dart';
import 'package:flutter_app/pages/register/register-form.widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class RegisterPage extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          builder: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
