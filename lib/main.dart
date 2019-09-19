import "package:bloc/bloc.dart";
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login/login.page.dart';
import 'package:flutter_app/pages/splash_page.dart';
import 'package:flutter_app/pages/trip-dashboard/bloc/bloc.dart';
import 'package:flutter_app/theme-travel-todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/trip/firebase_trip_repository.dart';
import 'package:repository/user_repository.dart';

import 'core/authentication/bloc.dart';
import 'core/delegates/simpleBloc.delegate.dart';
import 'pages/trip-dashboard/trip-dashboard_page.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = FirebaseUserRepository();
  runApp(BlocProvider(
      builder: (context) => AuthenticationBloc(userRepository: userRepository)
        ..dispatch(AppStarted()),
      child: MyApp(userRepository: userRepository)));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: travelTodoTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            builder: (context) {
              return AuthenticationBloc(
                userRepository: FirebaseUserRepository(),
              )..dispatch(AppStarted());
            },
          ),
          BlocProvider<TripDashboardBloc>(builder: (context) {
            return TripDashboardBloc(
              tripRepository: FirebaseTripRepository(),
            )..dispatch(TripDashboardLoading());
          })
        ],
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return SplashPage();
            }
            if (state is Unauthenticated) {
              return LoginPage(
                userRepository: _userRepository,
              );
            }
            if (state is Authenticated) {
              return TripDashboardPage();
            }

            return Placeholder();
          },
        ),
      ),
    );
  }
}
