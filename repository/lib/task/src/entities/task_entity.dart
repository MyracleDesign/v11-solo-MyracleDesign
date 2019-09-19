import 'package:cloud_firestore/cloud_firestore.dart';

class TaskEntity {
  final bool complete;
  final String id;
  final String description;
  final String name;
  final DateTime dueDate;

  TaskEntity(this.complete, this.id, this.description, this.name, this.dueDate);

  Map<String, Object> toJson() {
    return {
      "complete": complete,
      "name": name,
      "description": description,
      "dueDate": dueDate,
      "id": id
    };
  }

  @override
  String toString() {
    return "TaskEntity {complete: $complete, name: $name, description: $description, dueDate: $dueDate, id: $id}";
  }

  static TaskEntity fromJson(Map<String, Object> json) {
    return TaskEntity(
      json["complete"] as bool,
      json["id"] as String,
      json["description"] as String,
      json["name"] as String,
      json["dueDate"] as DateTime,
    );
  }

  static TaskEntity fromSnapshot(DocumentSnapshot snap) {
    return TaskEntity(
      snap.data["complete"],
      snap.documentID,
      snap.data["description"],
      snap.data["name"],
      snap.data["dueDate"],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "complete": complete,
      "name": name,
      "description": description,
      "dueDate": dueDate
    };
  }
}
