import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app/core/models/task_model.dart';
import 'package:meta/meta.dart';

@immutable
class Category extends Equatable {
  final String id;
  final String title;
  final Color color;
  final List<Task> tasks;

  Category(this.id, this.title, this.color, this.tasks)
      : super([id, title, color, tasks]);
}
