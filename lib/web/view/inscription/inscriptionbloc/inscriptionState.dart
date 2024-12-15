import 'package:equatable/equatable.dart';

class Inscriptionstate extends Equatable {
  final int counterValue;

  const Inscriptionstate(this.counterValue);

  @override
  List<Object> get props => [counterValue];
}
