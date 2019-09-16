import 'package:equatable/equatable.dart';
import 'package:flutter_app/core/models/category_model.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class Trip extends Equatable {
  final String id;
  final String title;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final Uri pictureLink;
  final List<Category> categories;

  Trip(this.title, this.destination, this.startDate, this.endDate,
      this.pictureLink, this.categories,
      {String id})
      : this.id = id ?? Uuid().v4(),
        assert(title != null),
        super(
            [title, destination, startDate, endDate, pictureLink, categories]);
}
