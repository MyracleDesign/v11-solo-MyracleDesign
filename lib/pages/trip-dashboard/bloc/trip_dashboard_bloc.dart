import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class TripDashboardBloc extends Bloc<TripDashboardEvent, TripDashboardState> {
  final TripsRepository tripsRepository;

  TripDashboardBloc({this.tripsRepository});

  @override
  TripDashboardState get initialState => TripDashboardState.loading();

  @override
  Stream<TripDashboardState> mapEventToState(
    TripDashboardEvent event,
  ) async* {
    if (event is TripDashboardLoading) {
      yield* _mapLoadTodosToState();
    }
  }

  Stream<TripDashboardState> _mapLoadTodosToState() async* {
    try {
      final trips = await this.tripsRepository.loadTrips();
      yield TripDashboardState.loaded(trips);
    } catch (e) {
      yield TripDashboardState.failure();
    }
  }
}

class TripsRepository {
  loadTrips() {}
}
