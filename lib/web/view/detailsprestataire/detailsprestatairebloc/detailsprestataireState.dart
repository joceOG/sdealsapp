import 'package:equatable/equatable.dart';

class DetailsPrestataireState extends Equatable {
  final int counterValue;

  const DetailsPrestataireState(this.counterValue);

  @override
  List<Object> get props => [counterValue];
}
