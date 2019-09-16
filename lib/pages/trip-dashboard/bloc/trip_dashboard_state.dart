import 'package:meta/meta.dart';

@immutable
class TripDashboardState {
  final bool isLoading;
  final bool isFailure;
  final bool isLoaded;
  final List<dynamic> trips;

  TripDashboardState({
    @required this.isLoading,
    @required this.isFailure,
    @required this.isLoaded,
    @required this.trips,
  });

  factory TripDashboardState.empty() {
    return TripDashboardState(
      isLoading: false,
      isFailure: false,
      isLoaded: false,
      trips: [],
    );
  }

  factory TripDashboardState.loading() {
    return TripDashboardState(
      isLoading: true,
      isFailure: false,
      isLoaded: false,
      trips: [],
    );
  }

  factory TripDashboardState.loaded(List<dynamic> trips) {
    return TripDashboardState(
      isLoading: false,
      isFailure: false,
      isLoaded: true,
      trips: trips,
    );
  }

  factory TripDashboardState.failure() {
    return TripDashboardState(
      isLoading: false,
      isFailure: true,
      isLoaded: false,
      trips: [],
    );
  }
}
