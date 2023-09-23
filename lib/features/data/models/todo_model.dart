// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  final String userId;
  final int id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdDate;
  final DateTime taskTime;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdDate,
    required this.taskTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'taskTime': taskTime.millisecondsSinceEpoch,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      userId: map['userId'] as String,
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool,
      createdDate:
          DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
      taskTime: DateTime.fromMillisecondsSinceEpoch(map['taskTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
