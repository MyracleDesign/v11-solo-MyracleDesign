import "package:bloc/bloc.dart";
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login/login.page.dart';
import 'package:flutter_app/pages/splash_page.dart';
import 'package:flutter_app/pages/trip-dashboard/bloc/bloc.dart';
import 'package:flutter_app/theme-travel-todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:repository/trip/firebase_trip_repository.dart';
import 'package:repository/trip/models/models.dart';
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
    return MultiBlocProvider(
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
            final tripsBloc = BlocProvider.of<TripDashboardBloc>(context);
            return AddTripScreen(
                onSave: (
                  id,
                  title,
                  destination,
                  startDate,
                  endDate,
                  photoUrl,
                ) {
                  tripsBloc.dispatch(AddTrip(Trip(
                    id,
                    title,
                    destination,
                    startDate,
                    endDate,
                    photoUrl,
                  )));
                },
                isEditing: false);
          },
        },
      ),
    );
  }
}

class AddTripScreen extends StatefulWidget {
  final Function onSave;
  final bool isEditing;
  final Trip trip;

  AddTripScreen({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.trip,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String title;
  String description;

  var _startDateController = TextEditingController();

  var _endDateController = TextEditingController();

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Trip" : "Create Trip"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                  initialValue: isEditing ? widget.trip.title : "",
                  autofocus: !isEditing,
                  decoration: InputDecoration(
                    hintText: "Trip Title",
                  )),
              TextFormField(
                  initialValue: isEditing ? widget.trip.destination : "",
                  decoration: InputDecoration(hintText: "Destination")),
              TextFormField(
                decoration: InputDecoration(hintText: "Start Date"),
                onTap: () async {
                  final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate:
                    isEditing ? widget.trip.startDate : DateTime.now(),
                    lastDate: DateTime(2101),
                    firstDate: DateTime(2015, 8),
                  );
                  if (picked != null) {
                    var formattedDateTime =
                    new DateFormat.yMMMd().format(picked);
                    _startDateController.text = formattedDateTime.toString();
                  }
                },
                controller: _startDateController,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "End Date"),
                onTap: () async {
                  final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate:
                    isEditing ? widget.trip.startDate : DateTime.now(),
                    lastDate: DateTime(2101),
                    firstDate: DateTime(2015, 8),
                  );
                  if (picked != null) {
                    var formattedDateTime =
                    new DateFormat.yMMMd().format(picked);
                    _endDateController.text = formattedDateTime.toString();
                  }
                },
                controller: _endDateController,
              )

            ],
          ),
        ),
      ),
    );
  }
}
