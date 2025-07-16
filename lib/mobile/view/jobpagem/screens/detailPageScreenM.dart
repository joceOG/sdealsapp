import 'package:flutter/material.dart';
import 'package:sdealsapp/mobile/view/common/widgets/ai_provider_matcher_widget.dart';

// Exemple de page de détails de service
class DetailPage extends StatelessWidget {
  final String title;
  final String image;

  const DetailPage({
    required this.title,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // Image principale du service
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          // Titre du service
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          // Description fictive (à remplacer par nos données API)
          const Text(
            "Description du service :\n"
            "Ce service est assuré par un professionnel qualifié. "
            "Contactez-nous pour plus de détails ou pour commander ce service.",
            style: TextStyle(fontSize: 15.5, color: Colors.black54),
          ),
          const SizedBox(height: 18),
          // Informations supplémentaires fictives
          const Row(
            children: [
              Icon(Icons.location_on, color: Colors.green, size: 20),
              SizedBox(width: 6),
              Text(
                "Disponible à : Abobo",
                style: TextStyle(fontSize: 14.5, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 6),
              Text(
                "Note : 4.8/5",
                style: TextStyle(fontSize: 14.5, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 28),
          // Recommandations IA de prestataires
          AIProviderMatcherWidget(
            serviceType: title,
            location: "Abidjan",
            preferences: const [],
          ),
          const SizedBox(height: 28),
          // Bouton commander
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.shopping_cart_checkout_rounded,
                  color: Colors.white),
              label: const Text(
                "Commander ce service",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              onPressed: () {
                // Action de commande (à personnaliser)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Commande envoyée !")),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
