import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sdealsapp/data/services/api_client.dart'; // Pour utilisation future
import 'package:sdealsapp/data/models/article.dart';
import 'detailsarticleEvent.dart';
import 'detailsarticleState.dart';

class DetailsArticleBloc
    extends Bloc<DetailsArticleEvent, DetailsArticleState> {
  // final ApiClient _apiClient = ApiClient(); // Pour utilisation future

  DetailsArticleBloc() : super(DetailsArticleState.initial()) {
    on<LoadArticleDetails>(_onLoadArticleDetails);
    on<LoadSimilarArticles>(_onLoadSimilarArticles);
    on<ToggleFavorite>(_onToggleFavorite);
    on<AddToCart>(_onAddToCart);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<ShareArticle>(_onShareArticle);
    on<ClearError>(_onClearError);
  }

  Future<void> _onLoadArticleDetails(
    LoadArticleDetails event,
    Emitter<DetailsArticleState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      print('🔄 Chargement des détails de l\'article: ${event.articleId}');

      // Simuler le chargement des détails
      // Dans une vraie app, on ferait un appel API
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(
        isLoading: false,
        article: state.article, // Garder l'article existant
      ));
    } catch (e) {
      print('❌ Erreur chargement détails: $e');
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLoadSimilarArticles(
    LoadSimilarArticles event,
    Emitter<DetailsArticleState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      print(
          '🔄 Chargement des articles similaires pour catégorie: ${event.categoryId}');

      // Simuler le chargement des articles similaires
      await Future.delayed(const Duration(seconds: 1));

      // Créer des articles similaires fictifs
      final similarArticles = List.generate(5, (index) {
        return Article(
          nomArticle: 'Article similaire ${index + 1}',
          prixArticle: '${25000 + (index * 5000)} FCFA',
          quantiteArticle: 1,
          photoArticle: 'assets/autreArticle${(index % 4) + 1}.png',
        );
      });

      emit(state.copyWith(
        isLoading: false,
        similarArticles: similarArticles,
      ));
    } catch (e) {
      print('❌ Erreur chargement articles similaires: $e');
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<DetailsArticleState> emit,
  ) async {
    try {
      print('🔄 Toggle favori pour article: ${event.articleId}');

      // Simuler l'ajout/suppression des favoris
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(
        isFavorite: !state.isFavorite,
      ));
    } catch (e) {
      print('❌ Erreur toggle favori: $e');
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<DetailsArticleState> emit,
  ) async {
    try {
      print(
          '🔄 Ajout au panier: ${event.articleId} (quantité: ${event.quantity})');

      // Simuler l'ajout au panier
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(
        isAddedToCart: true,
      ));

      // Reset après 2 secondes
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isAddedToCart: false));
    } catch (e) {
      print('❌ Erreur ajout panier: $e');
      emit(state.copyWith(
        error: e.toString(),
      ));
    }
  }

  void _onUpdateQuantity(
    UpdateQuantity event,
    Emitter<DetailsArticleState> emit,
  ) {
    print('🔄 Mise à jour quantité: ${event.quantity}');
    emit(state.copyWith(quantity: event.quantity));
  }

  void _onShareArticle(
    ShareArticle event,
    Emitter<DetailsArticleState> emit,
  ) {
    print('🔄 Partage article: ${event.article.nomArticle}');
    // Logique de partage (réseaux sociaux, etc.)
  }

  void _onClearError(
    ClearError event,
    Emitter<DetailsArticleState> emit,
  ) {
    emit(state.copyWith(error: null));
  }
}
