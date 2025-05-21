import 'package:flutter/material.dart';

import 'panierProductScreenM.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d'application en haut (AppBar)
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Détails',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),

      // Contenu principal
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image du produit
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/adidas.jpg',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Titre du produit
              const Text(
                'Chaussure  Adidas Originals Superstar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),

              // Marque et lien vers produits similaires
              Row(
                children: [
                  const Text(
                    'Marque: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Adidas',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const Text(' | '),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      'Produits similaires',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),

              // Prix du produit
              const Text(
                '4,750 FCFA',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(height: 8.0),

              // Disponibilité du stock
              const Row(
                children: [
                  Text(
                    'Stock limité :',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.warning, color: Colors.red, size: 16),
                  SizedBox(width: 4),
                  Text(
                    '7 articles seulement',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),

              // Livraison et options
              const Text(
                '+ Livraison à partir de 300 FCFA vers Plateau ',
                style: TextStyle(color: Colors.black87),
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Options',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 8.0),

              // Évaluation du produit (notation étoiles)
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return const Icon(Icons.star,
                        color: Colors.orange, size: 18);
                  }),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      '  4.5 (2,500 avis)',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.share, color: Colors.green),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border,
                            color: Colors.green),
                        onPressed: () {},
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(height: 8.0),

              // Variation (Couleur du produit)
              const Text(
                'VARIATION',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text('NOIRE', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text('BLANC', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Bouton d'achat
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PanierProductScreenM(),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Produit ajouté au panier !')),
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  label: const Text('Achetez', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Couleur du bouton
                    foregroundColor: Colors.white, // Texte en blanc
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
