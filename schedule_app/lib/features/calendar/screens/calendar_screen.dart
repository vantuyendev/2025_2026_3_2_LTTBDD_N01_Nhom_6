import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../widgets/event_card.dart';

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
  final Map<DateTime, List<Map<String, dynamic>>> _demoEvents = {
    DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      {
        'title': 'Họp Nhóm Đồ Án LTTBDD',
        'timeRange': '08:30 - 10:00',
        'note': 'Báo cáo tiến độ Bước 5 và rà soát code TableCalendar',
        'isDone': false,
        'color': Colors.blue,
      },
      {
        'title': 'Nộp Báo Cáo Tiến Độ',
        'timeRange': '11:30 - 12:00',
        'note': 'Cập nhật BAO_CAO_DO_AN.md Chương 3 & 4',
        'isDone': true,
        'color': Colors.orange,
      },
      {
        'title': 'Review Code UI/UX',
        'timeRange': '14:00 - 15:30',
        'note': 'Kiểm tra giao diện EventCard trên thiết bị thực',
        'isDone': false,
        'color': Colors.purple,
      },
    ],
  };

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);
    return _demoEvents[normalizedDay] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDayEvents =
        _selectedDay != null ? _getEventsForDay(_selectedDay!) : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch Cá Nhân'),
        centerTitle: true,
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
                      ? 'Sự kiện ngày ${DateFormat('dd/MM/yyyy').format(_selectedDay!)}'
                      : 'Danh sách sự kiện',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(
                    '${selectedDayEvents.length} công việc',
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
                          'Không có sự kiện nào cho ngày này',
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
                      return EventCard(
                        title: event['title'],
                        timeRange: event['timeRange'],
                        note: event['note'],
                        isDone: event['isDone'],
                        indicatorColor: event['color'],
                        onTap: () {},
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
