import "package:bloc/bloc.dart";
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/add-trip/add_trip_page.dart';
import 'package:flutter_app/pages/login/login.page.dart';
import 'package:flutter_app/pages/splash_page.dart';
import 'package:flutter_app/theme-travel-todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/trip/firebase_trip_repository.dart';
import 'package:repository/trip/models/models.dart';
import 'package:repository/user_repository.dart';

import 'core/bloc/authentication/bloc.dart';
import 'core/bloc/trip/bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          builder: (context) {
            return AuthenticationBloc(
              userRepository: FirebaseUserRepository(),
            )..dispatch(AppStarted());
          },
        ),
        BlocProvider<TripBloc>(builder: (context) {
          return TripBloc(
            tripRepository: FirebaseTripRepository(),
          )..dispatch(TripDashboardLoading());
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: travelTodoTheme,
        routes: {
          '/': (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
            );
          },
          "/addTrip": (context) {
            final tripsBloc = BlocProvider.of<TripBloc>(context);
            return AddTripPage(
                onSave: (
                    {@required id,
                    title,
                    destination,
                    startDate,
                    endDate,
                    photoUrl}) {
                  tripsBloc.dispatch(
                    AddTrip(
                      Trip(
                        id: id,
                        title: title,
                        destination: destination,
                        startDate: startDate,
                        endDate: endDate,
                        photoUrl: photoUrl,
                      ),
                    ),
                  );
                  Navigator.pop(context);
                },
                isEditing: false);
          },
        },
      ),
    );
  }
}
