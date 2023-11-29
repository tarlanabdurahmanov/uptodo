import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import 'package:todolistapp/features/domain/repositories/todo/todo_repository.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  TodoRepository? repository;
  CalendarBloc() : super(CalendarInitial()) {
    on<CalendarEvent>((event, emit) async {
      repository = TodoRepositoryImp();
      switch (event.runtimeType) {
        case CalendarFetchEvent:
          try {
            var model = await repository?.getTodos();
            if (model != null) {
              emit(CalendarStateSuccess(model));
            } else {
              emit(const CalendarStateError("Empty"));
            }
          } catch (error, _) {
            emit(CalendarStateError(error.toString()));
          }
        // break;
      }
    });
  }
}
