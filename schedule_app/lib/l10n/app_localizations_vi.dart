// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Lịch Cá Nhân';

  @override
  String get personalCalendar => 'Lịch Cá Nhân';

  @override
  String eventsForDate(String date) {
    return 'Sự kiện ngày $date';
  }

  @override
  String get eventList => 'Danh sách sự kiện';

  @override
  String taskCount(int count) {
    return '$count công việc';
  }

  @override
  String get noEventsForDay => 'Không có sự kiện nào cho ngày này';

  @override
  String get addEvent => 'Thêm sự kiện';

  @override
  String get createNewEvent => 'Tạo Sự Kiện Mới';

  @override
  String get eventTitle => 'Tiêu đề sự kiện *';

  @override
  String get eventTitleHint => 'Nhập tiêu đề công việc/sự kiện...';

  @override
  String get eventTitleRequired => 'Vui lòng nhập tiêu đề sự kiện';

  @override
  String get noteDescription => 'Ghi chú / Mô tả';

  @override
  String get noteDescriptionHint => 'Nhập mô tả chi tiết (nếu có)...';

  @override
  String get executionDate => 'Ngày thực hiện';

  @override
  String get change => 'Thay đổi';

  @override
  String get startTime => 'Bắt đầu';

  @override
  String get endTime => 'Kết thúc';

  @override
  String get reminderNotification => 'Thông báo nhắc hẹn';

  @override
  String get reminderSubtitle => 'Nhận thông báo khi đến giờ sự kiện';

  @override
  String get saveEvent => 'Lưu sự kiện';

  @override
  String get selectLanguage => 'Chọn ngôn ngữ';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get english => 'English';
}
