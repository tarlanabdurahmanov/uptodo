import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolistapp/features/data/datasources/todo/todo_data_source.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import 'package:todolistapp/features/providers/todo/state/todo_state.dart';
import 'package:todolistapp/shared/exceptions/http_exception.dart';

class TodoNotifier extends StateNotifier<TodoState> {
  TodoNotifier(this._dataSource) : super(const TodoState.initial()) {
    allTodo();
  }

  final TodoDataSource _dataSource;

  Future<Either<AppException, List<Todo>>> allTodo() async {
    state = const TodoState.loading();
    final either = await _dataSource.allTodos();
    return either.fold(
      (error) {
        state = TodoState.error(message: error);
        return Left(error);
      },
      (todos) {
        state = TodoState.allTodo(todos: todos);
        return Right(todos);
      },
    );
  }

  Future<Either<AppException, bool>> insertTodo({required Todo todo}) async {
    state = const TodoState.loading();
    return await _dataSource.insertTodo(todo: todo);
  }

  // Future<void> signup({required String email, required String password}) async {
  //   state = const AuthenticationState.loading();
  //   final response = await _dataSource.signup(email: email, password: password);
  //   state = response.fold(
  //     (error) => AuthenticationState.unauthenticated(message: error),
  //     (response) => AuthenticationState.authenticated(user: response),
  //   );
  // }

  // Future<void> continueWithGoogle() async {
  //   state = const AuthenticationState.loading();
  //   final response = await _dataSource.continueWithGoogle();
  //   state = response.fold(
  //     (error) => AuthenticationState.unauthenticated(message: error),
  //     (response) => AuthenticationState.authenticated(user: response),
  //   );
  // }
}

final todoNotifierProvider = StateNotifierProvider<TodoNotifier, TodoState>(
  (ref) => TodoNotifier(ref.read(todoDataSourceProvider)),
);
