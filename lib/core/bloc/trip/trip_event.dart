import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository/trip/models/models.dart';

@immutable
abstract class TripEvent extends Equatable {
  TripEvent([List<dynamic> props = const []]) : super(props);
}

class TripDashboardLoading extends TripEvent {
  @override
  String toString() => "TripDashboardLoading";
}

class AddTrip extends TripEvent {
  final Trip newTrip;

  AddTrip(this.newTrip) : super([newTrip]);

  @override
  String toString() {
    return "New Trip { newTrip: $newTrip }";
  }
}

class UpdateTrip extends TripEvent {
  final Trip updatedTrip;

  UpdateTrip(this.updatedTrip) : super([updatedTrip]);

  @override
  String toString() => 'UpdateTrip { updatedTrip: $updatedTrip }';
}

class TripsUpdated extends TripEvent {
  final List<Trip> updatedTrips;

  TripsUpdated(this.updatedTrips) : super([updatedTrips]);

  @override
  String toString() => 'TripsUpdated { trips: $updatedTrips }';
}
