import 'package:meta/meta.dart';
import 'package:repository/trip/models/models.dart';

@immutable
class TripState {
  final bool isLoading;
  final bool isFailure;
  final bool isLoaded;
  final List<Trip> trips;

  TripState({
    @required this.isLoading,
    @required this.isFailure,
    @required this.isLoaded,
    @required this.trips,
  });

  factory TripState.loading() {
    return TripState(
      isLoading: true,
      isFailure: false,
      isLoaded: false,
      trips: [],
    );
  }

  factory TripState.loaded(List<Trip> trips) {
    return TripState(
      isLoading: false,
      isFailure: false,
      isLoaded: true,
      trips: trips,
    );
  }

  factory TripState.failure() {
    return TripState(
      isLoading: false,
      isFailure: true,
      isLoaded: false,
      trips: [],
    );
  }
}
