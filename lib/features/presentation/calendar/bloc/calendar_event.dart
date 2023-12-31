part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class CalendarFetchEvent extends CalendarEvent {
  const CalendarFetchEvent();
}

class CalendarLoadingEvent extends CalendarEvent {
  const CalendarLoadingEvent();
}
