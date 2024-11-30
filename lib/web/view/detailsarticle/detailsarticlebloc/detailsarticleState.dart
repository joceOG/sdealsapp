import 'package:equatable/equatable.dart';
import 'package:sdealsapp/web/data/models/article.dart';

class DetailsArticleState extends Equatable {
  final Article? article;
  final String? error;
  final int? counterValue;

  const DetailsArticleState({
    this.article,
    this.error,
    this.counterValue,
  });

  factory DetailsArticleState.initial() {
    return const DetailsArticleState(
      article:null,
      error: '',
      counterValue: 0,
    );
  }

  DetailsArticleState copyWith({

    Article? article,
    String? error,
    int? counterValue,
  }){
    return  DetailsArticleState(
      article: article ?? this.article,
      error: error ?? this.error,
      counterValue: counterValue ?? this.counterValue,
    );
  }

  @override
  List<Object?> get props => [article,error,counterValue];
}
