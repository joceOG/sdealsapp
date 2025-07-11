import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../data/models/commande_model.dart';

@immutable
class CommandeState extends Equatable {
  final bool isLoading;
  final List<CommandeModel> commandes;
  final String? error;
  final String? searchQuery;
  final CommandeStatus? filtreStatus;

  const CommandeState({
    required this.isLoading,
    required this.commandes,
    this.error,
    this.searchQuery,
    this.filtreStatus,
  });

  // État initial
  factory CommandeState.initial() {
    return const CommandeState(
      isLoading: true,
      commandes: [],
    );
  }

  // Méthode pour filtrer les commandes selon le statut
  List<CommandeModel> get commandesFiltrees {
    if (filtreStatus == null) {
      // Si aucun filtre, on renvoie toutes les commandes
      return commandes.where((commande) {
        // Applique le filtre de recherche si présent
        if (searchQuery != null && searchQuery!.isNotEmpty) {
          return commande.prestataireName.toLowerCase().contains(searchQuery!.toLowerCase()) ||
              commande.typeService.toLowerCase().contains(searchQuery!.toLowerCase());
        }
        return true;
      }).toList();
    }
    
    // Filtre par statut et recherche si applicable
    return commandes.where((commande) {
      bool matchStatus = commande.status == filtreStatus;
      
      if (searchQuery != null && searchQuery!.isNotEmpty) {
        bool matchSearch = commande.prestataireName.toLowerCase().contains(searchQuery!.toLowerCase()) ||
            commande.typeService.toLowerCase().contains(searchQuery!.toLowerCase());
        return matchStatus && matchSearch;
      }
      
      return matchStatus;
    }).toList();
  }

  // Obtenir le nombre de commandes par statut
  int getNombreCommandesParStatus(CommandeStatus status) {
    return commandes.where((commande) => commande.status == status).length;
  }

  // Vérifier si la liste filtrée est vide
  bool get isEmpty => commandesFiltrees.isEmpty;

  // Méthode pour créer une nouvelle instance avec des valeurs modifiées
  CommandeState copyWith({
    bool? isLoading,
    List<CommandeModel>? commandes,
    String? error,
    String? searchQuery,
    CommandeStatus? filtreStatus,
  }) {
    return CommandeState(
      isLoading: isLoading ?? this.isLoading,
      commandes: commandes ?? this.commandes,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
      filtreStatus: filtreStatus,
    );
  }

  @override
  List<Object?> get props => [isLoading, commandes, error, searchQuery, filtreStatus];
}
