import 'models/models.dart';

abstract class TripRepository {
  Future<void> addTrip(Trip trip);

  Future<void> deleteTrip(Trip trip);

  Future<void> updateTrip(Trip trip);

  Stream<List<Trip>> loadTrips();
}
