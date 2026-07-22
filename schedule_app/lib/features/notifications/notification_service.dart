import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Lớp Singleton quản lý dịch vụ thông báo cục bộ (Local Notifications Service)
class NotificationService {
  static NotificationService? _instance;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._();

  /// Phương thức lấy instance duy nhất của NotificationService
  static NotificationService get instance {
    _instance ??= NotificationService._();
    return _instance!;
  }

  /// Khởi tạo kênh thông báo Android/iOS, thiết lập múi giờ và yêu cầu quyền hạn
  Future<void> init() async {
    // Khởi tạo cơ sở dữ liệu múi giờ local
    tz.initializeTimeZones();

    // Cấu hình icon thông báo cho Android (@mipmap/ic_launcher)
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Cấu hình xin quyền hiển thị thông báo trên iOS
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(initSettings);

    // Yêu cầu cấp quyền hiển thị thông báo và báo thức chính xác trên Android 13+ (API 33+)
    final androidImplementation =
        _notificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation != null) {
      await androidImplementation.requestNotificationsPermission();
      await androidImplementation.requestExactAlarmsPermission();
    }
  }

  /// Lập lịch phát thông báo nhắc hẹn tại mốc thời gian chính xác (scheduledTime)
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    // Kiểm tra nếu thời gian đặt thông báo đã qua thì không thực hiện lập lịch
    if (scheduledTime.isBefore(DateTime.now())) return;

    // Chuyển đổi DateTime sang mốc thời gian theo múi giờ địa phương (tz.TZDateTime)
    final tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

    const androidDetails = AndroidNotificationDetails(
      'schedule_app_channel',
      'Lập Lịch Nhắc Hẹn',
      channelDescription: 'Kênh thông báo nhắc nhở lịch hẹn và công việc',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzScheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Hủy thông báo nhắc hẹn theo ID khi người dùng xóa sự kiện hoặc tắt nhắc nhở
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  /// Hủy toàn bộ thông báo đã được lập lịch trong ứng dụng
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
