import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceEvent.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceState.dart';

import 'package:bloc/bloc.dart';

import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/data/models/service.dart';
import 'package:sdealsapp/data/services/api_client.dart';

class FreelanceBloc extends Bloc<FreelanceEvent, FreelanceState> {
  FreelanceBloc() : super(FreelanceState.initial()) {
    on<LoadCategorieDataF>(_onLoadCategorieDataF);
    on<LoadServiceDataF>(_onLoadServiceDataF);
  }

  Future<void> _onLoadCategorieDataF(
    LoadCategorieDataF event,
    Emitter<FreelanceState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    ApiClient apiClient = ApiClient();
    print("🔄 Chargement des catégories Freelance...");
    try {
      var nomgroupe =
          "Freelance"; // CORRECTION: Groupe Freelance au lieu de Métiers
      List<Categorie> list_categorie =
          await apiClient.fetchCategorie(nomgroupe);
      print("✅ Catégories Freelance chargées: ${list_categorie.length}");
      emit(state.copyWith(listItems: list_categorie, isLoading: false));
    } catch (error) {
      print("❌ Erreur catégories Freelance: $error");
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

  Future<void> _onLoadServiceDataF(
    LoadServiceDataF event,
    Emitter<FreelanceState> emit,
  ) async {
    emit(state.copyWith(isLoading2: true));
    ApiClient apiClient = ApiClient();
    print("🔄 Chargement des services Freelance...");
    try {
      var nomgroupe =
          "Freelance"; // CORRECTION: Groupe Freelance au lieu de Métiers
      List<Service> list_service = await apiClient.fetchServices(nomgroupe);
      print("✅ Services Freelance chargés: ${list_service.length}");
      emit(state.copyWith(listItems2: list_service, isLoading2: false));
    } catch (error) {
      print("❌ Erreur services Freelance: $error");
      emit(state.copyWith(error2: error.toString(), isLoading2: false));
    }
  }
}
