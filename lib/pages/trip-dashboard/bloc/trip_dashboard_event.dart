import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TripDashboardEvent extends Equatable {
  TripDashboardEvent([List<dynamic> props = const []]) : super(props);
}

class TripDashboardLoading extends TripDashboardEvent {
  @override
  String toString() => "TripDashboardLoading";
}
