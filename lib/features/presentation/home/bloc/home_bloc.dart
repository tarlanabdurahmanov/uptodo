import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import 'package:todolistapp/features/domain/repositories/todo/todo_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  TodoRepository? repository;

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      repository = TodoRepositoryImp();
      switch (event.runtimeType) {
        case HomeFetchEvent:
          try {
            var model = await repository?.getTodos();
            if (model != null) {
              emit(HomeStateSuccess(model));
            } else {
              emit(const HomeStateError("Empty"));
            }
          } catch (error, _) {
            emit(HomeStateError(error.toString()));
          }
          break;
      }
    });
  }
}
