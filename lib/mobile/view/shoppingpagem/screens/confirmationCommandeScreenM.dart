import 'package:flutter/material.dart';

class ConfirmationCommandeScreen extends StatelessWidget {
  const ConfirmationCommandeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Passez votre commande"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Message d'information
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[200],
              child: const Text(
                "Si vous continuez, vous acceptez automatiquement notre",
                style: TextStyle(fontSize: 14),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Termes et Conditions",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // RÉSUMÉ DE COMMANDE
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Résumé de commande",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  rowItem("Total articles (2)", "75,590 FCFA"),
                  rowItem("Frais de livraison", "800 FCFA"),
                  const Divider(),
                  rowItem(
                    "Total",
                    "76,390 FCFA",
                    isBold: true,
                  ),
                  const SizedBox(height: 10),

                  // Champ de code promo
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Entrez votre code ici",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            prefixIcon: const Icon(Icons.card_giftcard),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: const Text("Appliquer"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // MODE DE PAIEMENT
            sectionTitle("Mode de Paiement", isGreen: true), // ✅ En vert
            const ListTile(
              title: Text("Payer cash à la livraison."),
              subtitle: Text(
                "Réglez vos achats en espèces directement à la livraison. Nous n'acceptons que les Francs CFA.",
              ),
              trailing: Text(
                "Modifier",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            // ADRESSE DE LIVRAISON
            sectionTitle("Adresse", isGreen: true), // ✅ En vert
            const ListTile(
              title: Text("Afisu Yussuf"),
              subtitle: Text("Grand Mosquée du Plateau"),
              trailing: Text(
                "Changer Votre Adresse",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            // LIVRAISON
            sectionTitle("Livraison", isGreen: true), // ✅ En vert
            const ListTile(
              leading: Icon(Icons.local_shipping, color: Colors.green),
              title: Text("Point Relais"),
              subtitle: Text("Livraison entre le 11 février et le 14 février"),
              trailing: Text(
                "Modifier",
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            // BOUTON CONFIRMATION COMMANDE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () {
                  // Logique pour confirmer la commande
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Confirmer La Commande",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher les lignes du résumé de commande
  Widget rowItem(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 15,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 15,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }

  // Widget pour les titres des sections (ex: Mode de paiement, Adresse, Livraison)
  Widget sectionTitle(String title, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isGreen
              ? Colors.green
              : Colors
                  .black, // Texte en vert pour "Mode de paiement", "Adresse", "Livraison"
        ),
      ),
    );
  }
}
