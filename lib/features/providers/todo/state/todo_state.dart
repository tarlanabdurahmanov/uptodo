import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todolistapp/features/data/models/todo_model.dart';
import 'package:todolistapp/shared/exceptions/http_exception.dart';

part "todo_state.freezed.dart";

@freezed
class TodoState with _$TodoState {
  const factory TodoState.initial() = _Initial;
  const factory TodoState.loading() = _Loading;
  const factory TodoState.error({required AppException message}) = _Error;
  const factory TodoState.allTodo({required List<Todo> todos}) = _All;
}
