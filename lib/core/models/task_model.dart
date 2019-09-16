import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Task extends Equatable {
  final bool complete;
  final String id;
  final String description;
  final String name;
  final DateTime dueDate;

  Task(this.name, this.dueDate,
      {this.complete = false, String id, String note = ""})
      : this.description = note ?? "",
        this.id = id ?? Uuid().v4(),
        super([complete, id, note, name]);
}
