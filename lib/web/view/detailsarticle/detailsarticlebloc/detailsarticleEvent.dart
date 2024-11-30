import 'package:equatable/equatable.dart';
import 'package:sdealsapp/web/data/models/article.dart';

abstract class DetailsArticleEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class Increment extends DetailsArticleEvent {}
class Decrement extends DetailsArticleEvent {}
