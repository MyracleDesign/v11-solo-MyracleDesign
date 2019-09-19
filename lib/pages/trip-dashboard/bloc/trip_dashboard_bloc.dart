import 'dart:async';
import 'package:repository/trip_repository.dart';
import "package:bloc/bloc.dart";
import 'trip_dashboard_event.dart';
import 'trip_dashboard_state.dart';

class TripDashboardBloc extends Bloc<TripDashboardEvent, TripDashboardState> {
  final TripRepository tripRepository;
  StreamSubscription _tripSubscription;

  TripDashboardBloc({this.tripRepository});

  @override
  TripDashboardState get initialState => TripDashboardState.loading();

  @override
  Stream<TripDashboardState> mapEventToState(
    TripDashboardEvent event,
  ) async* {
    if (event is TripDashboardLoading) {
      yield* _mapLoadTripsToState();
    } else if (event is TripsUpdated) {
      yield* _mapTripsUpdatedToState(event);
    } else if (event is AddTrip) {
      yield* _mapAddTripToState(event);
    }
  }

  Stream<TripDashboardState> _mapLoadTripsToState() async* {
    try {
      _tripSubscription?.cancel();
      _tripSubscription = tripRepository.loadTrips().listen(
        (trips) {
          dispatch(TripsUpdated(trips));
        },
      );
    } catch (e) {
      yield TripDashboardState.failure();
    }
  }

  Stream<TripDashboardState> _mapTripsUpdatedToState(
      TripsUpdated event) async* {
    yield TripDashboardState.loaded(event.updatedTrips);
  }

  Stream<TripDashboardState> _mapAddTripToState(AddTrip event) async* {
    tripRepository.addTrip(event.newTrip);
  }
}
