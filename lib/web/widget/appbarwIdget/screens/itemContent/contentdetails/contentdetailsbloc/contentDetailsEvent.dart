import 'package:equatable/equatable.dart';

abstract class ContentDetailsEvent extends Equatable  {
  const ContentDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadServiceData extends ContentDetailsEvent {

  final String nomGroupe;
  const LoadServiceData({required this.nomGroupe});

  @override
  List<Object> get props => [nomGroupe];

}

