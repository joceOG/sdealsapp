import 'package:equatable/equatable.dart';

abstract class AutreEvent extends Equatable {
  const AutreEvent();

  @override
  List<Object> get props => [];
}

class Increment extends AutreEvent {}
class Decrement extends AutreEvent {}
