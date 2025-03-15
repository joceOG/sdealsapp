import 'package:equatable/equatable.dart';

abstract class ContentDetailsEvent extends Equatable  {
  const ContentDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadServiceData extends ContentDetailsEvent {

  final String categorieid;
  const LoadServiceData({required this.categorieid});

  @override
  List<Object> get props => [categorieid];

}

