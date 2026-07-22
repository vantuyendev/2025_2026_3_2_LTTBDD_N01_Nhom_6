import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/language_selector_button.dart';

class AddEventScreen extends StatefulWidget {
  final DateTime? initialSelectedDate;
  final String? initialTitle;
  final String? initialNote;
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;
  final bool? initialIsReminded;
  final bool isEditing;

  const AddEventScreen({
    super.key,
    this.initialSelectedDate,
    this.initialTitle,
    this.initialNote,
    this.initialStartTime,
    this.initialEndTime,
    this.initialIsReminded,
    this.isEditing = false,
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
  late bool _isReminded;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle ?? '');
    _noteController = TextEditingController(text: widget.initialNote ?? '');

    _selectedDate = widget.initialSelectedDate ?? DateTime.now();
    _startTime = widget.initialStartTime ?? TimeOfDay.now();
    _endTime = widget.initialEndTime ??
        TimeOfDay(
          hour: (_startTime.hour + 1) % 24,
          minute: _startTime.minute,
        );
    _isReminded = widget.initialIsReminded ?? true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime({required bool isStartTime}) async {
    final initialTime = isStartTime ? _startTime : _endTime;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = pickedTime;
        } else {
          _endTime = pickedTime;
        }
      });
    }
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

      final newEventData = {
        'title': _titleController.text.trim(),
        'note': _noteController.text.trim(),
        'startDate': startDateTime,
        'endDate': endDateTime,
        'isReminded': _isReminded,
      };

      Navigator.pop(context, newEventData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? l10n.editEvent : l10n.createNewEvent),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: LanguageSelectorButton(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề sự kiện
              Text(
                l10n.eventTitle,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: l10n.eventTitleHint,
                  prefixIcon: const Icon(Icons.title_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.eventTitleRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Ghi chú / Mô tả
              Text(
                l10n.noteDescription,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: l10n.noteDescriptionHint,
                  prefixIcon: const Icon(Icons.notes_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Chọn ngày
              Card(
                elevation: 0,
                color: theme.primaryColor.withAlpha(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.calendar_today_rounded, color: theme.primaryColor),
                  title: Text(l10n.executionDate),
                  subtitle: Text(
                    dateFormat.format(_selectedDate),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: _pickDate,
                    child: Text(l10n.change),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),

              // Chọn giờ bắt đầu & giờ kết thúc
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 0,
                      color: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        dense: true,
                        title: Text(l10n.startTime, style: const TextStyle(fontSize: 12)),
                        subtitle: Text(
                          _startTime.format(context),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () => _pickTime(isStartTime: true),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Card(
                      elevation: 0,
                      color: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        dense: true,
                        title: Text(l10n.endTime, style: const TextStyle(fontSize: 12)),
                        subtitle: Text(
                          _endTime.format(context),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        onTap: () => _pickTime(isStartTime: false),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Switch Thông báo nhắc hẹn
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _isReminded,
                title: Text(
                  l10n.reminderNotification,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(l10n.reminderSubtitle),
                activeThumbColor: theme.primaryColor,
                onChanged: (bool value) {
                  setState(() {
                    _isReminded = value;
                  });
                },
              ),
              const SizedBox(height: 24.0),

              // Nút Lưu sự kiện
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  title: widget.isEditing ? l10n.updateEvent : l10n.saveEvent,
                  onPressed: _submitForm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
