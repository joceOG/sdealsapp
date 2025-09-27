import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/data/models/article.dart';
import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/data/models/vendeur.dart';
import 'package:sdealsapp/data/services/api_client.dart';
import 'emarcheEvent.dart';
import 'emarcheState.dart';

class EmarcheBloc extends Bloc<EmarcheEvent, EmarcheState> {
  EmarcheBloc() : super(EmarcheState.initial()) {
    on<LoadCategorieEData>(_onLoadCategorieEData);
    on<LoadServiceEData>(_onLoadServiceEData);
    on<LoadVendeursEData>(_onLoadVendeursEData);
  }

  Future<void> _onLoadCategorieEData(
    LoadCategorieEData event,
    Emitter<EmarcheState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    ApiClient apiClient = ApiClient();
    print("🔄 Chargement des catégories Emarche...");
    try {
      var nomgroupe =
          "E-marché"; // CORRECTION: Groupe E-marché (avec trait d'union et accent)
      List<Categorie> list_categorie =
          await apiClient.fetchCategorie(nomgroupe);
      print("✅ Catégories Emarche chargées: ${list_categorie.length}");
      emit(state.copyWith(listItems: list_categorie, isLoading: false));
    } catch (error) {
      print("❌ Erreur catégories Emarche: $error");
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

  Future<void> _onLoadServiceEData(
    LoadServiceEData event,
    Emitter<EmarcheState> emit,
  ) async {
    emit(state.copyWith(isLoading2: true));
    ApiClient apiClient = ApiClient();
    print("🔄 Chargement des articles Emarche...");
    try {
      List<Article> list_article = await apiClient.fetchArticle();
      print("✅ Articles Emarche chargés: ${list_article.length}");
      emit(state.copyWith(listItems2: list_article, isLoading2: false));
    } catch (error) {
      print("❌ Erreur articles Emarche: $error");
      emit(state.copyWith(error2: error.toString(), isLoading2: false));
    }
  }

  Future<void> _onLoadVendeursEData(
    LoadVendeursEData event,
    Emitter<EmarcheState> emit,
  ) async {
    emit(state.copyWith(isLoading3: true));
    ApiClient apiClient = ApiClient();
    print("🔄 Chargement des vendeurs Emarche...");
    try {
      List<Map<String, dynamic>> vendeursData = await apiClient.fetchVendeurs();
      List<Vendeur> list_vendeurs =
          vendeursData.map((data) => Vendeur.fromJson(data)).toList();
      print("✅ Vendeurs Emarche chargés: ${list_vendeurs.length}");
      emit(state.copyWith(listItems3: list_vendeurs, isLoading3: false));
    } catch (error) {
      print("❌ Erreur vendeurs Emarche: $error");
      emit(state.copyWith(error3: error.toString(), isLoading3: false));
    }
  }
}
