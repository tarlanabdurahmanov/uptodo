import 'package:dartz/dartz.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import 'package:todolistapp/shared/exceptions/http_exception.dart';

abstract class TodoRepository {
  Future<Either<AppException, bool>> insertTodo({required Todo todo});
  Future<Either<AppException, bool>> removeTodo({required String id});
  Future<Either<AppException, bool>> editTodo({
    required String id,
    required Todo todo,
  });
}
