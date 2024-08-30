import 'package:equatable/equatable.dart';

class FreelanceState extends Equatable {
  final int counterValue;

  const FreelanceState(this.counterValue);

  @override
  List<Object> get props => [counterValue];
}
