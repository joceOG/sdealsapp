import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/article.dart';

class DetailsArticleState extends Equatable {
  final Article? article;
  final String? error;
  final int? counterValue;
  final bool isLoading;
  final List<Article> similarArticles;
  final bool isFavorite;
  final bool isAddedToCart;
  final int quantity;

  const DetailsArticleState({
    this.article,
    this.error,
    this.counterValue,
    this.isLoading = false,
    this.similarArticles = const [],
    this.isFavorite = false,
    this.isAddedToCart = false,
    this.quantity = 1,
  });

  factory DetailsArticleState.initial() {
    return const DetailsArticleState(
      article: null,
      error: null,
      counterValue: 0,
      isLoading: false,
      similarArticles: [],
      isFavorite: false,
      isAddedToCart: false,
      quantity: 1,
    );
  }

  DetailsArticleState copyWith({
    Article? article,
    String? error,
    int? counterValue,
    bool? isLoading,
    List<Article>? similarArticles,
    bool? isFavorite,
    bool? isAddedToCart,
    int? quantity,
  }) {
    return DetailsArticleState(
      article: article ?? this.article,
      error: error ?? this.error,
      counterValue: counterValue ?? this.counterValue,
      isLoading: isLoading ?? this.isLoading,
      similarArticles: similarArticles ?? this.similarArticles,
      isFavorite: isFavorite ?? this.isFavorite,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        article,
        error,
        counterValue,
        isLoading,
        similarArticles,
        isFavorite,
        isAddedToCart,
        quantity,
      ];
}
