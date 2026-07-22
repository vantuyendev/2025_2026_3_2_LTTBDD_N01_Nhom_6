import 'package:isar/isar.dart';

part 'event_model.g.dart';

/// Representation of an Event/Task in local Isar Database
@collection
class EventModel {
  Id id = Isar.autoIncrement;

  late String title;
  String? note;
  late DateTime startTime;
  late DateTime endTime;

  bool isDone;
  bool isReminded;

  EventModel({
    this.id = Isar.autoIncrement,
    required this.title,
    this.note,
    required this.startTime,
    required this.endTime,
    this.isDone = false,
    this.isReminded = true,
  });
}
