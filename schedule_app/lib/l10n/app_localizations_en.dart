// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Personal Calendar';

  @override
  String get personalCalendar => 'Personal Calendar';

  @override
  String eventsForDate(String date) {
    return 'Events for $date';
  }

  @override
  String get eventList => 'Event List';

  @override
  String taskCount(int count) {
    return '$count tasks';
  }

  @override
  String get noEventsForDay => 'No events for this day';

  @override
  String get addEvent => 'Add event';

  @override
  String get createNewEvent => 'Create New Event';

  @override
  String get eventTitle => 'Event Title *';

  @override
  String get eventTitleHint => 'Enter task/event title...';

  @override
  String get eventTitleRequired => 'Please enter event title';

  @override
  String get noteDescription => 'Note / Description';

  @override
  String get noteDescriptionHint => 'Enter detailed description (if any)...';

  @override
  String get executionDate => 'Date';

  @override
  String get change => 'Change';

  @override
  String get startTime => 'Start';

  @override
  String get endTime => 'End';

  @override
  String get reminderNotification => 'Reminder Notification';

  @override
  String get reminderSubtitle => 'Get notified when event time comes';

  @override
  String get saveEvent => 'Save Event';

  @override
  String get editEvent => 'Edit Event';

  @override
  String get updateEvent => 'Update Event';

  @override
  String get deleteEvent => 'Delete Event';

  @override
  String get deleteConfirmTitle => 'Confirm Delete';

  @override
  String deleteConfirmMessage(String title) {
    return 'Are you sure you want to delete event \"$title\"?';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get eventUpdated => 'Event updated';

  @override
  String get eventDeleted => 'Event deleted';

  @override
  String get undo => 'Undo';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get english => 'English';
}
