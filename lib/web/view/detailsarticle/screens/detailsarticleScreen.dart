import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sdealsapp/web/widget/Footer.dart';
import 'package:sdealsapp/data/models/article.dart';
import '../../../widget/appbarwIdget/screens/AppBarWidget.dart';

class DetailsArticleScreen extends StatefulWidget {
  final Article article;
  const DetailsArticleScreen({required this.article, super.key});

  @override
  State<DetailsArticleScreen> createState() => _DetailsArticleScreenState();
}

class _DetailsArticleScreenState extends State<DetailsArticleScreen> {
  int _selectedImageIndex = 0;
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🎯 HERO SECTION MODERNE
            _buildHeroSection(),

            // 📱 CONTENU PRINCIPAL
            _buildMainContent(),

            // 🛍️ ARTICLES SIMILAIRES
            _buildSimilarArticlesSection(),

            // 🦶 FOOTER
            Footer(),
          ],
        ),
      ),
    );
  }

  // 🎯 HERO SECTION MODERNE
  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1CBF3F).withOpacity(0.1),
            const Color(0xFF16A34A).withOpacity(0.05),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Détails du produit',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Découvrez tous les détails de ce produit',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📱 CONTENU PRINCIPAL
  Widget _buildMainContent() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼️ GALERIE D'IMAGES
          Expanded(
            flex: 2,
            child: _buildImageGallery(),
          ),
          const SizedBox(width: 24),

          // 📋 INFORMATIONS PRODUIT
          Expanded(
            flex: 2,
            child: _buildProductInfo(),
          ),
          const SizedBox(width: 24),

          // 🛒 ACTIONS ET COMMANDE
          Expanded(
            flex: 1,
            child: _buildActionPanel(),
          ),
        ],
      ),
    );
  }

  // 🖼️ GALERIE D'IMAGES INTERACTIVE
  Widget _buildImageGallery() {
    return Column(
      children: [
        // Image principale
        Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: widget.article.photoArticle.isNotEmpty
                ? Image.network(
                    widget.article.photoArticle,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFF1F5F9),
                        child: const Icon(
                          Icons.shopping_bag,
                          size: 80,
                          color: Color(0xFF94A3B8),
                        ),
                      );
                    },
                  )
                : Container(
                    color: const Color(0xFFF1F5F9),
                    child: const Icon(
                      Icons.shopping_bag,
                      size: 80,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 16),

        // Miniatures
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Simuler 5 images
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImageIndex = index;
                  });
                },
                child: Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _selectedImageIndex == index
                          ? const Color(0xFF1CBF3F)
                          : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: widget.article.photoArticle.isNotEmpty
                        ? Image.network(
                            widget.article.photoArticle,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFFF1F5F9),
                                child: const Icon(
                                  Icons.shopping_bag,
                                  size: 30,
                                  color: Color(0xFF94A3B8),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: const Color(0xFFF1F5F9),
                            child: const Icon(
                              Icons.shopping_bag,
                              size: 30,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 📋 INFORMATIONS PRODUIT
  Widget _buildProductInfo() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nom du produit
          Text(
            widget.article.nomArticle,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),

          // Prix
          Row(
            children: [
              Text(
                widget.article.prixArticle,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1CBF3F),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '35,000 FCFA',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[500],
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Rating
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < 4 ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 20,
                  );
                }),
              ),
              const SizedBox(width: 8),
              Text(
                '(63 avis)',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Description
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Cette tondeuse à cheveux professionnelle est équipée d\'un moteur puissant et silencieux, offrant une coupe précise et régulière grâce à ses lames en acier inoxydable de haute qualité. Parfait pour un usage professionnel ou personnel.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),

          // Caractéristiques
          const Text(
            'Caractéristiques',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          _buildFeatureItem('Moteur puissant et silencieux'),
          _buildFeatureItem('Lames en acier inoxydable'),
          _buildFeatureItem('Batterie longue durée'),
          _buildFeatureItem('Design ergonomique'),
        ],
      ),
    );
  }

  // 🛒 PANEL D'ACTIONS
  Widget _buildActionPanel() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quantité
          const Text(
            'Quantité',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (_quantity > 1) {
                          setState(() {
                            _quantity--;
                          });
                        }
                      },
                      icon: const Icon(Icons.remove),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1E293B),
                      ),
                    ),
                    Container(
                      width: 60,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        _quantity.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                      icon: const Icon(Icons.add),
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFF1CBF3F),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Bouton d'achat principal
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                _showPurchaseDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1CBF3F),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Ajouter au panier',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Bouton d'achat immédiat
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: () {
                _showPurchaseDialog();
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1CBF3F),
                side: const BorderSide(color: Color(0xFF1CBF3F), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Acheter maintenant',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Bouton favori
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isFavorite ? 'Ajouté aux favoris' : 'Retiré des favoris',
                    ),
                    backgroundColor: _isFavorite ? Colors.green : Colors.grey,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: _isFavorite ? Colors.red : Colors.grey[600],
                side: BorderSide(
                  color: _isFavorite ? Colors.red : Colors.grey[300]!,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 20,
              ),
              label: Text(
                _isFavorite ? 'Dans les favoris' : 'Ajouter aux favoris',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Informations de livraison
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.local_shipping,
                      color: Color(0xFF1CBF3F),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Livraison gratuite',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Livraison sous 2-3 jours ouvrés',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🛍️ ARTICLES SIMILAIRES
  Widget _buildSimilarArticlesSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF1CBF3F),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Articles similaires',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildSimilarProductCard(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🛍️ CARTE PRODUIT SIMILAIRE
  Widget _buildSimilarProductCard(int index) {
    final products = [
      {
        'name': 'Perceuse',
        'price': '25,000 FCFA',
        'image': 'assets/autreArticle1.png'
      },
      {
        'name': 'Tondeuse',
        'price': '25,000 FCFA',
        'image': 'assets/autreArticle2.png'
      },
      {
        'name': 'Fil à coudre',
        'price': '25,000 FCFA',
        'image': 'assets/autreArticle3.png'
      },
      {
        'name': 'Lampe de table',
        'price': '25,000 FCFA',
        'image': 'assets/autreArticle4.png'
      },
      {
        'name': 'Lampe de table',
        'price': '25,000 FCFA',
        'image': 'assets/autreArticle4.png'
      },
    ];

    final product = products[index];

    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                color: const Color(0xFFF8FAFC),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  product['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFF8FAFC),
                      child: const Icon(
                        Icons.shopping_bag,
                        size: 40,
                        color: Color(0xFF94A3B8),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Informations
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product['price']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1CBF3F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Row(
                        children: List.generate(4, (starIndex) {
                          return Icon(
                            starIndex < 3 ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 14,
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 📋 ÉLÉMENT DE CARACTÉRISTIQUE
  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF1CBF3F),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            feature,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  // 💬 DIALOGUE D'ACHAT
  void _showPurchaseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter au panier'),
        content: Text(
            'Voulez-vous ajouter "${widget.article.nomArticle}" au panier ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('${widget.article.nomArticle} ajouté au panier'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1CBF3F),
              foregroundColor: Colors.white,
            ),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }
}
