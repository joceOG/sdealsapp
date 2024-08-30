import 'package:equatable/equatable.dart';

class PrestataireState extends Equatable {
  final int counterValue;

  const PrestataireState(this.counterValue);

  @override
  List<Object> get props => [counterValue];
}
