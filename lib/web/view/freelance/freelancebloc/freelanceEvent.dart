import 'package:equatable/equatable.dart';

abstract class FreelanceEvent extends Equatable {
  const FreelanceEvent();

  @override
  List<Object> get props => [];
}

class Increment extends FreelanceEvent {}
class Decrement extends FreelanceEvent {}
