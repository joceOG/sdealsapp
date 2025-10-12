import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/article.dart';

class DetailsArticleState extends Equatable {
  final Article? article;
  final List<Article> similarArticles;
  final bool isLoading;
  final bool isFavorite;
  final int quantity;
  final String? error;
  final bool isAddedToCart;

  const DetailsArticleState({
    this.article,
    this.similarArticles = const [],
    this.isLoading = false,
    this.isFavorite = false,
    this.quantity = 1,
    this.error,
    this.isAddedToCart = false,
  });

  factory DetailsArticleState.initial() {
    return const DetailsArticleState(
      article: null,
      similarArticles: [],
      isLoading: false,
      isFavorite: false,
      quantity: 1,
      error: null,
      isAddedToCart: false,
    );
  }

  DetailsArticleState copyWith({
    Article? article,
    List<Article>? similarArticles,
    bool? isLoading,
    bool? isFavorite,
    int? quantity,
    String? error,
    bool? isAddedToCart,
  }) {
    return DetailsArticleState(
      article: article ?? this.article,
      similarArticles: similarArticles ?? this.similarArticles,
      isLoading: isLoading ?? this.isLoading,
      isFavorite: isFavorite ?? this.isFavorite,
      quantity: quantity ?? this.quantity,
      error: error ?? this.error,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
    );
  }

  @override
  List<Object?> get props => [
        article,
        similarArticles,
        isLoading,
        isFavorite,
        quantity,
        error,
        isAddedToCart,
      ];
}
