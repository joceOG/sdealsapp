import 'package:equatable/equatable.dart';

abstract class EmarcheEvent extends Equatable {
  const EmarcheEvent();

  @override
  List<Object> get props => [];
}

class LoadCategorieEData extends EmarcheEvent {}
class LoadServiceData extends EmarcheEvent {}
