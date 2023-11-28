// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'todo_model.g.dart';

// class Todo {
//   final String userId;
//   final int id;
//   final String title;
//   final String description;
//   final bool isCompleted;
//   final DateTime createdDate;
//   final DateTime taskTime;

//   Todo({
//     required this.userId,
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.isCompleted,
//     required this.createdDate,
//     required this.taskTime,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'userId': userId,
//       'id': id,
//       'title': title,
//       'description': description,
//       'isCompleted': isCompleted,
//       'createdDate': createdDate.millisecondsSinceEpoch,
//       'taskTime': taskTime.millisecondsSinceEpoch,
//     };
//   }

//   factory Todo.fromMap(Map<String, dynamic> map) {
//     return Todo(
//       userId: map['userId'] as String,
//       id: map['id'] as int,
//       title: map['title'] as String,
//       description: map['description'] as String,
//       isCompleted: map['isCompleted'] as bool,
//       createdDate:
//           DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
//       taskTime: DateTime.fromMillisecondsSinceEpoch(map['taskTime'] as int),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Todo.fromJson(String source) =>
//       Todo.fromMap(json.decode(source) as Map<String, dynamic>);
// }

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final int? id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final bool isCompleted;
  @HiveField(5)
  final DateTime createdDate = DateTime.now();
  @HiveField(6)
  final String? taskTime;
  @HiveField(7)
  final int? categoryId;
  @HiveField(8)
  final int? priority;

  Todo({
    required this.userId,
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.taskTime,
    this.categoryId = 1,
    this.priority = 1,
  });
}
