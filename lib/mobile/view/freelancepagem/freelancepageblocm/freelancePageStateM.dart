import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../web/data/models/categorie.dart';
import '../models/freelance_model.dart';

class FreelancePageStateM extends Equatable {

  final bool isLoading;
  final List<Categorie>? listItems;
  final String? error;
  
  // Nouveaux champs pour la gestion des freelancers
  final List<FreelanceModel> freelancers;
  final List<FreelanceModel> filteredFreelancers;
  final String? selectedCategory;
  final String searchQuery;

  const FreelancePageStateM({
    required this.isLoading,
    required this.listItems,
    required this.error,
    required this.freelancers,
    required this.filteredFreelancers,
    required this.selectedCategory,
    required this.searchQuery,
  });

  factory FreelancePageStateM.initial() {
    return const FreelancePageStateM(
      isLoading: false,
      listItems: null,
      error: null,
      freelancers: [],
      filteredFreelancers: [],
      selectedCategory: null,
      searchQuery: '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        listItems,
        error,
        freelancers,
        filteredFreelancers,
        selectedCategory,
        searchQuery,
      ];

  FreelancePageStateM copyWith({
    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
    List<FreelanceModel>? freelancers,
    List<FreelanceModel>? filteredFreelancers,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return FreelancePageStateM(
      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
      freelancers: freelancers ?? this.freelancers,
      filteredFreelancers: filteredFreelancers ?? this.filteredFreelancers,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}






