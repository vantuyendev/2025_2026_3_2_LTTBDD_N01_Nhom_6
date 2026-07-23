import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/widgets/language_selector_button.dart';
import '../widgets/event_card.dart';
import '../../task_management/screens/add_event_screen.dart';
import '../../group_info/screens/group_info_screen.dart';
import '../../notifications/notification_service.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Dữ liệu mẫu (Demo Events)
  late final Map<DateTime, List<Map<String, dynamic>>> _demoEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    final today = DateTime.now();
    final todayNormalized = DateTime.utc(today.year, today.month, today.day);

    _demoEvents = {
      todayNormalized: [
        {
          'id': '1',
          'title': 'Họp Nhóm Đồ Án LTTBDD',
          'timeRange': '08:30 - 10:00',
          'note': 'Báo cáo tiến độ Bước 5 và rà soát code TableCalendar',
          'isDone': false,
          'color': Colors.blue,
          'startDate': DateTime(today.year, today.month, today.day, 8, 30),
          'endDate': DateTime(today.year, today.month, today.day, 10, 0),
          'isReminded': true,
        },
        {
          'id': '2',
          'title': 'Nộp Báo Cáo Tiến Độ',
          'timeRange': '11:30 - 12:00',
          'note': 'Cập nhật BAO_CAO_DO_AN.md Chương 3 & 4',
          'isDone': true,
          'color': Colors.orange,
          'startDate': DateTime(today.year, today.month, today.day, 11, 30),
          'endDate': DateTime(today.year, today.month, today.day, 12, 0),
          'isReminded': true,
        },
        {
          'id': '3',
          'title': 'Review Code UI/UX',
          'timeRange': '14:00 - 15:30',
          'note': 'Kiểm tra giao diện EventCard trên thiết bị thực',
          'isDone': false,
          'color': Colors.purple,
          'startDate': DateTime(today.year, today.month, today.day, 14, 0),
          'endDate': DateTime(today.year, today.month, today.day, 15, 30),
          'isReminded': false,
        },
      ],
    };
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);
    return _demoEvents[normalizedDay] ?? [];
  }

  Future<void> _openAddEventScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventScreen(
          initialSelectedDate: _selectedDay,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      final startDate = result['startDate'] as DateTime;
      final endDate = result['endDate'] as DateTime;
      final normalizedDay = DateTime.utc(
        startDate.year,
        startDate.month,
        startDate.day,
      );

      final startTimeStr = DateFormat('HH:mm').format(startDate);
      final endTimeStr = DateFormat('HH:mm').format(endDate);
      final isReminded = result['isReminded'] ?? true;
      final notificationId = DateTime.now().millisecondsSinceEpoch % 100000;

      final newEvent = {
        'id': notificationId.toString(),
        'title': result['title'],
        'timeRange': '$startTimeStr - $endTimeStr',
        'note': result['note'],
        'isDone': false,
        'color': Colors.teal,
        'startDate': startDate,
        'endDate': endDate,
        'isReminded': isReminded,
      };

      setState(() {
        if (_demoEvents.containsKey(normalizedDay)) {
          _demoEvents[normalizedDay]!.add(newEvent);
        } else {
          _demoEvents[normalizedDay] = [newEvent];
        }
      });

      // Lập lịch thông báo nếu người dùng bật nhắc hẹn
      if (isReminded) {
        final noteText = (result['note'] as String?) ?? '';
        await NotificationService.instance.scheduleNotification(
          id: notificationId,
          title: result['title'] as String,
          body: noteText.isNotEmpty ? noteText : 'Đến giờ lịch hẹn!',
          scheduledTime: startDate,
        );
      }
    }
  }

  Future<void> _openEditEventScreen(
    DateTime currentDay,
    int index,
    Map<String, dynamic> event,
  ) async {
    final startDate = event['startDate'] as DateTime? ?? currentDay;
    final endDate = event['endDate'] as DateTime? ?? currentDay.add(const Duration(hours: 1));

    final startTime = TimeOfDay(hour: startDate.hour, minute: startDate.minute);
    final endTime = TimeOfDay(hour: endDate.hour, minute: endDate.minute);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEventScreen(
          initialSelectedDate: startDate,
          initialTitle: event['title'],
          initialNote: event['note'],
          initialStartTime: startTime,
          initialEndTime: endTime,
          initialIsReminded: event['isReminded'] ?? true,
          isEditing: true,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      final newStartDate = result['startDate'] as DateTime;
      final newEndDate = result['endDate'] as DateTime;

      final oldNormalizedDay = DateTime.utc(currentDay.year, currentDay.month, currentDay.day);
      final newNormalizedDay = DateTime.utc(newStartDate.year, newStartDate.month, newStartDate.day);

      final startTimeStr = DateFormat('HH:mm').format(newStartDate);
      final endTimeStr = DateFormat('HH:mm').format(newEndDate);
      final isReminded = result['isReminded'] ?? true;
      final notificationId = (int.tryParse(event['id']?.toString() ?? '') ?? DateTime.now().millisecondsSinceEpoch) % 100000;

      final updatedEvent = {
        ...event,
        'title': result['title'],
        'timeRange': '$startTimeStr - $endTimeStr',
        'note': result['note'],
        'startDate': newStartDate,
        'endDate': newEndDate,
        'isReminded': isReminded,
      };

      setState(() {
        if (oldNormalizedDay == newNormalizedDay) {
          _demoEvents[oldNormalizedDay]![index] = updatedEvent;
        } else {
          if (_demoEvents.containsKey(oldNormalizedDay)) {
            _demoEvents[oldNormalizedDay]!.removeAt(index);
          }
          if (_demoEvents.containsKey(newNormalizedDay)) {
            _demoEvents[newNormalizedDay]!.add(updatedEvent);
          } else {
            _demoEvents[newNormalizedDay] = [updatedEvent];
          }
          _selectedDay = newStartDate;
          _focusedDay = newStartDate;
        }
      });

      // Cập nhật hoặc hủy thông báo
      if (isReminded) {
        final noteText = (result['note'] as String?) ?? '';
        await NotificationService.instance.scheduleNotification(
          id: notificationId,
          title: result['title'] as String,
          body: noteText.isNotEmpty ? noteText : 'Đến giờ lịch hẹn!',
          scheduledTime: newStartDate,
        );
      } else {
        await NotificationService.instance.cancelNotification(notificationId);
      }

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.eventUpdated),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _deleteEvent(
    DateTime currentDay,
    int index,
    Map<String, dynamic> event,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final normalizedDay = DateTime.utc(currentDay.year, currentDay.month, currentDay.day);
    final notificationId = (int.tryParse(event['id']?.toString() ?? '') ?? 0) % 100000;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle),
        content: Text(l10n.deleteConfirmMessage(event['title'] ?? '')),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _demoEvents[normalizedDay]!.removeAt(index);
      });

      // Hủy thông báo khi xóa sự kiện
      await NotificationService.instance.cancelNotification(notificationId);

      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.eventDeleted),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: l10n.undo,
              onPressed: () async {
                setState(() {
                  if (_demoEvents.containsKey(normalizedDay)) {
                    _demoEvents[normalizedDay]!.insert(index, event);
                  } else {
                    _demoEvents[normalizedDay] = [event];
                  }
                });

                if (event['isReminded'] == true && event['startDate'] is DateTime) {
                  final noteText = (event['note'] as String?) ?? '';
                  await NotificationService.instance.scheduleNotification(
                    id: notificationId,
                    title: event['title'] as String? ?? '',
                    body: noteText.isNotEmpty ? noteText : 'Đến giờ lịch hẹn!',
                    scheduledTime: event['startDate'] as DateTime,
                  );
                }
              },
            ),
          ),
        );
      }
    }
  }

  void _toggleDone(DateTime currentDay, int index) {
    final normalizedDay = DateTime.utc(currentDay.year, currentDay.month, currentDay.day);
    setState(() {
      final currentStatus = _demoEvents[normalizedDay]![index]['isDone'] as bool? ?? false;
      _demoEvents[normalizedDay]![index]['isDone'] = !currentStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = Localizations.localeOf(context);
    final tableCalendarLocale = currentLocale.languageCode == 'vi' ? 'vi_VN' : 'en_US';

    final selectedDayEvents =
        _selectedDay != null ? _getEventsForDay(_selectedDay!) : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.personalCalendar),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.group_rounded),
            tooltip: l10n.groupInfoTitle,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GroupInfoScreen(),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: LanguageSelectorButton(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF1A237E), // Deep Indigo / Navy
              ),
              accountName: const Text(
                'NHÓM 06 - LỚP N01',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
              ),
              accountEmail: const Text(
                'Lập Trình Thiết Bị Di Động',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.groups_rounded, size: 36, color: Color(0xFF1A237E)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_rounded, color: Color(0xFF1A237E)),
              title: Text(l10n.personalCalendar),
              selected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people_alt_rounded, color: Color(0xFF1A237E)),
              title: Text(l10n.groupInfoTitle),
              subtitle: const Text('24100462 - Tuyên & 24100350 - Vinh'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroupInfoScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Thống Kê & Widget',
                style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.widgets_outlined, color: Color(0xFF1A237E)),
              title: const Text('Danh Sách Widget Đồ Án'),
              subtitle: const Text('Tổng hợp 30 Widgets Flutter'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GroupInfoScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded, color: Colors.grey),
              title: const Text('Phiên Bản Ứng Dụng'),
              subtitle: const Text('v1.0.0+1 (Schedule App)'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Widget Lịch TableCalendar
          Card(
            margin: const EdgeInsets.all(12.0),
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: TableCalendar(
              locale: tableCalendarLocale,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },

              // Tùy chỉnh Style Lịch
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: theme.primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
                titleTextStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: theme.primaryColor.withAlpha(100),
                  shape: BoxShape.circle,
                ),
                markerDecoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),

          // Header Tiêu đề ngày chọn
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDay != null
                      ? l10n.eventsForDate(DateFormat('dd/MM/yyyy').format(_selectedDay!))
                      : l10n.eventList,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(
                    l10n.taskCount(selectedDayEvents.length),
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  backgroundColor: theme.primaryColor,
                ),
              ],
            ),
          ),

          // Danh sách các EventCard
          Expanded(
            child: selectedDayEvents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_available_rounded,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          l10n.noEventsForDay,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: selectedDayEvents.length,
                    itemBuilder: (context, index) {
                      final event = selectedDayEvents[index];
                      final targetDay = _selectedDay!;
                      return EventCard(
                        title: event['title'],
                        timeRange: event['timeRange'],
                        note: event['note'],
                        isDone: event['isDone'] ?? false,
                        indicatorColor: event['color'] ?? Colors.blue,
                        onToggleDone: () => _toggleDone(targetDay, index),
                        onEdit: () => _openEditEventScreen(targetDay, index, event),
                        onDelete: () => _deleteEvent(targetDay, index, event),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddEventScreen,
        backgroundColor: theme.primaryColor,
        tooltip: l10n.addEvent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
