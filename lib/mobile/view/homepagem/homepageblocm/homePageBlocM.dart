
import 'package:equatable/equatable.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageBloc.dart';
import 'package:sdealsapp/mobile/view/homepagem/homepageblocm/homePageEventM.dart';
import 'package:sdealsapp/mobile/view/homepagem/homepageblocm/homePageStateM.dart';

import 'package:bloc/bloc.dart';

import '../../../../web/data/models/categorie.dart';
import '../../../../web/data/services/api_client.dart';



class HomePageBlocM extends Bloc<HomePageEventM, HomePageStateM> {

  HomePageBlocM() : super( HomePageStateM.initial()) {
    on<LoadCategorieDataM>(_onLoadCategorieDataM);
  }

  Future<void> _onLoadCategorieDataM(LoadCategorieDataM event,
      Emitter<HomePageStateM> emit,) async {
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