# BÁO CÁO ĐỒ ÁN: ỨNG DỤNG LẬP LỊCH CÁ NHÂN (FLUTTER)

## CHƯƠNG 1: TỔNG QUAN DỰ ÁN
* **1.1 Lý do chọn đề tài:** ...
* **1.2 Mục tiêu dự án:** ...
* **1.3 Phân công công việc:**
  | Thành viên | Vai trò | Trách nhiệm chính |
  | :--- | :--- | :--- |
  | Thành viên A | Data & Logic | Database, State Management, Notifications |
  | Thành viên B | UI & UX | Theme, Custom Widgets, Table Calendar |

* **1.4 Tiến độ thực hiện dự án (Cây nhiệm vụ):**
  - [x] **Bước 1 (Khởi tạo):** Khởi tạo môi trường & Cấu trúc nền tảng (Thành viên A & B).
  - [x] **Bước 2 (Giao diện nền tảng):** Xây dựng hệ thống giao diện nền tảng (Theme & Widgets) (Thành viên B).
  - [x] **Bước 3 (Dữ liệu):** Thiết lập cơ sở dữ liệu Local (Isar Database) & Model Sự kiện (EventModel) (Thành viên A).
  - [x] **Bước 4 / Bước 5 (Tính năng Lịch & Giao diện):** Xây dựng giao diện Lịch (Table Calendar & Event Card UI) (Thành viên B).
  - [x] **Bước 5 (Logic):** Quản lý trạng thái công việc (BLoC) (Thành viên A).
  - [x] **Bước 6 (Thông báo):** Tích hợp thông báo cục bộ (Local Notifications Service) (Thành viên A) - *Vừa hoàn thành*.
  - [x] **Bước 7 (Form UI):** Xây dựng màn hình Tạo/Sửa sự kiện (Create & Edit Event Form UI) (Thành viên B).

## CHƯƠNG 2: CƠ SỞ LÝ THUYẾT & CÔNG NGHỆ
* **2.1 Framework Flutter & Ngôn ngữ Dart:**
  - **Cơ chế ThemeData & ColorScheme:** Flutter quản lý giao diện thông qua class `ThemeData`. Bằng việc sử dụng `ColorScheme.fromSeed`, lập trình viên định nghĩa các màu cơ bản (primary, secondary, surface, background) để hệ thống tự động suy diễn và phân bổ màu sắc phù hợp cho các widget con.
  - **Mô hình kế thừa InheritedWidget:** Khi tích hợp `ThemeData` vào `MaterialApp`, thông tin giao diện sẽ được truyền xuống dưới dạng cây widget. Các widget con truy xuất cấu hình giao diện thông qua phương thức tĩnh `Theme.of(context)`, giúp cập nhật đồng bộ khi chuyển đổi cấu hình hoặc chế độ sáng/tối (Light/Dark mode).
  - **Xây dựng Widget dùng chung (Reusable Widgets):** Flutter khuyến khích tách biệt giao diện thành các `StatelessWidget` hoặc `StatefulWidget` nhỏ gọn, đóng gói logic hiển thị riêng biệt. Component `CustomButton` được thiết kế dưới dạng `StatelessWidget` nhận các tham số đầu vào (title, onPressed, color, borderRadius), giúp tăng tính tái sử dụng, giảm trùng lặp code và tối ưu hóa chu kỳ vẽ lại (rebuild) của Flutter Engine.
* **2.2 Môi trường phát triển Antigravity IDE:** ...
* **2.3 Các thư viện sử dụng:**
  - `table_calendar`: Thư viện hiển thị lịch đa năng mạnh mẽ cho Flutter, hỗ trợ xem theo Month/Two Weeks/Week, chọn ngày và đánh dấu sự kiện.
  - `intl`: Thư viện định dạng thời gian và ngôn ngữ quốc tế hóa.
  - `flutter_bloc`: Thư viện quản lý trạng thái theo mô hình BLoC (Business Logic Component), giúp tách biệt logic nghiệp vụ và giao diện.
  - `equatable`: Thư viện so sánh giá trị đối tượng trong Dart, giúp BLoC nhận diện chính xác sự thay đổi trạng thái (State change) để tối ưu tái vẽ UI.
  - `flutter_local_notifications`: Thư viện xử lý thông báo đẩy cục bộ (Local Notifications) trên Android và iOS, hỗ trợ lập lịch thông báo chính xác (Scheduled Notifications) ngay cả khi ứng dụng chạy ngầm.
  - `timezone`: Thư viện cung cấp cơ sở dữ liệu múi giờ toàn cầu, hỗ trợ định dạng mốc thời gian `tz.TZDateTime` chuẩn xác theo múi giờ địa phương của thiết bị.

## CHƯƠNG 3: PHÂN TÍCH THIẾT KẾ HỆ THỐNG
* **3.1 Sơ đồ Ca sử dụng (Use Case):** ...
* **3.2 Cấu trúc dữ liệu (Data Model) & Giải pháp lưu trữ Offline:**
  - **Giải pháp lưu trữ Offline (Isar Database):** Ứng dụng lựa chọn giải pháp Cơ sở dữ liệu Isar Database (`isar`), một hệ CSDL NoSQL cực kỳ tối ưu cho Flutter với khả năng ghi/đọc dữ liệu nhanh, hỗ trợ bất đồng bộ toàn diện, và hoạt động không cần server (Zero-Server Overhead). Thư viện `path_provider` giúp xác định chính xác đường dẫn thư mục ứng dụng an toàn trên cả iOS và Android.
  - **Mô hình Dữ liệu Sự kiện/Lịch hẹn (`EventModel`):**
    | Tên trường | Kiểu dữ liệu | Bắt buộc | Giá trị mặc định | Mô tả |
    | :--- | :--- | :--- | :--- | :--- |
    | `id` | `Id` (int) | Có | `Isar.autoIncrement` | Khóa chính tự động tăng định danh sự kiện |
    | `title` | `String` | Có | - | Tiêu đề công việc/lịch hẹn |
    | `note` | `String?` | Không | `null` | Ghi chú chi tiết thêm cho lịch hẹn |
    | `startTime` | `DateTime` | Có | - | Thời gian bắt đầu sự kiện |
    | `endTime` | `DateTime` | Có | - | Thời gian kết thúc sự kiện |
    | `isDone` | `bool` | Có | `false` | Trạng thái đã hoàn thành hay chưa |
    | `isReminded` | `bool` | Có | `true` | Cấu hình bật/tắt thông báo nhắc hẹn |
* **3.3 Kiến trúc thư mục (Feature-First) & Mô hình Quản lý Trạng thái (BLoC + Repository):**
  - **Mô hình Repository Pattern:** `EventRepository` đóng vai trò là tầng trừu tượng trung gian giữa nguồn dữ liệu Isar Database (`DBProvider`) và tầng logic nghiệp vụ (`EventBloc`). Repository chịu trách nhiệm xử lý toàn bộ các giao dịch CRUD (truy vấn danh sách theo ngày `getEventsByDate`, thêm sự kiện `addEvent`, cập nhật `updateEvent`, xóa `deleteEvent`), giúp che giấu chi tiết lưu trữ và tăng khả năng kiểm thử độc lập.
  - **Mô hình Quản lý Trạng thái BLoC (Business Logic Component):**
    - **Event (`EventEvent`):** Định nghĩa các sự kiện đầu vào kích hoạt từ giao diện người dùng như `LoadEventsByDate`, `AddEvent`, `ToggleEventStatus`, `DeleteEvent`.
    - **State (`EventState`):** Định nghĩa các trạng thái giao diện đầu ra tương ứng bao gồm `EventInitial`, `EventLoading`, `EventLoaded` (chứa danh sách sự kiện và ngày đang chọn), và `EventError`.
    - **BLoC (`EventBloc`):** Nhận Event từ UI, giao tiếp với `EventRepository` để cập nhật/lấy dữ liệu từ Isar DB, sau đó phát ra (emit) State mới giúp UI tự động lắng nghe và vẽ lại theo thời gian thực.
  - **Cấu hình Form Nhập liệu Sự kiện (`AddEventScreen`):**
    - **Tiêu đề sự kiện (`TextField`):** Ô nhập dữ liệu bắt buộc (Validation: không được bỏ trống), có icon minh họa `Icons.title_rounded`.
    - **Mô tả / Ghi chú (`TextField`):** Ô nhập văn bản nhiều dòng (`maxLines: 3`) để người dùng nhập thông tin chi tiết công việc.
    - **Bộ chọn Ngày & Giờ (`DatePicker` & `TimePicker`):** Tích hợp bộ chọn ngày/giờ chuẩn Material 3, sử dụng thư viện `intl` (`DateFormat('dd/MM/yyyy')`) và `TimeOfDay.format()` để định dạng hiển thị trực quan.
    - **Công tắc Nhắc hẹn (`SwitchListTile`):** Công tắc toggle cho phép bật/tắt tính năng thông báo nhắc nhở khi tới giờ sự kiện.
    - **Nút Lưu (`CustomButton`):** Sử dụng widget dùng chung `CustomButton` đóng gói logic submit form, xác thực dữ liệu và đóng màn hình trả về đối tượng Map/EventModel.
  - **Giải thuật xử lý thông báo ngầm & Lập lịch thông báo địa phương (Local Notifications Service):**
    - **Cơ chế Singleton (`NotificationService`):** Quản lý tập trung toàn bộ chu kỳ sống của dịch vụ thông báo thông qua phương thức `NotificationService.instance`.
    - **Khởi tạo Notification Channel & Cấp quyền hệ thống:** Hàm `init()` thiết lập cấu hình icon (`@mipmap/ic_launcher` trên Android, `DarwinInitializationSettings` trên iOS), nạp dữ liệu múi giờ `tz.initializeTimeZones()`, đồng thời chủ động xin quyền cấp thông báo (`requestNotificationsPermission`) và báo thức chính xác (`requestExactAlarmsPermission`) đối với các thiết bị Android 13+ (API level 33+).
    - **Giải thuật Schedule Notification theo múi giờ địa phương (`tz.TZDateTime`):** Hàm `scheduleNotification` chuyển đổi thời gian `scheduledTime` dạng `DateTime` sang `tz.TZDateTime.from(scheduledTime, tz.local)`. Hàm `zonedSchedule` kích hoạt phát thông báo ngầm đúng mốc thời gian thiết lập với chế độ `androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle`.
    - **Cơ chế Hủy thông báo (`cancelNotification`):** Cho phép hủy lịch phát thông báo dựa trên ID sự kiện định danh khi người dùng thực hiện xóa công việc hoặc tắt tùy chọn thông báo nhắc hẹn.
  Dự án áp dụng kiến trúc Feature-First kết hợp phân lớp công việc rõ ràng giữa các thành viên:
  ```text
  schedule_app/lib/
  ├── core/                   # Dùng chung (Thành viên B)
  │   ├── di/                 # Dependency Injection
  │   ├── routes/             # Định tuyến ứng dụng
  │   ├── theme/              # Chủ đề UI (Màu sắc, Font)
  │   ├── utils/              # Tiện ích chung
  │   └── widgets/            # Custom Widget dùng chung
  ├── data/                   # Data Layer (Thành viên A)
  │   ├── models/             # Đối tượng dữ liệu (Task, Category,...)
  │   ├── providers/          # Nguồn dữ liệu (Local SQLite / SharedPref)
  │   └── repositories/       # Kho chứa và xử lý dữ liệu
  └── features/               # Các tính năng chính
      ├── calendar/           # Tính năng Lịch (Thành viên B)
      │   ├── screens/        # Màn hình giao diện Lịch (calendar_screen.dart)
      │   └── widgets/        # Widget phục vụ Lịch (event_card.dart)
      ├── task_management/    # Quản lý Công việc (Thành viên A)
      │   ├── bloc/           # Quản lý trạng thái (BLoC)
      │   ├── screens/        # Màn hình quản lý Task
      │   └── widgets/        # Widget danh sách/thẻ Task
      └── notifications/      # Thông báo & Nhắc nhở (Thành viên A)
  ```

## CHƯƠNG 4: TRIỂN KHAI KỸ THUẬT & CODE CỐT LÕI

### 4.1 Khởi tạo môi trường & Cấu trúc nền tảng (Commit: `c96c1d1`)
* **Thời gian thực hiện:** 22/07/2026
* **Mô tả công việc:**
  - Khởi tạo dự án Flutter `schedule_app` với các cấu hình nền tảng đa nền tảng (Android, Windows, Web, macOS, Linux).
  - Xây dựng sơ đồ cây thư mục theo kiến trúc **Feature-First**, tách biệt không gian làm việc giữa **Thành viên A** (Data & Logic) và **Thành viên B** (UI & UX).
  - Thêm các file `.gitkeep` duy trì cấu trúc thư mục trên hệ thống quản lý phiên bản Git.
* **Kết quả kiểm thử (Sanity Check):**
  - Chạy `flutter analyze`: Đạt kết quả `No issues found!`.
  - Đã thực hiện commit đầu tiên: `chore(init): khởi tạo môi trường, cấu trúc dự án Flutter`.

### 4.2 Xây dựng hệ thống giao diện nền tảng (Theme & Widgets) (Commit: `feat(theme): build app theme and custom button`)
* **Thời gian thực hiện:** 23/07/2026
* **Mô tả công việc:**
  - Tạo file `lib/core/theme/app_theme.dart` chứa class `AppTheme` định nghĩa Light Theme với bảng màu chuẩn: Primary Blue (`0xFF4A90E2`), Accent/Secondary (`0xFF50E3C2`), Card White (`Colors.white`), và Background (`0xFFF8F9FA`).
  - Để tương thích với phiên bản Flutter mới nhất (`3.44.7`), cấu hình `cardTheme` trong `ThemeData` được cập nhật sử dụng lớp `CardThemeData` thay vì `CardTheme` cũ.
  - Tạo file `lib/core/widgets/custom_button.dart` chứa Widget `CustomButton` dùng chung, kế thừa `StatelessWidget`, có thể tùy biến các thuộc tính kích thước, màu nền và hỗ trợ góc bo tròn (borderRadius: 12).
  - Cập nhật file `lib/main.dart` áp dụng `AppTheme.lightTheme` toàn cục và hiển thị màn hình demo thực tế cho `CustomButton` ở các trạng thái khác nhau (Primary, Accent, Disabled).
* **Mã nguồn cốt lõi:**
  - **Cấu hình AppTheme (`lib/core/theme/app_theme.dart`):**
    ```dart
    import 'package:flutter/material.dart';

    class AppTheme {
      AppTheme._();

      static const Color primaryColor = Color(0xFF4A90E2);
      static const Color accentColor = Color(0xFF50E3C2);
      static const Color cardColor = Colors.white;
      static const Color backgroundColor = Color(0xFFF8F9FA);

      static ThemeData get lightTheme {
        return ThemeData(
          useMaterial3: true,
          primaryColor: primaryColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            secondary: accentColor,
            surface: backgroundColor,
          ),
          scaffoldBackgroundColor: backgroundColor,
          cardTheme: const CardThemeData(
            color: cardColor,
            elevation: 2,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        );
      }
    }
    ```
  - **Widget CustomButton (`lib/core/widgets/custom_button.dart`):**
    ```dart
    import 'package:flutter/material.dart';

    class CustomButton extends StatelessWidget {
      final String title;
      final VoidCallback? onPressed;
      final Color? color;
      final double borderRadius;

      const CustomButton({
        super.key,
        required this.title,
        this.onPressed,
        this.color,
        this.borderRadius = 12.0,
      });

      @override
      Widget build(BuildContext context) {
        final theme = Theme.of(context);
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? theme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    }
    ```
* **Kết quả kiểm thử (Sanity Check):**
  - Chạy `flutter analyze` đạt kết quả: `No issues found!`.

### 4.3 Thiết kế Cơ sở dữ liệu Local và Model Sự kiện (Commit: `feat(data): implement event model and isar db provider`)
* **Thời gian thực hiện:** 23/07/2026
* **Mô tả công việc:**
  - Cập nhật `pubspec.yaml` tích hợp thư viện lưu trữ local Isar Database (`isar`, `isar_flutter_libs`, `path_provider`) cùng bộ công cụ sinh code (`isar_generator`, `build_runner`).
  - Tạo file `lib/data/models/event_model.dart` định nghĩa lớp `@collection EventModel` quản lý thông tin sự kiện/lịch hẹn bao gồm các trường: `id`, `title`, `note`, `startTime`, `endTime`, `isDone`, và `isReminded`.
  - Tạo file `lib/data/providers/db_provider.dart` đóng gói lớp Singleton `DBProvider` quản lý quá trình khởi tạo, truy xuất instance `Isar` an toàn và đóng kết nối CSDL khi dừng ứng dụng.
* **Mã nguồn cốt lõi:**
  - **Model Sự kiện (`lib/data/models/event_model.dart`):**
    ```dart
    import 'package:isar/isar.dart';

    part 'event_model.g.dart';

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
    ```
  - **Lớp Quản lý CSDL DBProvider (`lib/data/providers/db_provider.dart`):**
    ```dart
    import 'package:isar/isar.dart';
    import 'package:path_provider/path_provider.dart';
    import '../models/event_model.dart';

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

      static Future<void> init() async {
        if (_isar != null && _isar!.isOpen) return;

        final dir = await getApplicationDocumentsDirectory();
        _isar = await Isar.open(
          [EventModelSchema],
          directory: dir.path,
          name: 'event_db',
        );
      }

      Future<void> close() async {
        if (_isar != null && _isar!.isOpen) {
          await _isar!.close();
          _isar = null;
        }
      }
    }
    ```
* **Kết quả kiểm thử (Sanity Check):**
  - Chạy `flutter analyze` đạt kết quả: `No issues found!`.

### 4.4 Tích hợp Giao diện Lịch và Danh sách sự kiện (Commit: `feat(calendar): integrate table_calendar and event card ui`)
* **Thời gian thực hiện:** 23/07/2026
* **Mô tả công việc:**
  - Cập nhật file `pubspec.yaml` bổ sung các thư viện `table_calendar` (^3.1.2) và `intl` (^0.19.0).
  - Xây dựng component `EventCard` (`lib/features/calendar/widgets/event_card.dart`) hiển thị trực quan thông tin từng sự kiện: vạch chỉ thị màu, khung giờ, tiêu đề, ghi chú ngắn và biểu tượng Checkbox đánh dấu hoàn thành.
  - Tách biệt màn hình Lịch `CalendarScreen` (`lib/features/calendar/screens/calendar_screen.dart`) tích hợp `TableCalendar` hỗ trợ chọn ngày, chuyển đổi định dạng xem (Month / Two Weeks / Week) cùng danh sách `ListView` liên kết danh sách sự kiện mẫu của ngày được chọn.
  - Cập nhật `lib/main.dart` đặt `CalendarScreen` làm màn hình chính của ứng dụng.
* **Mã nguồn cốt lõi:**
  - **Widget EventCard (`lib/features/calendar/widgets/event_card.dart`):**
    ```dart
    import 'package:flutter/material.dart';

    class EventCard extends StatelessWidget {
      final String title;
      final String timeRange;
      final String? note;
      final bool isDone;
      final Color indicatorColor;
      final VoidCallback? onTap;

      const EventCard({
        super.key,
        required this.title,
        required this.timeRange,
        this.note,
        this.isDone = false,
        this.indicatorColor = Colors.blue,
        this.onTap,
      });

      @override
      Widget build(BuildContext context) {
        final theme = Theme.of(context);
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 6.0,
                    color: isDone ? Colors.grey : indicatorColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 16,
                                color: isDone ? Colors.grey : theme.primaryColor,
                              ),
                              const SizedBox(width: 6.0),
                              Text(
                                timeRange,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: isDone ? Colors.grey : theme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration:
                                  isDone ? TextDecoration.lineThrough : null,
                              color: isDone
                                  ? Colors.grey.shade600
                                  : Colors.black87,
                            ),
                          ),
                          if (note != null && note!.isNotEmpty) ...[
                            const SizedBox(height: 4.0),
                            Text(
                              note!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: isDone
                                    ? Colors.grey.shade500
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Center(
                      child: Icon(
                        isDone
                            ? Icons.check_circle_rounded
                            : Icons.radio_button_unchecked_rounded,
                        color: isDone ? Colors.green : Colors.grey.shade400,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    ```
* **Kết quả kiểm thử (Sanity Check):**
  - Chạy `flutter analyze`: Đạt `No issues found!`.

### 4.5 Xây dựng tầng Logic Dữ liệu & Quản lý Trạng thái (EventRepository & BLoC) (Commit: `feat(logic): implement event repository and event bloc`)
* **Thời gian thực hiện:** 23/07/2026
* **Mô tả công việc:**
  - Cập nhật file `pubspec.yaml` bổ sung các thư viện `flutter_bloc` (^8.1.6) và `equatable` (^2.0.7).
  - Tạo file `lib/data/repositories/event_repository.dart` triển khai lớp `EventRepository` kết nối trực tiếp với `DBProvider` để xử lý đầy đủ các hàm CRUD bất đồng bộ: `getEventsByDate(DateTime date)`, `addEvent(EventModel event)`, `updateEvent(EventModel event)`, và `deleteEvent(int id)`.
  - Thiết lập mô hình quản lý trạng thái BLoC chuẩn tại thư mục `lib/features/task_management/bloc/`:
    - `event_event.dart`: Khai báo danh sách các sự kiện nghiệp vụ (`LoadEventsByDate`, `AddEvent`, `ToggleEventStatus`, `DeleteEvent`).
    - `event_state.dart`: Khai báo các trạng thái UI (`EventInitial`, `EventLoading`, `EventLoaded`, `EventError`).
    - `event_bloc.dart`: Triển khai lớp `EventBloc` xử lý luồng sự kiện, thao tác dữ liệu qua `EventRepository` và emit các trạng thái tương ứng.
* **Mã nguồn cốt lõi:**
  - **Repository Dữ liệu Sự kiện (`lib/data/repositories/event_repository.dart`):**
    ```dart
    import 'package:isar/isar.dart';
    import '../models/event_model.dart';
    import '../providers/db_provider.dart';

    class EventRepository {
      final DBProvider _dbProvider;

      EventRepository({DBProvider? dbProvider})
          : _dbProvider = dbProvider ?? DBProvider.instance;

      Future<List<EventModel>> getEventsByDate(DateTime date) async {
        final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
        final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);

        return await _dbProvider.db.eventModels
            .filter()
            .startTimeBetween(startOfDay, endOfDay)
            .sortByStartTime()
            .findAll();
      }

      Future<int> addEvent(EventModel event) async {
        return await _dbProvider.db.writeTxn(() async {
          return await _dbProvider.db.eventModels.put(event);
        });
      }

      Future<void> updateEvent(EventModel event) async {
        await _dbProvider.db.writeTxn(() async {
          await _dbProvider.db.eventModels.put(event);
        });
      }

      Future<bool> deleteEvent(int id) async {
        return await _dbProvider.db.writeTxn(() async {
          return await _dbProvider.db.eventModels.delete(id);
        });
      }
    }
    ```
  - **Quản lý Trạng thái EventBloc (`lib/features/task_management/bloc/event_bloc.dart`):**
    ```dart
    import 'package:flutter_bloc/flutter_bloc.dart';
    import '../../../../data/models/event_model.dart';
    import '../../../../data/repositories/event_repository.dart';
    import 'event_event.dart';
    import 'event_state.dart';

    class EventBloc extends Bloc<EventEvent, EventState> {
      final EventRepository repository;

      EventBloc({required this.repository}) : super(const EventInitial()) {
        on<LoadEventsByDate>(_onLoadEventsByDate);
        on<AddEvent>(_onAddEvent);
        on<ToggleEventStatus>(_onToggleEventStatus);
        on<DeleteEvent>(_onDeleteEvent);
      }

      Future<void> _onLoadEventsByDate(
        LoadEventsByDate event,
        Emitter<EventState> emit,
      ) async {
        emit(const EventLoading());
        try {
          final events = await repository.getEventsByDate(event.date);
          emit(EventLoaded(events: events, selectedDate: event.date));
        } catch (e) {
          emit(EventError('Lỗi khi tải danh sách sự kiện: ${e.toString()}'));
        }
      }

      Future<void> _onAddEvent(
        AddEvent event,
        Emitter<EventState> emit,
      ) async {
        try {
          await repository.addEvent(event.event);
          final targetDate = event.event.startTime;
          final events = await repository.getEventsByDate(targetDate);
          emit(EventLoaded(events: events, selectedDate: targetDate));
        } catch (e) {
          emit(EventError('Lỗi khi thêm sự kiện: ${e.toString()}'));
        }
      }

      Future<void> _onToggleEventStatus(
        ToggleEventStatus event,
        Emitter<EventState> emit,
      ) async {
        try {
          final updatedEvent = EventModel(
            id: event.event.id,
            title: event.event.title,
            note: event.event.note,
            startTime: event.event.startTime,
            endTime: event.event.endTime,
            isDone: !event.event.isDone,
            isReminded: event.event.isReminded,
          );
          await repository.updateEvent(updatedEvent);

          final currentDate = state is EventLoaded
              ? (state as EventLoaded).selectedDate
              : event.event.startTime;

          final events = await repository.getEventsByDate(currentDate);
          emit(EventLoaded(events: events, selectedDate: currentDate));
        } catch (e) {
          emit(EventError('Lỗi khi cập nhật trạng thái sự kiện: ${e.toString()}'));
        }
      }

      Future<void> _onDeleteEvent(
        DeleteEvent event,
        Emitter<EventState> emit,
      ) async {
        try {
          await repository.deleteEvent(event.id);
          final events = await repository.getEventsByDate(event.currentDate);
          emit(EventLoaded(events: events, selectedDate: event.currentDate));
        } catch (e) {
          emit(EventError('Lỗi khi xóa sự kiện: ${e.toString()}'));
        }
      }
    }
    ```
* **Kết quả kiểm thử (Sanity Check):**
  - Chạy `flutter pub get`: Thành công, cài đặt đầy đủ các gói phụ thuộc.
  - Chạy `flutter analyze`: Đạt kết quả `No issues found!`.

### 4.6 Xây dựng Màn hình Tạo/Sửa sự kiện (AddEventScreen & Navigation) (Commit: `feat(task_management): implement add_event_screen and fab navigation`)
* **Thời gian thực hiện:** 23/07/2026
* **Mô tả công việc:**
  - Tạo màn hình `AddEventScreen` tại `lib/features/task_management/screens/add_event_screen.dart` cho phép người dùng nhập thông tin sự kiện mới hoặc chỉnh sửa.
  - Thiết lập ô nhập Tiêu đề (`TextFormField`) bắt buộc có validation kiểm tra chuỗi rỗng.
  - Thiết lập ô nhập Ghi chú/Mô tả (`TextFormField`) hỗ trợ nhiều dòng (`maxLines: 3`).
  - Tích hợp bộ chọn `DatePicker` và `TimePicker` sử dụng gói `intl` định dạng ngày `dd/MM/yyyy` và giờ bắt đầu / giờ kết thúc.
  - Thêm công tắc `SwitchListTile` bật/tắt chế độ nhắc hẹn và nút bấm `CustomButton` đóng gói logic submit form.
  - Cập nhật `CalendarScreen` bổ sung `FloatingActionButton` (nút màu tròn dấu cộng `+`) kích hoạt mở `AddEventScreen` và nhận dữ liệu phản hồi cập nhật danh sách sự kiện tức thì.
* **Mã nguồn cốt lõi (`lib/features/task_management/screens/add_event_screen.dart`):**
  ```dart
  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';
  import '../../../core/widgets/custom_button.dart';

  class AddEventScreen extends StatefulWidget {
    final DateTime? initialSelectedDate;

    const AddEventScreen({
      super.key,
      this.initialSelectedDate,
    });

    @override
    State<AddEventScreen> createState() => _AddEventScreenState();
  }

  class _AddEventScreenState extends State<AddEventScreen> {
    final _formKey = GlobalKey<FormState>();
    late TextEditingController _titleController;
    late TextEditingController _noteController;
    late DateTime _selectedDate;
    late TimeOfDay _startTime;
    late TimeOfDay _endTime;
    bool _isReminded = true;

    @override
    void initState() {
      super.initState();
      _titleController = TextEditingController();
      _noteController = TextEditingController();
      _selectedDate = widget.initialSelectedDate ?? DateTime.now();
      _startTime = TimeOfDay.now();
      _endTime = TimeOfDay(
        hour: (_startTime.hour + 1) % 24,
        minute: _startTime.minute,
      );
    }

    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        final startDateTime = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _startTime.hour,
          _startTime.minute,
        );
        final endDateTime = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _endTime.hour,
          _endTime.minute,
        );

        Navigator.pop(context, {
          'title': _titleController.text.trim(),
          'note': _noteController.text.trim(),
          'startDate': startDateTime,
          'endDate': endDateTime,
          'isReminded': _isReminded,
        });
      }
    }

    @override
    Widget build(BuildContext context) {
      final theme = Theme.of(context);
      final dateFormat = DateFormat('dd/MM/yyyy');

      return Scaffold(
        appBar: AppBar(title: const Text('Tạo Sự Kiện Mới'), centerTitle: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(hintText: 'Nhập tiêu đề sự kiện...'),
                  validator: (val) => val == null || val.trim().isEmpty ? 'Vui lòng nhập tiêu đề' : null,
                ),
                const SizedBox(height: 16.0),
                SwitchListTile(
                  value: _isReminded,
                  title: const Text('Thông báo nhắc hẹn'),
                  onChanged: (val) => setState(() => _isReminded = val),
                ),
                const SizedBox(height: 24.0),
                CustomButton(title: 'Lưu sự kiện', onPressed: _submitForm),
              ],
            ),
          ),
        ),
      );
    }
  }
  ```
* **Kết quả kiểm thử (Sanity Check):**
  - Chạy `flutter analyze`: Đạt kết quả `No issues found!`.

### 4.7 Tích hợp Hệ thống Thông báo Nhắc hẹn (Local Notifications Service) (Commit: `feat(notifications): implement notification service with local notifications and timezone`)
* **Thời gian thực hiện:** 23/07/2026
* **Mô tả công việc:**
  - Cập nhật file `pubspec.yaml` tích hợp hai thư viện `flutter_local_notifications` (^17.1.2) và `timezone` (^0.9.4).
  - Tạo file `lib/features/notifications/notification_service.dart` định nghĩa lớp Singleton `NotificationService` quản lý toàn bộ chu kỳ thông báo nhắc hẹn.
  - Cấu hình kênh thông báo Android (`AndroidNotificationDetails`) và iOS (`DarwinNotificationDetails`) hỗ trợ độ ưu tiên cao (`Importance.max`, `Priority.high`).
  - Viết phương thức `init()` khởi tạo thiết lập hệ thống, nạp múi giờ địa phương (`tz.initializeTimeZones()`) và yêu cầu cấp quyền hiển thị thông báo / báo thức chính xác trên Android 13+.
  - Viết phương thức `scheduleNotification(...)` tự động tính toán thời gian ngầm chuẩn xác sử dụng `tz.TZDateTime` và hàm `zonedSchedule` với chế độ `AndroidScheduleMode.exactAllowWhileIdle`.
  - Viết phương thức `cancelNotification(int id)` cho phép hủy thông báo theo ID định danh khi công việc bị xóa hoặc hủy bỏ nhắc hẹn.
* **Mã nguồn cốt lõi (`lib/features/notifications/notification_service.dart`):**
  ```dart
  import 'package:flutter_local_notifications/flutter_local_notifications.dart';
  import 'package:timezone/data/latest_all.dart' as tz;
  import 'package:timezone/timezone.dart' as tz;

  class NotificationService {
    static NotificationService? _instance;
    final FlutterLocalNotificationsPlugin _notificationsPlugin =
        FlutterLocalNotificationsPlugin();

    NotificationService._();

    static NotificationService get instance {
      _instance ??= NotificationService._();
      return _instance!;
    }

    Future<void> init() async {
      tz.initializeTimeZones();

      const androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
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

      final androidImplementation =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();
        await androidImplementation.requestExactAlarmsPermission();
      }
    }

    Future<void> scheduleNotification({
      required int id,
      required String title,
      required String body,
      required DateTime scheduledTime,
    }) async {
      if (scheduledTime.isBefore(DateTime.now())) return;

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

    Future<void> cancelNotification(int id) async {
      await _notificationsPlugin.cancel(id);
    }

    Future<void> cancelAllNotifications() async {
      await _notificationsPlugin.cancelAll();
    }
  }
  ```
* **Kết quả kiểm thử (Sanity Check):**
  - Chạy `flutter pub get`: Thành công, cài đặt đầy đủ các gói phụ thuộc.
  - Chạy `flutter analyze`: Đạt kết quả `No issues found!`.

## CHƯƠNG 5: KẾT LUẬN & HƯỚNG PHÁT TRIỂN
* **5.1 Kết quả đạt được:** ...
* **5.2 Hạn chế & Hướng phát triển:** ...