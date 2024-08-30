import 'package:equatable/equatable.dart';

abstract class EmarcheEvent extends Equatable {
  const EmarcheEvent();

  @override
  List<Object> get props => [];
}

class Increment extends EmarcheEvent {}
class Decrement extends EmarcheEvent {}
