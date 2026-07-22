#  Ứng Dụng Lập Lịch Cá Nhân (Schedule App)

> **Môn học:** Lập trình thiết bị di động (LTTBDD)  
> **Nhóm thực hiện:** Nhóm 06 - Lớp N01  
> **Nền tảng phát triển:** Flutter & Dart (Cross-platform)

---

##  1. Giới thiệu dự án

**Ứng dụng Lập lịch cá nhân** hỗ trợ người dùng quản lý thời gian, tạo và theo dõi các lịch hẹn, sự kiện cá nhân hiệu quả với giao diện hiện đại, trực quan, hỗ trợ nhắc nhở thông báo cục bộ.

###  Các tính năng chính
- 📅 **Quản lý lịch hẹn:** Xem danh sách công việc theo Ngày, Tuần, Tháng (tích hợp `table_calendar`).
- ✍️ **Tạo & Chỉnh sửa sự kiện:** Đặt tiêu đề, ghi chú chi tiết, thời gian bắt đầu/kết thúc và đánh dấu trạng thái hoàn thành.
- 🔔 **Thông báo nhắc hẹn:** Tích hợp Local Notifications phát thông báo chuẩn xác theo thời gian đã lập lịch.
- 💾 **Lưu trữ dữ liệu Offline:** Sử dụng cơ sở dữ liệu Isar NoSQL siêu nhẹ, tốc độ cao.

---

##  2. Yêu cầu môi trường (Prerequisites)

Trước khi tiến hành cài đặt và chạy dự án, máy tính của bạn cần chuẩn bị sẵn các công cụ sau:

1. **Flutter SDK**: Phiên bản `>= 3.12.0` (Khuyên dùng Flutter 3.x mới nhất).
2. **Dart SDK**: Đã đi kèm cùng Flutter SDK.
3. **Môi trường lập trình (IDE)**: Visual Studio Code (với plugin Flutter & Dart) hoặc Android Studio.
4. **Android Emulator / Thiết bị Android thật**:
   - Nếu dùng thiết bị thật: Bật **Chế độ nhà phát triển (Developer Options)** và **Gỡ lỗi USB (USB Debugging)**.
   - Nếu dùng hệ điều hành Windows: Bật **Developer Mode** của Windows để tránh lỗi cấp quyền Symlink của Flutter (`start ms-settings:developers`).

---

##  3. Hướng dẫn Cài đặt & Khởi chạy (Install & Run)

### Bước 1: Tải mã nguồn về máy (Clone Repository)
```bash
git clone <repository_url>
cd 2025_2026_3_2_LTTBDD_N01_Nhom_6
```

### Bước 2: Di chuyển vào thư mục ứng dụng Flutter
```bash
cd schedule_app
```

### Bước 3: Tải các gói thư viện phụ thuộc (Dependencies)
```bash
flutter pub get
```

>  **Lưu ý trên Windows:** Nếu gặp thông báo lỗi:  
> `Building with plugins requires symlink support. Please enable Developer Mode in your system settings...`  
> Bạn hãy nhấn phím `Windows`, tìm `Developer settings` (hoặc mở cửa sổ CMD/PowerShell chạy lệnh `start ms-settings:developers`) và gạt công tắc **Developer Mode** sang **ON**. Sau đó thực hiện lại lệnh `flutter pub get`.

### Bước 4: Sinh mã nguồn CSDL Isar (Isar Code Generator)
*(Thực hiện bước này khi chạy ứng dụng lần đầu hoặc sau khi chỉnh sửa model dữ liệu)*
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Bước 5: Khởi chạy ứng dụng
Đảm bảo đã mở sẵn thiết bị giả lập (Android Emulator) hoặc kết nối điện thoại Android qua cáp USB:

```bash
# Kiểm tra danh sách thiết bị đang sẵn sàng
flutter devices

# Khởi chạy ứng dụng ở chế độ Debug
flutter run
```

---

##  4. Hướng dẫn Đóng gói & Cài đặt File APK (Build & Install APK)

###  4.1. Đóng gói ứng dụng thành file APK (Build APK)

Mở cửa sổ Terminal tại thư mục `schedule_app` và thực hiện lệnh đóng gói tương ứng:

#### **Cách 1: Tạo 1 file APK duy nhất (Universal APK - Chứa tất cả kiến trúc chip)**
```bash
flutter build apk --release
```
* File APK sau khi build thành công sẽ nằm tại đường dẫn:  
  `schedule_app/build/app/outputs/flutter-apk/app-release.apk`

#### **Cách 2: Tạo file APK riêng theo từng kiến trúc chip (Giúp giảm tối đa dung lượng APK)**
```bash
flutter build apk --split-per-abi
```
* Lệnh trên sẽ xuất ra 3 file APK tối ưu riêng tại thư mục `schedule_app/build/app/outputs/flutter-apk/`:
  - `app-armeabi-v7a-release.apk` (Dành cho thiết bị Android 32-bit cũ)
  - `app-arm64-v8a-release.apk` (Dành cho thiết bị Android 64-bit phổ biến hiện nay)
  - `app-x86_64-release.apk` (Dành cho máy giả lập Android x86_64)

---
