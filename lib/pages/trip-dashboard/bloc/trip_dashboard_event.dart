import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository/trip/models/models.dart';

@immutable
abstract class TripDashboardEvent extends Equatable {
  TripDashboardEvent([List<dynamic> props = const []]) : super(props);
}

class TripDashboardLoading extends TripDashboardEvent {
  @override
  String toString() => "TripDashboardLoading";
}

class UpdateTrip extends TripDashboardEvent {
  final Trip updatedTrip;

  UpdateTrip(this.updatedTrip) : super([updatedTrip]);

  @override
  String toString() => 'UpdateTrip { updatedTrip: $updatedTrip }';
}

class TripsUpdated extends TripDashboardEvent {
  final List<Trip> updatedTrips;

  TripsUpdated(this.updatedTrips) : super([updatedTrips]);

  @override
  String toString() => 'TripsUpdated { trips: $updatedTrips }';
}
