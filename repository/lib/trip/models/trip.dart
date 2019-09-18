import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository/task/src/entities/entities.dart';

@immutable
class Trip extends Equatable {
  final String id;
  final String title;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final Uri photoUrl;

  Trip(
    this.id,
    this.title,
    this.destination,
    this.startDate,
    this.endDate,
    this.photoUrl,
  );

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        destination.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        photoUrl.hashCode;
  }

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is Trip &&
          id == other.id &&
          title == other.title &&
          destination == other.destination &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          photoUrl == other.photoUrl;

  TripEntity toEntity() {
    return TripEntity(
      id,
      title,
      destination,
      startDate,
      endDate,
      photoUrl,
    );
  }

  static Trip fromEntity(TripEntity entity) {
    return Trip(
      entity.id,
      entity.title,
      entity.destination,
      entity.startDate,
      entity.endDate,
      entity.photoUrl,
    );
  }
}
