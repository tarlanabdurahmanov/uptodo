import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import 'package:todolistapp/features/domain/service/hive_service.dart';
import 'package:todolistapp/shared/exceptions/http_exception.dart';

// abstract class TodoRepository {
//   Future<Either<AppException, bool>> insertTodo({required Todo todo});
//   Future<Either<AppException, bool>> removeTodo({required String id});
//   Future<Either<AppException, bool>> editTodo({
//     required String id,
//     required Todo todo,
//   });
// }

abstract class TodoRepository {
  Future<List<TodoHiveModel>?> getTodos();
}

class TodoRepositoryImp extends TodoRepository {
  @override
  Future<List<TodoHiveModel>> getTodos() async {
    final todos = await HiveService.getHive().getTodos();
    return todos;
  }
}
