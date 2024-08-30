import 'package:equatable/equatable.dart';

class EmarcheState extends Equatable {
  final int counterValue;

  const EmarcheState(this.counterValue);

  @override
  List<Object> get props => [counterValue];
}
