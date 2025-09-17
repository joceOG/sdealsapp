import 'package:sdealsapp/mobile/view/searchpagem/searchpageblocm/searchPageEventM.dart';
import 'package:sdealsapp/mobile/view/searchpagem/searchpageblocm/searchPageStateM.dart';

import 'package:bloc/bloc.dart';

import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/data/services/api_client.dart';



class SearchPageBlocM extends Bloc<SearchPageEventM, SearchPageStateM> {

  SearchPageBlocM() : super( SearchPageStateM.initial()) {
    on<LoadCategorieDataM>(_onLoadCategorieDataM);
  }

  Future<void> _onLoadCategorieDataM(LoadCategorieDataM event,
      Emitter<SearchPageStateM> emit,) async {
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

}