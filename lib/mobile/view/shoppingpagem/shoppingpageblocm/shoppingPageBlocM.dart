import 'package:sdealsapp/mobile/view/shoppingpagem/shoppingpageblocm/shoppingPageEventM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/shoppingpageblocm/shoppingPageStateM.dart';

import 'package:bloc/bloc.dart';

import '../../../../web/data/models/categorie.dart';
import '../../../../web/data/services/api_client.dart';

class ShoppingPageBlocM extends Bloc<ShoppingPageEventM, ShoppingPageStateM> {
  ShoppingPageBlocM() : super(ShoppingPageStateM.initial()) {
    // Events originaux
    on<LoadCategorieDataM>(_onLoadCategorieDataM);
    
    // Nouveaux events pour produits et filtrage
    on<LoadProductsEvent>(_onLoadProductsEvent);
    on<ApplyFilterEvent>(_onApplyFilterEvent);
    on<SearchProductsEvent>(_onSearchProductsEvent);
    on<ApplyPriceRangeEvent>(_onApplyPriceRangeEvent);
    on<SelectBrandEvent>(_onSelectBrandEvent);
    on<SelectConditionEvent>(_onSelectConditionEvent);
    on<SelectDeliveryEvent>(_onSelectDeliveryEvent);
    on<SelectLocationEvent>(_onSelectLocationEvent);
    on<ResetFiltersEvent>(_onResetFiltersEvent);
    
    // Events pour les favoris
    on<ToggleFavoriteEvent>(_onToggleFavoriteEvent);
    
    // Events pour la comparaison
    on<AddToCompareEvent>(_onAddToCompareEvent);
    on<RemoveFromCompareEvent>(_onRemoveFromCompareEvent);
    on<ClearCompareListEvent>(_onClearCompareListEvent);
  }

  // Event handler d'origine pour charger les catégories
  Future<void> _onLoadCategorieDataM(
    LoadCategorieDataM event,
    Emitter<ShoppingPageStateM> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    ApiClient apiClient = ApiClient();
    try {
      var nomgroupe = "Métiers";
      List<Categorie> list_categorie = await apiClient.fetchCategorie(nomgroupe);
      emit(state.copyWith(listItems: list_categorie, isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

  // NOUVEAUX GESTIONNAIRES D'ÉVÉNEMENTS
  
  // Gérer le chargement des produits
  Future<void> _onLoadProductsEvent(
    LoadProductsEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    
    try {
      // Dans une vraie application, on chargerait les produits depuis l'API
      // Pour l'instant on utilise une liste statique de produits mockup
      List<Product> mockProducts = [
        Product(
            id: '1',
            name: 'Nike Air Max',
            image: 'assets/products/1.png',
            size: 'Pointures 42-43',
            price: '25.000 Fcfa',
            brand: 'Nike'),
        Product(
            id: '2',
            name: 'Adidas Superstar',
            image: 'assets/products/2.png',
            size: 'Pointures 42-43',
            price: '30.000 Fcfa',
            brand: 'Adidas',
            isFavorite: false),
        Product(
            id: '3',
            name: 'Puma Suede',
            image: 'assets/products/3.png',
            size: 'Pointures 40-44',
            price: '22.000 Fcfa',
            brand: 'Puma'),
        Product(
            id: '4',
            name: 'Reebok Classic',
            image: 'assets/products/4.png',
            size: 'Pointures 41-45',
            price: '28.000 Fcfa',
            brand: 'Reebok',
            isFavorite: false),
        Product(
            id: '5',
            name: 'Fila Disruptor',
            image: 'assets/products/5.png',
            size: 'Pointures 39-43',
            price: '20.000 Fcfa',
            brand: 'Fila'),
        Product(
            id: '6',
            name: 'Converse Chuck Taylor',
            image: 'assets/products/6.png',
            size: 'Pointures 38-42',
            price: '27.000 Fcfa',
            brand: 'Converse'),
        Product(
            id: '7',
            name: 'Vans Old Skool',
            image: 'assets/products/7.png',
            size: 'Pointures 40-44',
            price: '24.000 Fcfa',
            brand: 'Vans'),
        Product(
            id: '8',
            name: 'New Balance 574',
            image: 'assets/products/8.png',
            size: 'Pointures 41-45',
            price: '29.000 Fcfa',
            brand: 'New Balance'),
        Product(
            id: '9',
            name: 'Asics Gel Lyte',
            image: 'assets/products/9.png',
            size: 'Pointures 40-43',
            price: '23.000 Fcfa',
            brand: 'Asics'),
        Product(
            id: '10',
            name: 'Air Jordan 4',
            image: 'assets/products/10.png',
            size: 'Pointures 42-46',
            price: '35.000 Fcfa',
            brand: 'Jordan',
            rating: 4.9),
      ];
      
      emit(state.copyWith(
        products: mockProducts, 
        filteredProducts: mockProducts, 
        isLoading: false
      ));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

  // Méthode pour filtrer les produits selon les critères actuels
  List<Product> _applyFilters(List<Product> products) {
    if (products.isEmpty) return [];
    
    // Commencer avec tous les produits
    List<Product> filteredList = List.from(products);
    
    // Appliquer filtre par recherche
    if (state.searchQuery != null && state.searchQuery!.isNotEmpty) {
      final query = state.searchQuery!.toLowerCase();
      filteredList = filteredList.where((product) => 
        product.name.toLowerCase().contains(query) || 
        product.brand.toLowerCase().contains(query)
      ).toList();
    }
    
    // Appliquer filtre par marque
    if (state.selectedBrand != null && state.selectedBrand!.isNotEmpty) {
      filteredList = filteredList.where((product) => 
        product.brand == state.selectedBrand
      ).toList();
    }
    
    // Autres filtres seraient appliqués de la même manière
    // Pour la plage de prix, on devrait convertir les string price en double
    
    return filteredList;
  }

  // Gérer l'application d'un filtre général
  void _onApplyFilterEvent(
    ApplyFilterEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    emit(state.copyWith(selectedFilter: event.filterName));
    
    // Réappliquer tous les filtres
    final filteredProducts = _applyFilters(state.products ?? []);
    emit(state.copyWith(filteredProducts: filteredProducts));
  }
  
  // Gérer la recherche
  void _onSearchProductsEvent(
    SearchProductsEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
    
    // Réappliquer tous les filtres
    final filteredProducts = _applyFilters(state.products ?? []);
    emit(state.copyWith(filteredProducts: filteredProducts));
  }
  
  // Gérer le filtre de plage de prix
  void _onApplyPriceRangeEvent(
    ApplyPriceRangeEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    emit(state.copyWith(priceRange: event.priceRange));
    
    // Réappliquer tous les filtres
    final filteredProducts = _applyFilters(state.products ?? []);
    emit(state.copyWith(filteredProducts: filteredProducts));
  }
  
  // Gérer le filtre par marque
  void _onSelectBrandEvent(
    SelectBrandEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    emit(state.copyWith(selectedBrand: event.brand));
    
    // Réappliquer tous les filtres
    final filteredProducts = _applyFilters(state.products ?? []);
    emit(state.copyWith(filteredProducts: filteredProducts));
  }
  
  // Gérer le filtre par état
  void _onSelectConditionEvent(
    SelectConditionEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    emit(state.copyWith(selectedCondition: event.condition));
    
    // Réappliquer tous les filtres
    final filteredProducts = _applyFilters(state.products ?? []);
    emit(state.copyWith(filteredProducts: filteredProducts));
  }
  
  // Gérer le filtre par livraison
  void _onSelectDeliveryEvent(
    SelectDeliveryEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    emit(state.copyWith(selectedDelivery: event.delivery));
    
    // Réappliquer tous les filtres
    final filteredProducts = _applyFilters(state.products ?? []);
    emit(state.copyWith(filteredProducts: filteredProducts));
  }
  
  // Gérer le filtre par localisation
  void _onSelectLocationEvent(
    SelectLocationEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    emit(state.copyWith(selectedLocation: event.location));
    
    // Réappliquer tous les filtres
    final filteredProducts = _applyFilters(state.products ?? []);
    emit(state.copyWith(filteredProducts: filteredProducts));
  }
  
  // Réinitialiser tous les filtres
  void _onResetFiltersEvent(
    ResetFiltersEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    emit(state.copyWith(
      selectedFilter: '',
      searchQuery: '',
      selectedBrand: null,
      priceRange: null,
      selectedCondition: null,
      selectedDelivery: null,
      selectedLocation: null,
      filteredProducts: state.products, // Remettre tous les produits
    ));
  }
  
  // Gérer les favoris
  void _onToggleFavoriteEvent(
    ToggleFavoriteEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    final List<String> updatedFavorites = List.from(state.favoriteProductIds ?? []);
    
    // Vérifier si le produit est déjà dans les favoris
    if (updatedFavorites.contains(event.productId)) {
      updatedFavorites.remove(event.productId);
    } else {
      updatedFavorites.add(event.productId);
    }
    
    // Mettre à jour la liste des favoris
    emit(state.copyWith(favoriteProductIds: updatedFavorites));
    
    // Mettre à jour les produits pour refléter le changement
    if (state.products != null) {
      final updatedProducts = state.products!.map((product) {
        if (product.id == event.productId) {
          // Créer un nouveau produit avec isFavorite inversé
          return Product(
            id: product.id,
            name: product.name,
            image: product.image,
            size: product.size,
            price: product.price,
            brand: product.brand,
            isFavorite: updatedFavorites.contains(product.id),
            rating: product.rating,
          );
        }
        return product;
      }).toList();
      
      // Mettre à jour également les produits filtrés si nécessaire
      final updatedFilteredProducts = _applyFilters(updatedProducts);
      
      emit(state.copyWith(
        products: updatedProducts,
        filteredProducts: updatedFilteredProducts,
      ));
    }
  }
  
  // Gérer l'ajout d'un produit à la liste de comparaison
  void _onAddToCompareEvent(
    AddToCompareEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    // Limite de 4 produits max pour la comparaison
    if ((state.productsToCompare?.length ?? 0) >= 4) {
      return; // Ne pas ajouter plus de 4 produits
    }
    
    // Vérifier si le produit est déjà dans la liste de comparaison
    final existingProducts = state.productsToCompare ?? [];
    if (existingProducts.any((p) => p.id == event.product.id)) {
      return; // Produit déjà dans la liste
    }
    
    // Ajouter le produit à la liste de comparaison
    final List<Product> updatedCompareList = List.from(existingProducts);
    updatedCompareList.add(event.product);
    
    emit(state.copyWith(productsToCompare: updatedCompareList));
  }
  
  // Gérer le retrait d'un produit de la liste de comparaison
  void _onRemoveFromCompareEvent(
    RemoveFromCompareEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    final existingProducts = state.productsToCompare ?? [];
    final updatedCompareList = existingProducts.where((p) => p.id != event.productId).toList();
    
    emit(state.copyWith(productsToCompare: updatedCompareList));
  }
  
  // Vider la liste de comparaison
  void _onClearCompareListEvent(
    ClearCompareListEvent event,
    Emitter<ShoppingPageStateM> emit,
  ) {
    emit(state.copyWith(productsToCompare: []));
  }
}