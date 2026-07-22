import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In vi, this message translates to:
  /// **'Lịch Cá Nhân'**
  String get appTitle;

  /// No description provided for @personalCalendar.
  ///
  /// In vi, this message translates to:
  /// **'Lịch Cá Nhân'**
  String get personalCalendar;

  /// No description provided for @eventsForDate.
  ///
  /// In vi, this message translates to:
  /// **'Sự kiện ngày {date}'**
  String eventsForDate(String date);

  /// No description provided for @eventList.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách sự kiện'**
  String get eventList;

  /// No description provided for @taskCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} công việc'**
  String taskCount(int count);

  /// No description provided for @noEventsForDay.
  ///
  /// In vi, this message translates to:
  /// **'Không có sự kiện nào cho ngày này'**
  String get noEventsForDay;

  /// No description provided for @addEvent.
  ///
  /// In vi, this message translates to:
  /// **'Thêm sự kiện'**
  String get addEvent;

  /// No description provided for @createNewEvent.
  ///
  /// In vi, this message translates to:
  /// **'Tạo Sự Kiện Mới'**
  String get createNewEvent;

  /// No description provided for @eventTitle.
  ///
  /// In vi, this message translates to:
  /// **'Tiêu đề sự kiện *'**
  String get eventTitle;

  /// No description provided for @eventTitleHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập tiêu đề công việc/sự kiện...'**
  String get eventTitleHint;

  /// No description provided for @eventTitleRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tiêu đề sự kiện'**
  String get eventTitleRequired;

  /// No description provided for @noteDescription.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú / Mô tả'**
  String get noteDescription;

  /// No description provided for @noteDescriptionHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mô tả chi tiết (nếu có)...'**
  String get noteDescriptionHint;

  /// No description provided for @executionDate.
  ///
  /// In vi, this message translates to:
  /// **'Ngày thực hiện'**
  String get executionDate;

  /// No description provided for @change.
  ///
  /// In vi, this message translates to:
  /// **'Thay đổi'**
  String get change;

  /// No description provided for @startTime.
  ///
  /// In vi, this message translates to:
  /// **'Bắt đầu'**
  String get startTime;

  /// No description provided for @endTime.
  ///
  /// In vi, this message translates to:
  /// **'Kết thúc'**
  String get endTime;

  /// No description provided for @reminderNotification.
  ///
  /// In vi, this message translates to:
  /// **'Thông báo nhắc hẹn'**
  String get reminderNotification;

  /// No description provided for @reminderSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhận thông báo khi đến giờ sự kiện'**
  String get reminderSubtitle;

  /// No description provided for @saveEvent.
  ///
  /// In vi, this message translates to:
  /// **'Lưu sự kiện'**
  String get saveEvent;

  /// No description provided for @editEvent.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh Sửa Sự Kiện'**
  String get editEvent;

  /// No description provided for @updateEvent.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật sự kiện'**
  String get updateEvent;

  /// No description provided for @deleteEvent.
  ///
  /// In vi, this message translates to:
  /// **'Xóa sự kiện'**
  String get deleteEvent;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận xóa'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmMessage.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa sự kiện \"{title}\" không?'**
  String deleteConfirmMessage(String title);

  /// No description provided for @cancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In vi, this message translates to:
  /// **'Sửa'**
  String get edit;

  /// No description provided for @eventUpdated.
  ///
  /// In vi, this message translates to:
  /// **'Đã cập nhật sự kiện'**
  String get eventUpdated;

  /// No description provided for @eventDeleted.
  ///
  /// In vi, this message translates to:
  /// **'Đã xóa sự kiện'**
  String get eventDeleted;

  /// No description provided for @undo.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn tác'**
  String get undo;

  /// No description provided for @selectLanguage.
  ///
  /// In vi, this message translates to:
  /// **'Chọn ngôn ngữ'**
  String get selectLanguage;

  /// No description provided for @vietnamese.
  ///
  /// In vi, this message translates to:
  /// **'Tiếng Việt'**
  String get vietnamese;

  /// No description provided for @english.
  ///
  /// In vi, this message translates to:
  /// **'English'**
  String get english;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
