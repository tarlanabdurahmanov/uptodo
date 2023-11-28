// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:todolistapp/features/data/models/todo_model.dart';
// import 'package:todolistapp/shared/exceptions/http_exception.dart';

// abstract class TodoDataSource {
//   Future<Either<AppException, List<Todo>>> allTodos();
//   Future<Either<AppException, bool>> insertTodo({required Todo todo});
//   Future<Either<AppException, bool>> removeTodo({required String id});
//   Future<Either<AppException, bool>> editTodo({
//     required String id,
//     required Todo todo,
//   });
// }

// class TodoRemoteDataSource extends TodoDataSource {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   late CollectionReference _todos;

//   @override
//   Future<Either<AppException, bool>> editTodo({
//     required String id,
//     required Todo todo,
//   }) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<AppException, bool>> insertTodo({required Todo todo}) async {
//     _todos = _firestore.collection('todos');
//     try {
//       await _todos.add(todo.toMap());
//       return const Right(true);
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   @override
//   Future<Either<AppException, bool>> removeTodo({required String id}) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<AppException, List<Todo>>> allTodos() async {
//     String userId = FirebaseAuth.instance.currentUser!.uid;
//     final getData = await _firestore
//         .collection("todos")
//         .where('userId', isEqualTo: userId)
//         .orderBy('createdDate', descending: true)
//         .get();
//     final List<Todo> todos =
//         getData.docs.map((e) => Todo.fromMap(e.data())).toList();

//     return Right(todos);
//   }
// }
