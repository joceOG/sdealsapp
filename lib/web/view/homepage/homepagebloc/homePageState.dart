import 'package:equatable/equatable.dart';

class HomePageState extends Equatable {
  final int counterValue;

  const HomePageState(this.counterValue);

  @override
  List<Object> get props => [counterValue];
}
