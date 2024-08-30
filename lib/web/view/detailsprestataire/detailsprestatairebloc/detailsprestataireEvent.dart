import 'package:equatable/equatable.dart';

abstract class DetailsPrestataireEvent extends Equatable {
  const DetailsPrestataireEvent();

  @override
  List<Object> get props => [];
}

class Increment extends DetailsPrestataireEvent {}
class Decrement extends DetailsPrestataireEvent {}
