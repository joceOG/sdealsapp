import 'package:sdealsapp/mobile/view/freelancepagem/freelancepageblocm/freelancePageEventM.dart';
import 'package:sdealsapp/mobile/view/freelancepagem/freelancepageblocm/freelancePageStateM.dart';
import 'package:sdealsapp/mobile/view/freelancepagem/models/freelance_model.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../web/data/models/categorie.dart';
import '../../../../web/data/services/api_client.dart';

class FreelancePageBlocM extends Bloc<FreelancePageEventM, FreelancePageStateM> {
  FreelancePageBlocM() : super(FreelancePageStateM.initial()) {
    on<LoadCategorieDataM>(_onLoadCategorieDataM);
    on<LoadFreelancersEvent>(_onLoadFreelancers);
    on<FilterByCategoryEvent>(_onFilterByCategory);
    on<SearchFreelancerEvent>(_onSearchFreelancer);
    on<ClearFiltersEvent>(_onClearFilters);
  }

  Future<void> _onLoadCategorieDataM(
    LoadCategorieDataM event,
    Emitter<FreelancePageStateM> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    ApiClient apiClient = ApiClient();
    try {
      // Revenir à l'ancien nom du groupe qui fonctionne
      var nomgroupe = "Freelance";  // Sans trait d'union
      print("Chargement des catégories pour le groupe: $nomgroupe");
      List<Categorie> list_categorie = await apiClient.fetchCategorie(nomgroupe);
      
      // Charger également les freelancers par défaut
      add(LoadFreelancersEvent());
      
      emit(state.copyWith(listItems: list_categorie, isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      if (kDebugMode) {
        print("Erreur chargement catégories: $error");
      }
    }
  }

  Future<void> _onLoadFreelancers(
    LoadFreelancersEvent event,
    Emitter<FreelancePageStateM> emit,
  ) async {
    // Si nous avions une API réelle, nous appellerions le service ici
    // Pour l'instant, nous utilisons des données fictives
    try {
      final List<FreelanceModel> freelancers = getMockFreelancers();
      emit(state.copyWith(
        freelancers: freelancers,
        filteredFreelancers: freelancers,
      ));
    } catch (error) {
      if (kDebugMode) {
        print("Erreur chargement freelancers: $error");
      }
    }
  }

  void _onFilterByCategory(
    FilterByCategoryEvent event,
    Emitter<FreelancePageStateM> emit,
  ) {
    final category = event.category;
    
    if (category == null || category == 'Tous') {
      // Si aucune catégorie ou 'Tous' est sélectionnée, montrer tous les freelancers
      emit(state.copyWith(
        selectedCategory: category,
        filteredFreelancers: _applySearch(state.freelancers, state.searchQuery),
      ));
    } else {
      // Filtrer les freelancers par catégorie
      final filtered = state.freelancers
          .where((freelancer) => freelancer.category == category)
          .toList();
          
      emit(state.copyWith(
        selectedCategory: category,
        filteredFreelancers: _applySearch(filtered, state.searchQuery),
      ));
    }
  }

  void _onSearchFreelancer(
    SearchFreelancerEvent event,
    Emitter<FreelancePageStateM> emit,
  ) {
    final query = event.query.toLowerCase();
    
    // Appliquer d'abord le filtre de catégorie s'il existe
    List<FreelanceModel> categoryFiltered = state.freelancers;
    if (state.selectedCategory != null && state.selectedCategory != 'Tous') {
      categoryFiltered = state.freelancers
          .where((freelancer) => freelancer.category == state.selectedCategory)
          .toList();
    }
    
    // Appliquer ensuite la recherche sur les résultats filtrés par catégorie
    final List<FreelanceModel> searchFiltered = _applySearch(categoryFiltered, query);
    
    emit(state.copyWith(
      searchQuery: query,
      filteredFreelancers: searchFiltered,
    ));
  }
  
  void _onClearFilters(
    ClearFiltersEvent event,
    Emitter<FreelancePageStateM> emit,
  ) {
    emit(state.copyWith(
      selectedCategory: null,
      searchQuery: '',
      filteredFreelancers: state.freelancers,
    ));
  }
  
  // Méthode utilitaire pour appliquer la recherche
  List<FreelanceModel> _applySearch(List<FreelanceModel> freelancers, String query) {
    if (query.isEmpty) {
      return freelancers;
    }
    
    return freelancers.where((freelancer) {
      return freelancer.name.toLowerCase().contains(query) ||
             freelancer.job.toLowerCase().contains(query) ||
             freelancer.description.toLowerCase().contains(query) ||
             freelancer.skills.any((skill) => skill.toLowerCase().contains(query));
    }).toList();
  }
}