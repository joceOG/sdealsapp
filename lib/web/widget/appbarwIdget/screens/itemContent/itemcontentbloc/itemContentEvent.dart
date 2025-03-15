import 'package:equatable/equatable.dart';

abstract class ItemContentEvent extends Equatable  {
  const ItemContentEvent();

  @override
  List<Object> get props => [];
}

class LoadCategorieData extends ItemContentEvent {}

