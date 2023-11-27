part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeFetchEvent extends HomeEvent {
  const HomeFetchEvent();
}

class HomeLoadingEvent extends HomeEvent {
  const HomeLoadingEvent();
}
