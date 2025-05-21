import 'package:equatable/equatable.dart';

abstract class ConnexionEvent extends Equatable {
  const ConnexionEvent();

  @override
  List<Object> get props => [];
}

class Increment extends ConnexionEvent {}
class Decrement extends ConnexionEvent {}
