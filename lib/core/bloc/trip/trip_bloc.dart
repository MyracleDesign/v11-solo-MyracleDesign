import 'dart:async';
import 'package:repository/trip_repository.dart';
import "package:bloc/bloc.dart";
import 'trip_event.dart';
import 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final TripRepository tripRepository;
  StreamSubscription _tripSubscription;

  TripBloc({this.tripRepository});

  @override
  TripState get initialState => TripState.loading();

  @override
  Stream<TripState> mapEventToState(
    TripEvent event,
  ) async* {
    if (event is TripDashboardLoading) {
      yield* _mapLoadTripsToState();
    } else if (event is TripsUpdated) {
      yield* _mapTripsUpdatedToState(event);
    } else if (event is AddTrip) {
      yield* _mapAddTripToState(event);
    } else if (event is DeleteTrip) {
      yield* _mapDeleteTripToState(event);
    }
  }

  Stream<TripState> _mapLoadTripsToState() async* {
    try {
      _tripSubscription?.cancel();
      _tripSubscription = tripRepository.loadTrips().listen(
        (trips) {
          dispatch(TripsUpdated(trips));
        },
      );
    } catch (e) {
      yield TripState.failure();
    }
  }

  Stream<TripState> _mapTripsUpdatedToState(TripsUpdated event) async* {
    yield TripState.loaded(event.updatedTrips);
  }

  Stream<TripState> _mapAddTripToState(AddTrip event) async* {
    tripRepository.addTrip(event.newTrip);
    yield TripState.loading();
  }

  Stream<TripState> _mapDeleteTripToState(DeleteTrip event) async* {
    tripRepository.deleteTrip(event.deletedTrip);
    yield TripState.loading();
  }
}
