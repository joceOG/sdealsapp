import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class Increment extends HomePageEvent {}
class Decrement extends HomePageEvent {}
