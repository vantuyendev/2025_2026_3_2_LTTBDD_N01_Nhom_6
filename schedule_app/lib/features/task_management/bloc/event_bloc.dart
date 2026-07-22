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
