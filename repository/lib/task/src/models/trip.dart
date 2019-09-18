import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'category.dart';

@immutable
class Trip extends Equatable {
  final String id;
  final String title;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final Uri pictureLink;
  final List<Category> categories;

  Trip(
    this.id,
    this.title,
    this.destination,
    this.startDate,
    this.endDate,
    this.pictureLink,
    this.categories,
  );
}
