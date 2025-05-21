import 'package:equatable/equatable.dart';

class ArticleState extends Equatable {
  final int counterValue;

  const ArticleState(this.counterValue);

  @override
  List<Object> get props => [counterValue];
}
