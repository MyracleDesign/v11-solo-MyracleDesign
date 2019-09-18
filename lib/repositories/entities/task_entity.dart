class TaskEntity {
  final bool complete;
  final String id;
  final String description;
  final String name;
  final DateTime dueDate;

  TaskEntity(this.complete, this.id, this.description, this.name, this.dueDate);

  @override
  int get hashCode =>
      complete.hashCode ^
      description.hashCode ^
      name.hashCode ^
      id.hashCode ^
      dueDate.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEntity &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          name == other.name &&
          description == other.description &&
          dueDate == other.dueDate &&
          id == other.id;

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
    return "TodoEntity {complete: $complete, name: $name, description: $description, dueDate: $dueDate, id: $id}";
  }

  static TaskEntity fromJson(Map<String, Object> json) {
    return TaskEntity(
        json["complete"] as bool,
        json["id"] as String,
        json["description"] as String,
        json["name"] as String,
        json["dueDate"] as DateTime);
  }
}
