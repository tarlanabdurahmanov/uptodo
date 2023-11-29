part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

final class CalendarInitial extends CalendarState {}

class CalendarStateSuccess extends CalendarState {
  final List<Todo>? todos;

  const CalendarStateSuccess(this.todos);
}

class CalendarStateError extends CalendarState {
  final String message;
  const CalendarStateError(this.message);
}
