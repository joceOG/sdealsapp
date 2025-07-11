import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../shoppingpageblocm/shoppingPageBlocM.dart';
import '../shoppingpageblocm/shoppingPageEventM.dart';
import '../shoppingpageblocm/shoppingPageStateM.dart' as bloc_model;
import 'productDetailsScreenM.dart';
import 'panierProductScreenM.dart';

// Utilisation du modèle Product du BLoC
typedef Product = bloc_model.Product;

class ShoppingPageScreenM extends StatefulWidget {
  const ShoppingPageScreenM({Key? key}) : super(key: key);

  @override
  State<ShoppingPageScreenM> createState() => _ShoppingPageScreenMState();
}

class _ShoppingPageScreenMState extends State<ShoppingPageScreenM> {
  int cartItemCount = 2; // Nombre d'articles dans le panier
  bool hasSoutraPayBalance = true; // Solde disponible sur SoutraPay
  bool isCompareDialogOpen = false; // Dialog de comparaison ouvert ou fermé
  // Note: selectedFilter sera maintenant géré par le BLoC

  // Liste de produits fictifs (remplacer par nos données API)
  List<Product> get products => [
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
            isFavorite: true),
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
            isFavorite: true),
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

  // Liste de catégories fictives (remplacer par nos données API)
  final List<Map<String, dynamic>> categories = [
    {'name': 'Auto & Moto', 'icon': Icons.directions_car},
    {'name': 'Immobilier', 'icon': Icons.house},
    {'name': 'Électronique', 'icon': Icons.electrical_services},
    {'name': 'Mode', 'icon': Icons.style},
    {'name': 'Maison', 'icon': Icons.chair},
    {'name': 'Sport', 'icon': Icons.sports_soccer},
    {'name': 'Jeux', 'icon': Icons.videogame_asset},
    {'name': 'Santé', 'icon': Icons.health_and_safety},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. AppBar avec bouton SoutraPay et icône panier
      appBar: AppBar(
        title: const Text('Shopping Soutrali', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          // Bouton SoutraPay avec badge si solde disponible
          InkWell(
            onTap: () {
              context.go('/wallet'); // Navigation vers la page SoutraPay
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.amber[700],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(Icons.account_balance_wallet, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  const Text('SoutraPay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  // Badge conditionnel si solde disponible
                  if (hasSoutraPayBalance)
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.only(left: 4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Text('!', style: TextStyle(color: Colors.white, fontSize: 10)),
                    )
                ],
              ),
            ),
          ),
          // Icône panier avec badge
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const PanierProductScreenM())
                  );
                },
              ),
              if (cartItemCount > 0)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartItemCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      // 2. Bouton "Devenir Vendeur"
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigation vers la page pour devenir vendeur
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fonctionnalité "Devenir Vendeur" à venir !'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: Colors.green,
        icon: const Icon(Icons.storefront),
        label: const Text('Vendre sur Soutrali'),
      ),
      body: BlocProvider(
        create: (_) => ShoppingPageBlocM()
          ..add(LoadCategorieDataM())
          ..add(LoadProductsEvent()), // Charger les produits au démarrage
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Liste horizontale de catégories
                SizedBox(
                  height: 90,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return _buildCategoryCard(cat['name'], cat['icon']);
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // 3. Filtres avancés
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Filtres avancés',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFilterChip('Prix', Icons.monetization_on),
                      _buildFilterChip('Marque', Icons.branding_watermark),
                      _buildFilterChip('État', Icons.inventory_2),
                      _buildFilterChip('Livraison', Icons.local_shipping),
                      _buildFilterChip('Localisation', Icons.location_on),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Barre de recherche avec intégration BLoC
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Rechercher un produit...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.filter_alt),
                      onPressed: () => _showAdvancedFilterDialog(context),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    // Envoyer l'événement de recherche au BLoC
                    context.read<ShoppingPageBlocM>().add(SearchProductsEvent(value));
                  },
                ),
                const SizedBox(height: 12),
                
                // Titre de la section produits
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Articles populaires',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    BlocBuilder<ShoppingPageBlocM, bloc_model.ShoppingPageStateM>(
                      builder: (context, state) {
                        return TextButton.icon(
                          onPressed: () {
                            // Ouvrir le dialog de comparaison uniquement si des produits sont sélectionnés
                            if ((state.productsToCompare?.isNotEmpty ?? false)) {
                              setState(() {
                                isCompareDialogOpen = true;
                              });
                              _showCompareDialog(context, state.productsToCompare!);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sélectionnez des produits à comparer (max. 4)'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.compare_arrows, size: 18),
                          label: Text(
                            'Comparer ${state.productsToCompare?.length ?? 0}/4',
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.green,
                            padding: EdgeInsets.zero,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Grille de produits scrollable avec BlocBuilder
                Expanded(
                  child: BlocBuilder<ShoppingPageBlocM, bloc_model.ShoppingPageStateM>(
                    builder: (context, state) {
                      if (state.isLoading ?? false) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      
                      if (state.error != null) {
                        return Center(
                          child: Text(
                            'Erreur: ${state.error}',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      
                      final displayProducts = state.filteredProducts ?? state.products ?? [];
                      
                      if (displayProducts.isEmpty) {
                        return const Center(
                          child: Text('Aucun produit trouvé'),
                        );
                      }
                      
                      return GridView.builder(
                        itemCount: displayProducts.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 produits par ligne
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.72, // Ajuste la hauteur des cartes
                        ),
                        itemBuilder: (context, index) {
                          final product = displayProducts[index];
                          return _buildProductCard(context, product);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Widget pour une carte de catégorie
  Widget _buildCategoryCard(String categoryName, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.green.withOpacity(0.15),
          child: Icon(icon, size: 28, color: Colors.green),
        ),
        const SizedBox(height: 6),
        Text(
          categoryName,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
  
  /// Widget pour un filtre
  Widget _buildFilterChip(String label, IconData icon) {
    return BlocBuilder<ShoppingPageBlocM, bloc_model.ShoppingPageStateM>(
      builder: (context, state) {
        bool isSelected = state.selectedFilter == label;
        
        return Container(
          margin: const EdgeInsets.only(right: 8),
          child: FilterChip(
            avatar: Icon(icon, size: 16, color: isSelected ? Colors.white : Colors.green),
            label: Text(label),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 12,
            ),
            selected: isSelected,
            onSelected: (selected) {
              // Utiliser le BLoC pour changer le filtre sélectionné
              context.read<ShoppingPageBlocM>().add(
                ApplyFilterEvent(selected ? label : '')
              );
            },
            backgroundColor: Colors.grey.shade200,
            selectedColor: Colors.green,
          ),
        );
      },
    );
  }

  /// Affiche un dialog de comparaison entre plusieurs produits
  void _showCompareDialog(BuildContext context, List<Product> productsToCompare) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Comparer les produits'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: productsToCompare.map((product) => 
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(product.image, height: 80),
                      const SizedBox(height: 8),
                      Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(product.price),
                      Text('Taille: ${product.size}'),
                      Text('Marque: ${product.brand}'),
                      const SizedBox(height: 8),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          // Suppression du produit de la comparaison
                          context.read<ShoppingPageBlocM>().add(RemoveFromCompareEvent(product.id));
                          if (productsToCompare.length <= 1) {
                            Navigator.of(context).pop(); // Fermer le dialog si c'est le dernier produit
                          }
                        },
                      ),
                    ],
                  ),
                )
              ).toList(),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Fermer'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Vider la liste'),
            onPressed: () {
              context.read<ShoppingPageBlocM>().add(ClearCompareListEvent());
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ).then((_) => setState(() => isCompareDialogOpen = false));
  }

  /// Widget pour une carte produit minimaliste
  Widget _buildProductCard(BuildContext context, Product product) {
    return BlocBuilder<ShoppingPageBlocM, bloc_model.ShoppingPageStateM>(
      builder: (context, state) {
        // Vérifier si le produit est dans les favoris
        final bool isFavorite = state.favoriteProductIds?.contains(product.id) ?? false;
        // Vérifier si le produit est dans la liste de comparaison
        final bool isInCompare = state.productsToCompare?.any((p) => p.id == product.id) ?? false;
        
        return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const ProductDetails(),
            // Dans une version future, on pourrait passer les détails du produit
            // via un constructeur modifié dans ProductDetails
          )),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge de la marque
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.contain,
                        height: 120,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Text(
                          product.brand,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Bouton favoris avec BLoC
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          // Utiliser le BLoC pour ajouter/retirer des favoris
                          context.read<ShoppingPageBlocM>().add(ToggleFavoriteEvent(product.id));
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isFavorite
                                    ? '${product.name} retiré des favoris!'
                                    : '${product.name} ajouté aux favoris!',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ),
                    // Indicateur de comparaison
                    if (isInCompare)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.8),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                            ),
                          ),
                          child: const Icon(Icons.compare_arrows, color: Colors.white, size: 16),
                        ),
                      ),
                  ],
                ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom du produit
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Taille du produit
                  Text(
                    product.size,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  // Évaluation
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          index < product.rating.floor() ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Prix
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      ),
                      // Rangée de boutons
                      Row(
                        children: [
                          // Bouton comparer
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () {
                                // Ajouter/retirer de la liste de comparaison via le BLoC
                                if (isInCompare) {
                                  context.read<ShoppingPageBlocM>().add(RemoveFromCompareEvent(product.id));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product.name} retiré de la comparaison'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                } else {
                                  context.read<ShoppingPageBlocM>().add(AddToCompareEvent(product));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product.name} ajouté à la comparaison'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: isInCompare ? Colors.blue : Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(Icons.compare_arrows, color: Colors.white, size: 16),
                              ),
                            ),
                          ),
                          // Bouton ajouter au panier
                          InkWell(
                            onTap: () {
                              setState(() {
                                cartItemCount++;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product.name} ajouté au panier!'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
      },
    );
  }
  
  /// Affiche une boîte de dialogue avec des filtres avancés
  void _showAdvancedFilterDialog(BuildContext context) {
    // Variables pour stocker les valeurs des filtres temporairement
    RangeValues _priceRange = const RangeValues(0, 1000);
    String _selectedBrand = '';
    String _selectedSize = '';
    bool _onlyInStock = false;
    
    // Liste des marques disponibles (exemple statique)
    final brands = ['Nike', 'Adidas', 'Jordan', 'Puma', 'Reebok'];
    // Liste des tailles disponibles (exemple statique)
    final sizes = ['S', 'M', 'L', 'XL', 'XXL'];
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: const Text('Filtres avancés'),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filtre de prix avec slider
                  const Text('Prix', style: TextStyle(fontWeight: FontWeight.bold)),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    labels: RangeLabels(
                      "${_priceRange.start.round()} €",
                      "${_priceRange.end.round()} €",
                    ),
                    onChanged: (values) {
                      setStateDialog(() {
                        _priceRange = values;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Filtre de marque avec dropdown
                  const Text('Marque', style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: _selectedBrand.isEmpty ? null : _selectedBrand,
                    hint: const Text('Sélectionner une marque'),
                    isExpanded: true,
                    items: brands.map((String brand) {
                      return DropdownMenuItem<String>(
                        value: brand,
                        child: Text(brand),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        setStateDialog(() {
                          _selectedBrand = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Filtre de taille avec chips
                  const Text('Taille', style: TextStyle(fontWeight: FontWeight.bold)),
                  Wrap(
                    spacing: 8.0,
                    children: sizes.map((size) => FilterChip(
                      label: Text(size),
                      selected: _selectedSize == size,
                      onSelected: (selected) {
                        setStateDialog(() {
                          _selectedSize = selected ? size : '';
                        });
                      },
                    )).toList(),
                  ),
                  const SizedBox(height: 16),
                  
                  // Option "En stock uniquement"
                  CheckboxListTile(
                    title: const Text('En stock uniquement'),
                    value: _onlyInStock,
                    onChanged: (value) {
                      if (value != null) {
                        setStateDialog(() {
                          _onlyInStock = value;
                        });
                      }
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Annuler'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Appliquer'),
              onPressed: () {
                // Appliquer les filtres via le BLoC
                context.read<ShoppingPageBlocM>().add(
                  ApplyAdvancedFiltersEvent(
                    minPrice: _priceRange.start,
                    maxPrice: _priceRange.end,
                    brand: _selectedBrand.isEmpty ? null : _selectedBrand,
                    size: _selectedSize.isEmpty ? null : _selectedSize,
                    onlyInStock: _onlyInStock,
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
