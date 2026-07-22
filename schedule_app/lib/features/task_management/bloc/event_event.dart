import 'package:equatable/equatable.dart';
import '../../../../data/models/event_model.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object?> get props => [];
}

/// Phát sự kiện tải lịch theo ngày
class LoadEventsByDate extends EventEvent {
  final DateTime date;

  const LoadEventsByDate(this.date);

  @override
  List<Object?> get props => [date];
}

/// Phát sự kiện thêm lịch mới
class AddEvent extends EventEvent {
  final EventModel event;

  const AddEvent(this.event);

  @override
  List<Object?> get props => [event];
}

/// Đổi trạng thái Hoàn thành / Chưa hoàn thành
class ToggleEventStatus extends EventEvent {
  final EventModel event;

  const ToggleEventStatus(this.event);

  @override
  List<Object?> get props => [event];
}

/// Xóa sự kiện theo ID
class DeleteEvent extends EventEvent {
  final int id;
  final DateTime currentDate;

  const DeleteEvent({required this.id, required this.currentDate});

  @override
  List<Object?> get props => [id, currentDate];
}
