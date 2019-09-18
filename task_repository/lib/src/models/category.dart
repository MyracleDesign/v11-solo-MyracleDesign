import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'task.dart';

@immutable
class Category extends Equatable {
  final String id;
  final String title;
  final Color color;
  final List<Task> tasks;

  Category(this.id, this.title, this.color, this.tasks)
      : super([id, title, color, tasks]);
}
