// import 'package:dartz/dartz.dart';
// import 'package:todolistapp/features/data/datasources/todo/todo_data_source.dart';
// import 'package:todolistapp/features/data/models/todo_model.dart';
// import 'package:todolistapp/features/domain/repositories/todo/todo_repository.dart';
// import 'package:todolistapp/shared/exceptions/http_exception.dart';

// class TodoRepositoryImpl extends TodoRepository {
//   TodoRepositoryImpl(this.dataSource);

//   // final TodoDataSource dataSource;

//   @override
//   Future<Either<AppException, bool>> editTodo(
//       {required String id, required Todo todo}) {
//     return dataSource.editTodo(todo: todo, id: id);
//   }

//   @override
//   Future<Either<AppException, bool>> insertTodo({required Todo todo}) {
//     return dataSource.insertTodo(todo: todo);
//   }

//   @override
//   Future<Either<AppException, bool>> removeTodo({required String id}) {
//     return dataSource.removeTodo(id: id);
//   }

//   @override
//   Future<List<TodoHiveModel>?> getTodos() {
//     // TODO: implement getTodos
//     throw UnimplementedError();
//   }
// }
