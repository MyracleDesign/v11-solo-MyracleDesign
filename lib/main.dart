import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/authentication/authentication.bloc.dart';
import 'package:flutter_app/bloc/authentication/authentication.event.dart';
import 'package:flutter_app/bloc/authentication/authentication.state.dart';
import 'package:flutter_app/bloc/delegates/simpleBloc.delegate.dart';
import 'package:flutter_app/repositories/user-repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:bloc/bloc.dart";

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(BlocProvider(
      builder: (context) => AuthenticationBloc(userRepository: userRepository)
        ..dispatch(AppStarted()),
      child: MyApp(userRepository: userRepository)));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({Key key, @required UserRepository userRepository})
      : assert(_userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Placeholder();
        },
      ),
    );
  }
}
