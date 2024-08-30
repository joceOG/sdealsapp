import 'package:equatable/equatable.dart';

class ConnexionState extends Equatable {
  final int counterValue;

  const ConnexionState(this.counterValue);

  @override
  List<Object> get props => [counterValue];
}
