part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeStateSuccess extends HomeState {
  final List<TodoHiveModel>? todos;

  const HomeStateSuccess(this.todos);
}

class HomeStateError extends HomeState {
  final String message;
  const HomeStateError(this.message);
}
