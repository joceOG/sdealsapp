import 'package:equatable/equatable.dart';

abstract class FreelanceEvent extends Equatable {
  const FreelanceEvent();

  @override
  List<Object> get props => [];
}

class LoadCategorieDataF extends FreelanceEvent {}

class LoadServiceDataF extends FreelanceEvent {}
