import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/shoppingpageblocm/shoppingPageBlocM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/shoppingpageblocm/shoppingPageEventM.dart';
import 'package:sdealsapp/mobile/view/shoppingpagem/shoppingpageblocm/shoppingPageStateM.dart';
import 'package:sdealsapp/mobile/view/seller_registration/screens/seller_form_screen.dart';

class SellerRegistrationScreen extends StatelessWidget {
  const SellerRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShoppingPageBlocM()..add(LoadCategorieDataM()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Devenir Vendeur'),
          backgroundColor: Colors.amber.shade700,
        ),
        body: const _SellerRegistrationContent(),
      ),
    );
  }
}

class _SellerRegistrationContent extends StatefulWidget {
  const _SellerRegistrationContent({Key? key}) : super(key: key);

  @override
  _SellerRegistrationContentState createState() => _SellerRegistrationContentState();
}

class _SellerRegistrationContentState extends State<_SellerRegistrationContent> {
  final Set<String> _selectedCategories = {};
  final Set<String> _selectedProducts = {};
  int _estimatedSalesMin = 20;
  int _estimatedSalesMax = 50;
  int _estimatedRevenueMin = 200000;
  int _estimatedRevenueMax = 500000;

  @override
Widget build(BuildContext context) {
  return BlocBuilder<ShoppingPageBlocM, ShoppingPageStateM>(
    builder: (context, state) {
      if (state.isLoading ?? true) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state.listItems == null) {
        return const Center(child: Text('Une erreur est survenue.'));
      }

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(),
              const SizedBox(height: 32),
              _buildCategoriesSection(state.listItems!.toList()),
              const SizedBox(height: 32),
              _buildPopularProductsSection(),
              const SizedBox(height: 32),
              _buildProfitCalculator(),
              const SizedBox(height: 32),
              _buildSellerBenefits(),
              const SizedBox(height: 32),
              _buildCallToActionButtons(),
            ],
          ),
        ),
      );
    },
  );
}

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        children: [
          Text(
            'Ouvrez votre boutique en ligne et vendez partout en Côte d\'Ivoire',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('500+', 'Vendeurs actifs'),
              _buildStatCard('5%', 'Commission la plus basse'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(List<dynamic> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Que voulez-vous vendre ?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Sélectionnez les catégories qui correspondent à vos produits.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = _selectedCategories.contains(category.nomcategorie);
            
            // Déterminer l'icône basée sur le nom de catégorie
            IconData icon = Icons.category;
            if (category.nomcategorie.toLowerCase().contains('mode')) {
              icon = Icons.shopping_bag;
            } else if (category.nomcategorie.toLowerCase().contains('électro')) {
              icon = Icons.devices;
            } else if (category.nomcategorie.toLowerCase().contains('maison')) {
              icon = Icons.home;
            } else if (category.nomcategorie.toLowerCase().contains('beauté')) {
              icon = Icons.face;
            } else if (category.nomcategorie.toLowerCase().contains('sport')) {
              icon = Icons.sports_soccer;
            } else if (category.nomcategorie.toLowerCase().contains('informatique')) {
              icon = Icons.computer;
            }
              
            return InkWell(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedCategories.remove(category.nomcategorie);
                  } else {
                    _selectedCategories.add(category.nomcategorie);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.amber.shade100 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.amber.shade700 : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: isSelected ? Colors.amber.shade700 : Colors.grey.shade700,
                      size: 28,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category.nomcategorie,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.amber.shade700 : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '120+ produits • ~75k FCFA/vente',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPopularProductsSection() {
    // Liste des produits populaires (simulés)
    final popularProducts = [
      {'name': 'Smartphone 4G', 'category': 'Électronique', 'demand': 'Élevée', 'price': '125,000 FCFA'},
      {'name': 'Robe Wax', 'category': 'Mode', 'demand': 'Moyenne', 'price': '18,000 FCFA'},
      {'name': 'Montre connectée', 'category': 'Électronique', 'demand': 'Élevée', 'price': '35,000 FCFA'},
      {'name': 'Basket Nike', 'category': 'Mode', 'demand': 'Très élevée', 'price': '45,000 FCFA'},
      {'name': 'Maquillage Kit', 'category': 'Beauté', 'demand': 'Élevée', 'price': '12,000 FCFA'},
      {'name': 'Blender', 'category': 'Maison', 'demand': 'Moyenne', 'price': '22,000 FCFA'},
      {'name': 'TV Smart 32"', 'category': 'Électronique', 'demand': 'Très élevée', 'price': '135,000 FCFA'},
      {'name': 'Cafetière', 'category': 'Maison', 'demand': 'Moyenne', 'price': '15,000 FCFA'},
    ];

    // Filtrer les produits selon les catégories sélectionnées
    final filteredProducts = _selectedCategories.isEmpty
        ? popularProducts
        : popularProducts
            .where((product) => _selectedCategories.contains(product['category']))
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Types de produits demandés',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _selectedCategories.isEmpty
              ? 'Les produits les plus populaires et les plus vendus.'
              : 'Les produits les plus populaires dans vos catégories sélectionnées.',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        if (filteredProducts.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('Sélectionnez une catégorie pour voir les produits populaires.'),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              final isSelected = _selectedProducts.contains(product['name']);
              
              return CheckboxListTile(
                title: Text(
                  product['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        product['category']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('Demande: ${product['demand']}'),
                    const SizedBox(width: 8),
                    Text(product['price']!),
                  ],
                ),
                value: isSelected,
                activeColor: Colors.amber.shade700,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selectedProducts.add(product['name']!);
                    } else {
                      _selectedProducts.remove(product['name']!);
                    }
                    
                    // Recalculer les estimations de revenus
                    _updateRevenueEstimates();
                  });
                },
              );
            },
          ),
      ],
    );
  }

  void _updateRevenueEstimates() {
    // Calcul simplifié basé sur le nombre de catégories et produits sélectionnés
    final categoryMultiplier = _selectedCategories.length > 0 ? _selectedCategories.length : 1;
    final productMultiplier = _selectedProducts.length > 0 ? _selectedProducts.length : 1;
    
    _estimatedSalesMin = 10 + (categoryMultiplier * 5);
    _estimatedSalesMax = 30 + (categoryMultiplier * 10);
    
    _estimatedRevenueMin = 100000 + (productMultiplier * 20000);
    _estimatedRevenueMax = 300000 + (productMultiplier * 50000);
  }

  Widget _buildProfitCalculator() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calculate,
                color: Colors.amber.shade700,
              ),
              const SizedBox(width: 8),
              const Text(
                'Calculateur de bénéfices',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Avec ${_selectedCategories.length} catégories et ${_selectedProducts.length} produits sélectionnés:',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text('Commission SoutraliDeals: 5% par vente'),
          const SizedBox(height: 8),
          Text(
            'Bénéfice estimé: ${(_estimatedRevenueMin / 1000).toInt().toString().replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',')}k - ${(_estimatedRevenueMax / 1000).toInt().toString().replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',')}k FCFA/mois',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Basé sur $_estimatedSalesMin-$_estimatedSalesMax ventes/mois',
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerBenefits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Avantages vendeur',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildBenefitItem('Frais d\'inscription gratuits'),
        _buildBenefitItem('Livraison prise en charge'),
        _buildBenefitItem('Paiement sécurisé avec SoutraPay'),
        _buildBenefitItem('Support client dédié'),
      ],
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green.shade700,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToActionButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Rediriger vers le formulaire d'inscription
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SellerFormScreen(
                  preSelectedCategories: _selectedCategories,
                  preSelectedProducts: _selectedProducts,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Ouvrir ma boutique maintenant',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            // Afficher plus d'informations sur les conditions
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Frais et conditions'),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('• Commission fixe de 5% sur chaque vente'),
                      const SizedBox(height: 8),
                      const Text('• Paiement sous 48h après livraison confirmée'),
                      const SizedBox(height: 8),
                      const Text('• Retours client gérés par SoutraliDeals'),
                      const SizedBox(height: 8),
                      const Text('• Photos de qualité requises pour chaque produit'),
                      const SizedBox(height: 8),
                      const Text('• Engagement à expédier sous 24h après commande'),
                      const SizedBox(height: 16),
                      const Text(
                        'Les vendeurs doivent maintenir un taux de satisfaction de 4.5/5 minimum pour conserver leur statut actif.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Fermer'),
                  ),
                ],
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.amber.shade700,
            side: BorderSide(color: Colors.amber.shade700),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Voir les frais et conditions',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
