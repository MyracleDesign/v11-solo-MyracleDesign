class TripEntity {
  final String id;
  final String title;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final Uri pictureLink;

  TripEntity(this.id, this.title, this.destination, this.startDate,
      this.endDate, this.pictureLink);

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        destination.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        pictureLink.hashCode;
  }

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      other is TripEntity &&
          id == other.id &&
          title == other.title &&
          destination == other.destination &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          pictureLink == other.pictureLink;

  Map<String, Object> toJson() {
    return {
      "id": id,
      "title": title,
      "destination": destination,
      "startDate": startDate,
      "endDate": endDate,
      "pictureLink": pictureLink
    };
  }

  @override
  String toString() {
    return "TripEntity {id: $id, title: $title, destination: $destination, startDate: $startDate, endDate: $endDate, pictureLink: $pictureLink}";
  }

  static TripEntity fromJson(Map<String, Object> json) {
    return TripEntity(
        json["id"] as String,
        json["title"] as String,
        json["destination"] as String,
        json["startDate"] as DateTime,
        json["endDate"] as DateTime,
        json["pictureLink"] as Uri);
  }
}
