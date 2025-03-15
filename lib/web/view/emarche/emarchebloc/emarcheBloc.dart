import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/web/data/models/article.dart';
import '../../../data/models/categorie.dart';
import '../../../data/services/api_client.dart';
import 'emarcheEvent.dart';
import 'emarcheState.dart';

class EmarcheBloc extends Bloc<EmarcheEvent, EmarcheState> {

  EmarcheBloc() : super( EmarcheState.initial() ) {
    on<LoadCategorieEData>(_onLoadCategorieEData);
    on<LoadServiceEData>(_onLoadServiceEData);
  }

  Future<void> _onLoadCategorieEData(LoadCategorieEData event,
      Emitter<EmarcheState> emit,) async {
    // String nomgroupe = "Metiers";
    // emit(state.copyWith3(isLoading2: true));
    emit(state.copyWith(isLoading: true));
    ApiClient apiClient = ApiClient();
    print("Try");
    try {
      var nomgroupe = "Métiers" ;
      List<Categorie> list_categorie = await apiClient.fetchCategorie(nomgroupe);
      print("List Categorie");
      emit(state.copyWith(listItems: list_categorie, isLoading: false));
    } catch (error) {
      //   emit(state.copyWith3(error2: error.toString(), isLoading2: false));
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

  Future<void> _onLoadServiceEData(LoadServiceEData event,
      Emitter<EmarcheState> emit,) async {
    // String nomgroupe = "Metiers";
    // emit(state.copyWith3(isLoading2: true));
    emit(state.copyWith(isLoading2: true));
    ApiClient apiClient = ApiClient();
    print("Try");
    try {
      List<Article> list_article = await apiClient.fetchArticle();
      print("List Article");
      emit(state.copyWith(listItems2: list_article, isLoading2: false));
    } catch (error) {
      //   emit(state.copyWith3(error2: error.toString(), isLoading2: false));
      emit(state.copyWith(error2: error.toString(), isLoading2: false));
    }
  }

}
