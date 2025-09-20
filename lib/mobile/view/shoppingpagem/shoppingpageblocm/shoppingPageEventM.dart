import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sdealsapp/data/models/categorie.dart';

import 'shoppingPageStateM.dart';

abstract class ShoppingPageEventM extends Equatable {
  const ShoppingPageEventM();

  @override
  List<Object> get props => [];
}

// Événements d'origine
class LoadCategorieDataM extends ShoppingPageEventM {}

// Nouveaux événements pour la gestion des produits
class LoadProductsEvent extends ShoppingPageEventM {}

// Événements pour le filtrage des produits
class ApplyFilterEvent extends ShoppingPageEventM {
  final String filterName;

  const ApplyFilterEvent(this.filterName);

  @override
  List<Object> get props => [filterName];
}

class SearchProductsEvent extends ShoppingPageEventM {
  final String query;

  const SearchProductsEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ApplyPriceRangeEvent extends ShoppingPageEventM {
  final RangeValues priceRange;

  const ApplyPriceRangeEvent(this.priceRange);

  @override
  List<Object> get props => [priceRange];
}

class SelectBrandEvent extends ShoppingPageEventM {
  final String brand;

  const SelectBrandEvent(this.brand);

  @override
  List<Object> get props => [brand];
}

class SelectConditionEvent extends ShoppingPageEventM {
  final String condition;

  const SelectConditionEvent(this.condition);

  @override
  List<Object> get props => [condition];
}

class SelectDeliveryEvent extends ShoppingPageEventM {
  final String delivery;

  const SelectDeliveryEvent(this.delivery);

  @override
  List<Object> get props => [delivery];
}

class SelectLocationEvent extends ShoppingPageEventM {
  final String location;

  const SelectLocationEvent(this.location);

  @override
  List<Object> get props => [location];
}

class ResetFiltersEvent extends ShoppingPageEventM {}

// Événements pour la gestion des favoris
class ToggleFavoriteEvent extends ShoppingPageEventM {
  final String productId;

  const ToggleFavoriteEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

// Événements pour la comparaison de produits
class AddToCompareEvent extends ShoppingPageEventM {
  final Product product;

  const AddToCompareEvent(this.product);

  @override
  List<Object> get props => [product];
}

class RemoveFromCompareEvent extends ShoppingPageEventM {
  final String productId;

  const RemoveFromCompareEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class ClearCompareListEvent extends ShoppingPageEventM {}

// Événement pour les filtres avancés
class ApplyAdvancedFiltersEvent extends ShoppingPageEventM {
  final double minPrice;
  final double maxPrice;
  final String? brand;
  final String? size;
  final bool onlyInStock;

  const ApplyAdvancedFiltersEvent({
    required this.minPrice,
    required this.maxPrice,
    this.brand,
    this.size,
    this.onlyInStock = false,
  });

  @override
  List<Object> get props => [
        minPrice,
        maxPrice,
        brand ?? '',
        size ?? '',
        onlyInStock,
      ];
}

// ✅ NOUVEAUX ÉVÉNEMENTS POUR LES VENDEURS

// Événement pour charger les vendeurs
class LoadVendeursEvent extends ShoppingPageEventM {}

// Événement pour basculer entre produits et vendeurs
class ToggleViewEvent extends ShoppingPageEventM {
  final bool showVendeurs;

  const ToggleViewEvent({required this.showVendeurs});

  @override
  List<Object> get props => [showVendeurs];
}

// Événement pour filtrer les vendeurs
class FilterVendeursEvent extends ShoppingPageEventM {
  final String? searchQuery;
  final String? businessType;
  final String? category;
  final double? minRating;

  const FilterVendeursEvent({
    this.searchQuery,
    this.businessType,
    this.category,
    this.minRating,
  });

  @override
  List<Object> get props => [
        searchQuery ?? '',
        businessType ?? '',
        category ?? '',
        minRating ?? 0.0,
      ];
}

// Événement pour ajouter/supprimer un vendeur des favoris
class ToggleVendeurFavoriteEvent extends ShoppingPageEventM {
  final String vendeurId;

  const ToggleVendeurFavoriteEvent({required this.vendeurId});

  @override
  List<Object> get props => [vendeurId];
}
