
import 'package:sdealsapp/web/data/models/service.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageEvent.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageState.dart';

import 'package:bloc/bloc.dart';

import '../../../data/models/categorie.dart';
import '../../../data/services/api_client.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {

  HomePageBloc() : super( HomePageState.initial()) {
    on<LoadCategorieData>(_onLoadCategorieData);
    on<LoadServiceData>(_onLoadServiceData);
  }

  Future<void> _onLoadCategorieData(LoadCategorieData event,
      Emitter<HomePageState> emit,) async {
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

  Future<void> _onLoadServiceData(LoadServiceData event,
      Emitter<HomePageState> emit,) async {
    // String nomgroupe = "Metiers";
    // emit(state.copyWith3(isLoading2: true));
    emit(state.copyWith(isLoading2: true));
    ApiClient apiClient = ApiClient();
    print("Try");
    try {
      var categorieId = "Métiers" ;
      List<Service> list_service = await apiClient.fetchService(categorieId);
      print("List Service");
      emit(state.copyWith(listItems2: list_service, isLoading2: false));
    } catch (error) {
      //   emit(state.copyWith3(error2: error.toString(), isLoading2: false));
      emit(state.copyWith(error2: error.toString(), isLoading2: false));
    }
  }

}