import 'package:flutter/material.dart';
import 'package:flutter_app/core/authentication/authentication.bloc.dart';
import 'package:flutter_app/core/authentication/authentication.event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/trip/models/trip.dart';

import 'bloc/trip_dashboard_bloc.dart';
import 'bloc/trip_dashboard_state.dart';

class TripDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trips"), actions: [
        IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context)
                  .dispatch(LoggedOut());
            })
      ]),
      body: BlocBuilder<TripDashboardBloc, TripDashboardState>(
        builder: (context, state) {
          if (state.isLoading) {
            return CircularProgressIndicator();
          }
          if (state.isLoaded) {
            return ListView(
                children: state.trips.map((trip) => TripWidget(trip)).toList());
          }
          return Placeholder();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addTrip');
        },
      ),
    );
  }
}

class TripWidget extends StatelessWidget {
  final Trip trip;

  TripWidget(this.trip);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(trip.title),
        subtitle: Text(trip.destination),
      ),
    );
  }
}
