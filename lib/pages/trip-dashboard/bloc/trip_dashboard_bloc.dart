import 'dart:async';
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class TripDashboardBloc extends Bloc<TripDashboardEvent, TripDashboardState> {
  @override
  TripDashboardState get initialState => TripDashboardState.empty();

  @override
  Stream<TripDashboardState> mapEventToState(
    TripDashboardEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
