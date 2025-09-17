
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // Import pour RangeValues

import 'package:sdealsapp/data/models/categorie.dart';

// Définition du modèle Product pour éviter l'import cyclique
class Product {
  final String id;
  final String name;
  final String image;
  final String size;
  final String price;
  final String brand;
  final bool isFavorite;
  final double rating;

  const Product({
    required this.name,
    required this.image,
    required this.size,
    required this.price,
    this.id = '',
    this.brand = 'Générique',
    this.isFavorite = false,
    this.rating = 4.5,
  });
}


class ShoppingPageStateM extends Equatable {
  // États d'origine pour les catégories
  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;
  
  // Nouveaux états pour la gestion des produits
  final List<Product>? products; // Liste de tous les produits
  final List<Product>? filteredProducts; // Liste des produits filtrés
  final List<String>? favoriteProductIds; // IDs des produits favoris
  final List<Product>? productsToCompare; // Produits sélectionnés pour comparaison
  
  // États pour les filtres
  final String? selectedFilter; // Filtre actuellement sélectionné
  final String? searchQuery; // Texte de recherche
  final String? selectedBrand; // Marque sélectionnée
  final RangeValues? priceRange; // Plage de prix sélectionnée
  final String? selectedCondition; // État sélectionné (neuf, bon état, etc.)
  final String? selectedDelivery; // Type de livraison sélectionné
  final String? selectedLocation; // Localisation sélectionnée

  const ShoppingPageStateM({
    this.isLoading,
    this.listItems,
    this.error,
    this.products,
    this.filteredProducts,
    this.favoriteProductIds,
    this.productsToCompare,
    this.selectedFilter,
    this.searchQuery,
    this.selectedBrand,
    this.priceRange,
    this.selectedCondition,
    this.selectedDelivery,
    this.selectedLocation,
  });

  factory ShoppingPageStateM.initial() {
    return const ShoppingPageStateM(
      isLoading: true,
      listItems: null,
      error: '',
      products: null,
      filteredProducts: null,
      favoriteProductIds: [],
      productsToCompare: [],
      selectedFilter: '',
      searchQuery: '',
      selectedBrand: null,
      priceRange: null,
      selectedCondition: null,
      selectedDelivery: null,
      selectedLocation: null,
    );
  }

  ShoppingPageStateM copyWith({
    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
    List<Product>? products,
    List<Product>? filteredProducts,
    List<String>? favoriteProductIds,
    List<Product>? productsToCompare,
    String? selectedFilter,
    String? searchQuery,
    String? selectedBrand,
    RangeValues? priceRange,
    String? selectedCondition,
    String? selectedDelivery,
    String? selectedLocation,
  }) {
    return ShoppingPageStateM(
      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds,
      productsToCompare: productsToCompare ?? this.productsToCompare,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      priceRange: priceRange ?? this.priceRange,
      selectedCondition: selectedCondition ?? this.selectedCondition,
      selectedDelivery: selectedDelivery ?? this.selectedDelivery,
      selectedLocation: selectedLocation ?? this.selectedLocation,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        listItems,
        error,
        products,
        filteredProducts,
        favoriteProductIds,
        productsToCompare,
        selectedFilter,
        searchQuery,
        selectedBrand,
        priceRange,
        selectedCondition,
        selectedDelivery,
        selectedLocation,
      ];
}









