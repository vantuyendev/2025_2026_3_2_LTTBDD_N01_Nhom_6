import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/event_model.dart';

/// Provider for managing local Isar Database lifecycle and instance
class DBProvider {
  static DBProvider? _instance;
  static Isar? _isar;

  DBProvider._();

  static DBProvider get instance {
    _instance ??= DBProvider._();
    return _instance!;
  }

  Isar get db {
    if (_isar == null || !_isar!.isOpen) {
      throw StateError('DBProvider has not been initialized. Call DBProvider.init() first.');
    }
    return _isar!;
  }

  /// Initialize Isar Database on app launch
  static Future<void> init() async {
    if (_isar != null && _isar!.isOpen) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [EventModelSchema],
      directory: dir.path,
      name: 'event_db',
    );
  }

  /// Close connection to Isar database
  Future<void> close() async {
    if (_isar != null && _isar!.isOpen) {
      await _isar!.close();
      _isar = null;
    }
  }
}
