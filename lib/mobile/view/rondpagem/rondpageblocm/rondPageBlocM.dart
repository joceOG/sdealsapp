import 'package:sdealsapp/mobile/view/rondpagem/rondpageblocm/rondPageEventM.dart';
import 'package:sdealsapp/mobile/view/rondpagem/rondpageblocm/rondPageStateM.dart';

import 'package:bloc/bloc.dart';

import '../../../../web/data/models/categorie.dart';
import '../../../../web/data/services/api_client.dart';



class RondPageBlocM extends Bloc<RondPageEventM, RondPageStateM> {

  RondPageBlocM() : super( RondPageStateM.initial()) {
    on<LoadCategorieDataM>(_onLoadCategorieDataM);
  }

  Future<void> _onLoadCategorieDataM(LoadCategorieDataM event,
      Emitter<RondPageStateM> emit,) async {
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