import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceEvent.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceState.dart';

import 'package:bloc/bloc.dart';

import '../../../data/models/categorie.dart';
import '../../../data/services/api_client.dart';

class FreelanceBloc extends Bloc<FreelanceEvent, FreelanceState> {

  FreelanceBloc() : super( FreelanceState.initial()) {
    on<LoadCategorieDataF>(_onLoadCategorieDataF);
  }

  Future<void> _onLoadCategorieDataF(LoadCategorieDataF event,
      Emitter<FreelanceState> emit,) async {
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