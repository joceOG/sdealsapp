import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/article.dart';

abstract class DetailsArticleEvent extends Equatable {
  const DetailsArticleEvent();

  @override
  List<Object> get props => [];
}

class LoadArticleDetails extends DetailsArticleEvent {
  final String articleId;

  const LoadArticleDetails({required this.articleId});

  @override
  List<Object> get props => [articleId];
}

class LoadSimilarArticles extends DetailsArticleEvent {
  final String categoryId;

  const LoadSimilarArticles({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class ToggleFavorite extends DetailsArticleEvent {
  final String articleId;

  const ToggleFavorite({required this.articleId});

  @override
  List<Object> get props => [articleId];
}

class AddToCart extends DetailsArticleEvent {
  final String articleId;
  final int quantity;

  const AddToCart({
    required this.articleId,
    required this.quantity,
  });

  @override
  List<Object> get props => [articleId, quantity];
}

class UpdateQuantity extends DetailsArticleEvent {
  final int quantity;

  const UpdateQuantity({required this.quantity});

  @override
  List<Object> get props => [quantity];
}

class ShareArticle extends DetailsArticleEvent {
  final Article article;

  const ShareArticle({required this.article});

  @override
  List<Object> get props => [article];
}

class ClearError extends DetailsArticleEvent {
  const ClearError();
}
