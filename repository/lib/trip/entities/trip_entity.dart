import 'package:cloud_firestore/cloud_firestore.dart';

class TripEntity {
  final String id;
  final String title;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final String photoUrl;

  TripEntity(
    this.id,
    this.title,
    this.destination,
    this.startDate,
    this.endDate,
    this.photoUrl,
  );

  Map<String, Object> toJson() {
    return {
      "id": id,
      "title": title,
      "destination": destination,
      "startDate": startDate,
      "endDate": endDate,
      "photoUrl": photoUrl
    };
  }

  @override
  String toString() {
    return "TripEntity {id: $id, title: $title, destination: $destination, startDate: $startDate, endDate: $endDate, photoUrl: $photoUrl}";
  }

  static TripEntity fromJson(Map<String, Object> json) {
    return TripEntity(
        json["id"] as String,
        json["title"] as String,
        json["destination"] as String,
        json["startDate"] as DateTime,
        json["endDate"] as DateTime,
        json["photoUrl"]);
  }

  static TripEntity fromSnapshot(DocumentSnapshot snap) {
    return TripEntity(
        snap.documentID,
        snap.data["title"],
        snap.data["destination"],
        (snap.data["startDate"] as Timestamp)?.toDate(),
        (snap.data["endDate"] as Timestamp)?.toDate(),
        snap.data["photoUrl"]);
  }

  Map<String, Object> toDocument() {
    return {
      "title": title,
      "destination": destination,
      "startDate": startDate,
      "endDate": endDate,
      "photoUrl": photoUrl
    };
  }
}
