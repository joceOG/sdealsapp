

import 'package:equatable/equatable.dart';

abstract class AppBarWidgetEvent extends Equatable  {
  const AppBarWidgetEvent();

  @override
  List<Object> get props => [];
}

class HoverMenuEvent extends AppBarWidgetEvent {
  final String nomgroupe;

  const HoverMenuEvent({required this.nomgroupe});

  @override
  List<Object> get props => [nomgroupe];
}

class LoadCategorieData extends AppBarWidgetEvent {

  final String nomgroupe;

  const LoadCategorieData({required this.nomgroupe});

  @override
  List<Object> get props => [nomgroupe];

}