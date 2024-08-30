import 'package:equatable/equatable.dart';

abstract class PrestataireEvent extends Equatable {
  const PrestataireEvent();

  @override
  List<Object> get props => [];
}

class Increment extends PrestataireEvent {}
class Decrement extends PrestataireEvent {}
