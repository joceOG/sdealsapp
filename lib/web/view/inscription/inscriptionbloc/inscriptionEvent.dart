import 'package:equatable/equatable.dart';

abstract class InscriptionEvent extends Equatable {
  const InscriptionEvent();

  @override
  List<Object> get props => [];
}

class Increment extends InscriptionEvent {}
class Decrement extends InscriptionEvent {}
