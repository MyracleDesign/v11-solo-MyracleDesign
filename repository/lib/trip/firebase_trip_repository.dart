import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repository/task/src/entities/entities.dart';
import 'package:repository/trip/models/trip.dart';
import 'package:repository/trip/trip_repository.dart';

class FirebaseTripRepository implements TripRepository {
  final tripCollection = Firestore.instance.collection("trips");

  @override
  Future<void> addTrip(Trip trip) {
    return tripCollection.add(trip.toEntity().toDocument());
  }

  @override
  Future<void> deleteTrip(Trip trip) {
    return tripCollection.document(trip.id).delete();
  }

  @override
  Stream<List<Trip>> loadTrips() {
    return tripCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Trip.fromEntity(TripEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateTrip(Trip trip) {
    return tripCollection
        .document(trip.id)
        .updateData(trip.toEntity().toDocument());
  }
}
