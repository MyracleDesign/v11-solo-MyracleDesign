import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../entities/entities.dart';

@immutable
class Task extends Equatable {
  final bool complete;
  final String id;
  final String description;
  final String name;
  final DateTime dueDate;

  Task(
    this.name, {
    this.complete = false,
    String id,
    String description = '',
    this.dueDate,
  })  : this.description = description ?? '',
        this.id = id;

  Task copyWith(
      {bool complete,
      String id,
      String description,
      String name,
      DateTime dueDate}) {
    return Task(
      name ?? this.name,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
    );
  }

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
      other is Task &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          name == other.name &&
          description == other.description &&
          dueDate == other.dueDate &&
          id == other.id;

  @override
  String toString() {
    return "Task {complete: $complete, name: $name, description: $description, dueDate: $dueDate, id: $id}";
  }

  TaskEntity toEntity() {
    return TaskEntity(complete, id, description, name, dueDate);
  }

  static Task fromEntity(TaskEntity entity) {
    return Task(
      entity.name,
      complete: entity.complete,
      id: entity.id,
      description: entity.description,
      dueDate: entity.dueDate,
    );
  }
}
