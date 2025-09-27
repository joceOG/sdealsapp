import 'package:sdealsapp/data/models/service.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageEvent.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageState.dart';

import 'package:bloc/bloc.dart';

import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/data/services/api_client.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageState.initial()) {
    on<LoadCategorieData>(_onLoadCategorieData);
    on<LoadServiceData>(_onLoadServiceData);
  }

  Future<void> _onLoadCategorieData(
    LoadCategorieData event,
    Emitter<HomePageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    ApiClient apiClient = ApiClient();
    print("🔄 Chargement des catégories...");
    try {
      var nomgroupe = "Métiers";
      List<Categorie> list_categorie =
          await apiClient.fetchCategorie(nomgroupe);
      print("✅ Catégories chargées: ${list_categorie.length}");
      emit(state.copyWith(listItems: list_categorie, isLoading: false));

      // 🔧 CHARGEMENT AUTOMATIQUE DES SERVICES APRÈS LES CATÉGORIES (SEULEMENT SI PAS DÉJÀ CHARGÉS)
      if (state.listItems2 == null) {
        print("🔄 Chargement automatique des services...");
        await _loadServicesAutomatically(emit);
      }
    } catch (error) {
      print("❌ Erreur catégories: $error");
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

  // 🔧 MÉTHODE POUR CHARGER LES SERVICES AUTOMATIQUEMENT
  Future<void> _loadServicesAutomatically(Emitter<HomePageState> emit) async {
    try {
      emit(state.copyWith(isLoading2: true));
      ApiClient apiClient = ApiClient();
      var nomGroupe = "Métiers";
      List<Service> list_service = await apiClient.fetchServices(nomGroupe);
      print("✅ Services chargés: ${list_service.length}");
      emit(state.copyWith(listItems2: list_service, isLoading2: false));
    } catch (error) {
      print("❌ Erreur services: $error");
      emit(state.copyWith(error2: error.toString(), isLoading2: false));
    }
  }

  Future<void> _onLoadServiceData(
    LoadServiceData event,
    Emitter<HomePageState> emit,
  ) async {
    emit(state.copyWith(isLoading2: true));
    ApiClient apiClient = ApiClient();
    print("🔄 Chargement manuel des services...");
    try {
      var nomGroupe = "Métiers";
      List<Service> list_service = await apiClient.fetchServices(nomGroupe);
      print("✅ Services chargés manuellement: ${list_service.length}");
      emit(state.copyWith(listItems2: list_service, isLoading2: false));
    } catch (error) {
      print("❌ Erreur services manuel: $error");
      emit(state.copyWith(error2: error.toString(), isLoading2: false));
    }
  }
}
