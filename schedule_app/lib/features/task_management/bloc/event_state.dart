import 'package:equatable/equatable.dart';
import '../../../../data/models/event_model.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object?> get props => [];
}

/// Trạng thái khởi tạo ban đầu
class EventInitial extends EventState {
  const EventInitial();
}

/// Trạng thái đang tải dữ liệu
class EventLoading extends EventState {
  const EventLoading();
}

/// Trạng thái đã tải dữ liệu thành công
class EventLoaded extends EventState {
  final List<EventModel> events;
  final DateTime selectedDate;

  const EventLoaded({
    required this.events,
    required this.selectedDate,
  });

  @override
  List<Object?> get props => [events, selectedDate];
}

/// Trạng thái gặp lỗi trong quá trình xử lý
class EventError extends EventState {
  final String message;

  const EventError(this.message);

  @override
  List<Object?> get props => [message];
}
