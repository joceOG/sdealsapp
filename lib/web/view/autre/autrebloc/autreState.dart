import 'package:equatable/equatable.dart';

class AutreState extends Equatable {
  final int counterValue;

  const AutreState(this.counterValue);

  @override
  List<Object> get props => [counterValue];
}
