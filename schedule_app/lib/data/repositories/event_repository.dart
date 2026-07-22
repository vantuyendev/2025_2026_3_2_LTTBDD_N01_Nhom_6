import 'package:isar/isar.dart';
import '../models/event_model.dart';
import '../providers/db_provider.dart';

/// Repository for handling Event/Task CRUD operations with Isar DB
class EventRepository {
  final DBProvider _dbProvider;

  EventRepository({DBProvider? dbProvider})
      : _dbProvider = dbProvider ?? DBProvider.instance;

  /// Lấy danh sách sự kiện theo ngày
  Future<List<EventModel>> getEventsByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);

    return await _dbProvider.db.eventModels
        .filter()
        .startTimeBetween(startOfDay, endOfDay)
        .sortByStartTime()
        .findAll();
  }

  /// Thêm sự kiện mới
  Future<int> addEvent(EventModel event) async {
    return await _dbProvider.db.writeTxn(() async {
      return await _dbProvider.db.eventModels.put(event);
    });
  }

  /// Cập nhật sự kiện (ví dụ đánh dấu hoàn thành)
  Future<void> updateEvent(EventModel event) async {
    await _dbProvider.db.writeTxn(() async {
      await _dbProvider.db.eventModels.put(event);
    });
  }

  /// Xóa sự kiện theo ID
  Future<bool> deleteEvent(int id) async {
    return await _dbProvider.db.writeTxn(() async {
      return await _dbProvider.db.eventModels.delete(id);
    });
  }
}
